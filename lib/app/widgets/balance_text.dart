import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:obviously_test_final/app/helpers/helper_functions.dart';

class BalanceText extends StatelessWidget {
  final double amount;
  final String? leading;
  const BalanceText({super.key, required this.amount, this.leading});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    List<String> splitCurrency = splitAmountByDecimal(amount: amount);

    return DelayedDisplay(
      delay: const Duration(milliseconds: 250),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          // Default color for text
          children: [
            TextSpan(
                text: leading ?? '£', // Currency symbol
                style: theme.textTheme.displayMedium),
            TextSpan(
                text: splitCurrency.first, // Main amount
                style: theme.textTheme.displayLarge),
            TextSpan(
                text: splitCurrency.last, // Decimal part
                style: theme.textTheme.displayMedium),
          ],
        ),
      ),
    );
  }
}
