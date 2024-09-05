import 'package:flutter/material.dart';
import 'package:obviously_test_final/features/transactions/models/transaction_model.dart';
import 'package:obviously_test_final/app/helpers/helper_functions.dart';

class ActivityList extends StatelessWidget {
  final List<TransactionModel> transactions;
  const ActivityList({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
      TransactionModel transaction = transactions[index];
      bool showDate = index == 0;
      if (index > 0) {
        final previousTransaction = transactions[index - 1];
        showDate = !isSameDay(transaction.date!, previousTransaction.date!);
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showDate) Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 5, bottom: 5),
            child: Text(formatDateTime(transaction.date!), style: theme.textTheme.headlineSmall,),
          ),
          ListTile(
            leading: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                    color: theme.primaryColor,
                    borderRadius: BorderRadius.circular(2)),
                child: Icon(
                  transaction.type.icon,
                  size: 18,
                )),
            title: Text(transactions[index].counterParty ?? 'Top Up'),
            trailing: Text(
              '${transactions[index].type == TransactionType.sentPayment ? '' : '+'}${formatTo2DP(number: transaction.amount)}',
              style: theme.textTheme.headlineLarge!
                  .copyWith(color: transactions[index].type.color),
            ),
          ),
        ],
      );
    }, childCount: transactions.length));
  }
}
