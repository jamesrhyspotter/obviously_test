import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:obviously_test_final/app/widgets/balance_text.dart';
import 'package:obviously_test_final/app/widgets/keypad.dart';
import 'package:obviously_test_final/features/transactions/models/transaction_model.dart';

class AmountInputScreen extends StatelessWidget {
  final double currentAmount;
  final Function(String) onkeyboardInput;
  final Function onNextTap;
  final bool canNavigate;
  final TransactionType transationType;

  const AmountInputScreen(
      {super.key,
      required this.currentAmount,
      required this.onkeyboardInput,
      required this.onNextTap,
      required this.canNavigate,
      required this.transationType});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
            child: Center(
                child:
                    Text('How much?', style: theme.textTheme.displayMedium))),
        Expanded(child: BalanceText(amount: currentAmount)),
        Expanded(
            flex: 2,
            child: KeyPad(
              handleInput: (input) {
                onkeyboardInput(input);
              },
            )),
        AnimatedOpacity(
          duration: const Duration(milliseconds: 250),
          opacity: canNavigate ? 1 : 0.5,
          child: Padding(
            padding: const EdgeInsets.all(60.0),
            child: ElevatedButton(
              onPressed: () {
                if (canNavigate) {
                  HapticFeedback.lightImpact();
                  onNextTap();
                }
              },
              child: Center(
                child: Text(
                  transationType == TransactionType.sentPayment
                      ? 'Next'
                      : 'Top Up',
                  style: theme.textTheme.displaySmall,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
