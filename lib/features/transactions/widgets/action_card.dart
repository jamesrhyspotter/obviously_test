import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:obviously_test_final/app/helpers/navigation_helper.dart';
import 'package:obviously_test_final/features/payment/view/payment_flow.dart';
import 'package:obviously_test_final/features/transactions/bloc/transaction_bloc.dart';
import 'package:obviously_test_final/features/transactions/bloc/transaction_event.dart';
import 'package:obviously_test_final/features/transactions/bloc/transaction_state.dart';
import 'package:obviously_test_final/features/transactions/models/transaction_model.dart';
import 'package:obviously_test_final/themes/asset_constants.dart';
import 'package:obviously_test_final/features/transactions/widgets/labelled_icon_button.dart';

class ActionCard extends StatelessWidget {
  const ActionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        Bloc bloc = context.read<TransactionBloc>();
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: DelayedDisplay(
            delay: const Duration(milliseconds: 500),
            child: Card(
              child: SizedBox(
                height: 105,
                width: MediaQuery.of(context).size.width,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      LabelledAssetButton(
                          label: 'Pay',
                          key: const Key('payButton'),
                          onTap: () async {
                            TransactionModel? outputTransaction =
                                await NavigationHelper.instance.toWithResult(
                                    context: context,
                                    page: const PaymentFlow(
                                      transactionType:
                                          TransactionType.sentPayment,
                                    ));

                            if (outputTransaction?.id != null) {
                              debugPrint('$outputTransaction');
                              bloc.add(SaveTransaction(
                                  transaction: outputTransaction!));
                            }
                          },
                          assetPath: payAssetPath),
                      LabelledAssetButton(
                          label: 'Top Up',
                          key: const Key('topUpButton'),
                          onTap: () async {
                            TransactionModel? outputTransaction =
                                await NavigationHelper.instance.toWithResult(
                                    context: context,
                                    page: const PaymentFlow(
                                      transactionType: TransactionType.topUp,
                                    ));

                            if (outputTransaction?.id != null) {
                              debugPrint('$outputTransaction');
                              bloc.add(SaveTransaction(
                                  transaction: outputTransaction!));
                            }
                          },
                          assetPath: topUpAssetPath)
                    ]),
              ),
            ),
          ),
        );
      },
    );
  }
}
