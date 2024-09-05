import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:obviously_test_final/app/helpers/helper_functions.dart';
import 'package:obviously_test_final/app/helpers/navigation_helper.dart';
import 'package:obviously_test_final/app/screens/confirmation_screen.dart';
import 'package:obviously_test_final/features/payment/bloc/payment_bloc.dart';
import 'package:obviously_test_final/features/payment/bloc/payment_event.dart';
import 'package:obviously_test_final/features/payment/bloc/payment_state.dart';
import 'package:obviously_test_final/features/payment/view/amount_input_screen.dart';
import 'package:obviously_test_final/features/payment/view/recipient_screen.dart';
import 'package:obviously_test_final/features/transactions/models/transaction_model.dart';

class PaymentFlow extends StatelessWidget {
  final TransactionType transactionType;
  const PaymentFlow({super.key, required this.transactionType});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bloc = context.read<PaymentBloc>();
    return BlocBuilder<PaymentBloc, PaymentState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor:
              theme.primaryColor, // Background color from the screenshot
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              state.pageIndex == 0
                  ? 'MoneyApp'
                  : 'Send £${formatTo2DP(number: state.currentAmount)}',
            ),
            centerTitle: true,
            leading: Container(),
            actions: [
              IconButton(
                icon: CircleAvatar(
                    backgroundColor: Colors.white,
                    maxRadius: 12,
                    child: Icon(
                      state.pageIndex == 0
                          ? Icons.close
                          : Icons.arrow_upward_outlined,
                      color: theme.primaryColor,
                      size: 18,
                    )),
                onPressed: () {
                  // Add any close action
                  if (state.pageIndex == 0) {
                    NavigationHelper.instance.back(context: context);
                    bloc.add(ResetBloc());
                  } else {
                    bloc.add(NavigatePage(index: 0));
                  }
                },
              ),
            ],
          ),
          body: PageView(
              scrollDirection: Axis.vertical,
              controller: state.paymentPageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                AmountInputScreen(
                  currentAmount: state.currentAmount,
                  transationType: transactionType,
                  canNavigate: state.currentAmount > 0,
                  onNextTap: () {
                    if (transactionType == TransactionType.sentPayment) {
                      context.read<PaymentBloc>().add(NavigatePage(index: 1));
                    } else {
                      NavigationHelper.instance.to(
                          context: context,
                          page: ConfirmationScreen(
                            icon: const Icon(
                              Icons.add_box_rounded,
                              size: 50,
                            ),
                            message:
                                'Add £${formatTo2DP(number: state.currentAmount)} to balance?',
                            confirmationMessage:
                                '£${formatTo2DP(number: state.currentAmount)} added to your balance.',
                            confirmationTitle: 'Success!',
                            onTapText: 'Confirm',
                            onTap: () {
                              NavigationHelper.instance.back(context: context);
                              NavigationHelper.instance.back(
                                  context: context,
                                  result: TransactionModel(
                                    amount: state.currentAmount,
                                    date: DateTime.now(),
                                    type: TransactionType.topUp,
                                    id: 'topup${DateTime.now()}',
                                  ));

                               bloc.add(ResetBloc());
                            },
                          ));
                    }
                  },
                  onkeyboardInput: (input) {
                    bloc.add(HandleKeyboardInput(input: input));
                  },
                ),
                RecipientScreen(
                  canPay: state.recipientName.isNotEmpty,
                  onPayTap: () {
                    NavigationHelper.instance.to(
                        context: context,
                        page: ConfirmationScreen(
                          icon: const Icon(Icons.send, size: 50),
                          message:
                              'Send £${formatTo2DP(number: state.currentAmount)} to ${state.recipientName}?',
                          confirmationMessage:
                              '£${formatTo2DP(number: state.currentAmount)} sent to ${state.recipientName}.',
                          confirmationTitle: 'Success!',
                          onTapText: 'Send',
                          onTap: () {
                            NavigationHelper.instance.back(context: context);
                            NavigationHelper.instance.back(
                                context: context,
                                result: TransactionModel(
                                    amount: state.currentAmount,
                                    date: DateTime.now(),
                                    type: TransactionType.sentPayment,
                                    id: '${state.recipientName}${DateTime.now()}',
                                    counterParty: state.recipientName));

                            bloc.add(ResetBloc());
                          },
                        ));
                  },
                  onkeyboardInput: (input) {
                    bloc.add(UpdateRecipientName(input: input));
                  },
                )
              ]),
        );
      },
    );
  }
}
