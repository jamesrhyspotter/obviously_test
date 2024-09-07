import 'package:flutter/material.dart';
import 'package:obviously_test_final/app/animations/waves.dart';
import 'package:obviously_test_final/features/transactions/widgets/action_card.dart';
import 'package:obviously_test_final/app/widgets/balance_text.dart';

class TransactionsHeader extends StatelessWidget {
  final double balance;
  const TransactionsHeader({super.key, required this.balance});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      children: [
        Container(
          color: theme.primaryColor,
          height: 200,
        ),
        const WaveAnimation(),
        SizedBox(
          height: 280,
          width: MediaQuery.of(context).size.width,
          // color: Colors.red,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BalanceText(
                amount: balance,
              ),
              const ActionCard()
            ],
          ),
        ),
      ],
    );
  }
}
