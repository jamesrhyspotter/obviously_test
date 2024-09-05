import 'package:bloc/bloc.dart';
import 'package:obviously_test_final/features/transactions/bloc/transaction_event.dart';
import 'package:obviously_test_final/features/transactions/bloc/transaction_state.dart';
import 'package:obviously_test_final/features/transactions/data/transaction_repo.dart';
import 'package:obviously_test_final/features/transactions/models/transaction_model.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc()
      : super(TransactionState(
            currentBalance: 150.25, allTransactions: const [])) {
    on<UpdateSelectedTransaction>((event, emit) {
      emit(state.copyWith(selectedTransaction: event.transaction));
    });

    on<SaveTransaction>((event, emit) {
      TransactionModel finalTransaction = event.transaction.copyWith(
          date: DateTime.now(),
          id: '${event.transaction.counterParty}${DateTime.now()}');
      List<TransactionModel> newTransactions = [
        finalTransaction,
        ...List.from(state.allTransactions)
      ];

      double newBalance = event.transaction.type == TransactionType.sentPayment
          ? state.currentBalance - event.transaction.amount
          : state.currentBalance + event.transaction.amount;

      emit(state.copyWith(
          allTransactions: newTransactions, currentBalance: newBalance));
    });

    on<FetchAllTransactions>(
      (event, emit) async {
        emit(state.copyWith(isLoading: true));
        List<TransactionModel> retrievedTransactions =
            await TransactionRepo.instance.fetchTransactions();

        // simulating fetching from DB
        await Future.delayed(const Duration(seconds: 2));

        emit(state.copyWith(
            allTransactions: retrievedTransactions,
            transactionsFetched: true,
            isLoading: false));
      },
    );
  }
}
