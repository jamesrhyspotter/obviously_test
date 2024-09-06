import 'package:obviously_test_final/features/transactions/models/transaction_model.dart';

class UserModel {
  final double balance; 
  final List<TransactionModel> transactions; 
  final String id; 

  UserModel({this.balance = 0, this.transactions = const [], this.id = ''});
}