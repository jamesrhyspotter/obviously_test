import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:obviously_test_final/app/helpers/navigation_helper.dart';
import 'package:obviously_test_final/app/widgets/loading_widget.dart';
import 'package:obviously_test_final/features/currency_converter/view/currency_conversion_screen.dart';
import 'package:obviously_test_final/features/transactions/bloc/transaction_bloc.dart';
import 'package:obviously_test_final/features/transactions/bloc/transaction_event.dart';
import 'package:obviously_test_final/features/transactions/bloc/transaction_state.dart';
import 'package:obviously_test_final/features/transactions/widgets/activity_list.dart';

import 'package:obviously_test_final/features/transactions/widgets/transactions_header.dart';

class TransactionsMainView extends StatelessWidget {
  const TransactionsMainView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bloc = context.read<TransactionBloc>();
    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        if (!state.transactionsFetching) {
          bloc.add(InitialiseTransactionBloc());
        }
        return Scaffold(
          appBar: AppBar(
            title: const DelayedDisplay(
                delay: Duration(milliseconds: 100), child: Text('MoneyApp')),
            actions: [
              IconButton(
                  onPressed: () {
                    NavigationHelper.instance.to(
                      context: context,
                      page: const CurrencyConversionScreen(),
                    );
                  },
                  icon: const Icon(
                    Icons.currency_exchange,
                  ))
            ],
          ),
          body: state.isLoading
              ? const LoadingWidget()
              : LiquidPullToRefresh(
                  color: theme.primaryColor,
                  onRefresh: () async {
                    bloc.add(InitialiseTransactionBloc());
                  },
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                          child: TransactionsHeader(
                        balance: state.currentBalance,
                      )),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 20.0, bottom: 10),
                          child: Text(
                            state.allTransactions.isEmpty
                                ? 'Your transaction activity will show here.'
                                : 'Recent Activity',
                            style: theme.textTheme.headlineMedium,
                          ),
                        ),
                      ),
                      ActivityList(transactions: state.allTransactions)
                    ],
                  ),
                ),
        );
      },
    );
  }
}
