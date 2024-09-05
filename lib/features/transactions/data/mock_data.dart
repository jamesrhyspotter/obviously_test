import 'package:obviously_test_final/features/transactions/models/transaction_model.dart';

List<TransactionModel> mockData = [
  TransactionModel(
      amount: 32.00,
      counterParty: 'eBay',
      type: TransactionType.sentPayment,
      id: 'eBay123',
      date: DateTime.now()),
  TransactionModel(
      amount: 65.00,
      counterParty: 'Merton Council',
      type: TransactionType.sentPayment,
      id: 'mertonCouncil123',
      date: DateTime.now()),
  TransactionModel(
      amount: 150.00,
      type: TransactionType.topUp,
      id: 'topup123',
      date: DateTime.now()),
  TransactionModel(
      amount: 32.00,
      type: TransactionType.sentPayment,
      id: 'amazon123',
      counterParty: 'Amazon',
      date: DateTime.now().subtract(const Duration(days: 1))),
  TransactionModel(
      amount: 1400.00,
      type: TransactionType.sentPayment,
      id: 'JohnSnow123',
      counterParty: 'John Snow',
      date: DateTime.now().subtract(const Duration(days: 1))),
  TransactionModel(
      amount: 200.00,
      type: TransactionType.topUp,
      id: 'TopUp456',
      date: DateTime.now().subtract(const Duration(days: 1)))
];
