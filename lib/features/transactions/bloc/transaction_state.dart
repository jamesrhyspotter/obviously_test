import 'package:obviously_test_final/features/transactions/models/transaction_model.dart';

class TransactionState {
  final List<TransactionModel> allTransactions;
  final bool transactionsFetching;
  final double currentBalance;
  final bool isLoading;

  TransactionState(
      {required this.allTransactions,
      this.transactionsFetching = false,
      this.currentBalance = 0.0,
      this.isLoading = false});

  TransactionState copyWith(
      {TransactionModel? selectedTransaction,
      List<TransactionModel>? allTransactions,
      bool? transactionsFetching,
      double? currentBalance,
      bool? isLoading}) {
    return TransactionState(
        allTransactions: allTransactions ?? this.allTransactions,
        transactionsFetching: transactionsFetching ?? this.transactionsFetching,
        currentBalance: currentBalance ?? this.currentBalance,
        isLoading: isLoading ?? this.isLoading);
  }
}
