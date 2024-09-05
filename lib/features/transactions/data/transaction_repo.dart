import 'package:flutter/material.dart';
import 'package:obviously_test_final/features/transactions/data/mock_data.dart';
import 'package:obviously_test_final/features/transactions/models/transaction_model.dart';

class TransactionRepo {
  TransactionRepo._privateConstructor();
  static final TransactionRepo _instance =
      TransactionRepo._privateConstructor();
  static TransactionRepo get instance => _instance;

  Future<double> fetchCurrentBalance() async {
    double balance = 0.0;

    try {
      balance = 150.25;
    } catch (e) {
      debugPrint('Could not fetch balance');
    }

    return balance;
  }

  Future<List<TransactionModel>> fetchTransactions() async {
    List<TransactionModel> retrievedTransactions = [];
    try {
      // fetch from DB where needed

      retrievedTransactions = mockData;
    } catch (e) {
      debugPrint('Could not fetch transactions');
    }

    return retrievedTransactions;
  }
}
