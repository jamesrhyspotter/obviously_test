import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:obviously_test_final/features/transactions/models/transaction_model.dart';

class TransactionRepo {
  TransactionRepo._privateConstructor();
  static final TransactionRepo _instance =
      TransactionRepo._privateConstructor();
  static TransactionRepo get instance => _instance;

  final String userID =
      'james12345'; // this would be gotten from firebase auth if firebase auth is implemented
  DocumentReference get userDataDocumentRef => userDataCollection.doc(userID);

  final firebase = FirebaseFirestore.instance;
  CollectionReference get userDataCollection => firebase.collection("userData");

  CollectionReference get transactionDataCollection =>
      userDataDocumentRef.collection('transactions');

  Future<double> fetchCurrentBalance() async {
    double balance = 0.0;

    try {
      var userData = await userDataDocumentRef.get();
      Map<String, dynamic> data = userData.data() as Map<String, dynamic>;
      balance = data['balance'];
      debugPrint('balance retrieved: $balance');
    } catch (e) {
      debugPrint('Could not fetch balance $e');
    }

    return balance;
  }

  Future<void> updateCurrentBalance({required double newBalance}) async {
    try {
      userDataDocumentRef.set({'balance': newBalance});
    } catch (e) {
      debugPrint('Could not update balance $e');
    }
  }

  Future<List<TransactionModel>> fetchTransactions() async {
    List<TransactionModel> retrievedTransactions = [];
    try {
      // fetch from DB where needed

      // retrievedTransactions = mockData;

      var data = await transactionDataCollection
          .orderBy('date', descending: true)
          .get();

      List<TransactionModel> transactions = data.docs
          .map(
              (d) => TransactionModel.fromMap(d.data() as Map<String, dynamic>))
          .toList();

      retrievedTransactions = transactions;
    } catch (e) {
      debugPrint('Could not fetch transactions');
    }

    return retrievedTransactions;
  }

  Future<void> uploadTransaction(
      {required TransactionModel transaction}) async {
    try {
      await transactionDataCollection
          .doc(transaction.id!)
          .set(transaction.toMap(), SetOptions(merge: true));
    } catch (e) {
      debugPrint('Could not upload transaction $e');
    }
  }
}
