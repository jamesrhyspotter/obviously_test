import 'package:obviously_test_final/features/transactions/models/transaction_model.dart';

abstract class TransactionEvent {}


class InitialiseTransactionBloc extends TransactionEvent {}

class SaveTransaction extends TransactionEvent {
  final TransactionModel transaction;
  SaveTransaction({required this.transaction});
}

class UpdateSelectedTransaction extends TransactionEvent {
  final TransactionModel transaction;
  UpdateSelectedTransaction({required this.transaction});
}

class DeleteTransaction extends TransactionEvent {
  final TransactionModel transaction;
  DeleteTransaction({required this.transaction});
}
