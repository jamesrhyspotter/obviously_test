import 'package:flutter/material.dart';

enum TransactionType {
  sentPayment(color: Colors.black, icon: Icons.shopping_bag_rounded),
  topUp(color: Color(0xffC0028B), icon: Icons.add_circle);

  const TransactionType({required this.color, required this.icon});

  final IconData icon;
  final Color color;
}

class TransactionModel {
  final double amount;
  final String? counterParty;
  final String? id;
  final DateTime? date;
  final TransactionType type;

  const TransactionModel(
      {required this.amount,
      this.counterParty,
      required this.type,
      this.date,
      required this.id});
  factory TransactionModel.fromEmpty() => const TransactionModel(
        amount: 0.0,
        counterParty: "",
        type: TransactionType.sentPayment, // Or choose a default type
        id: null,
      );

  TransactionModel copyWith({
    double? amount,
    String? counterParty,
    String? id,
    DateTime? date,
    TransactionType? type,
  }) {
    return TransactionModel(
      amount: amount ?? this.amount,
      counterParty: counterParty ?? this.counterParty,
      type: type ?? this.type,
      date: date ?? this.date,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'counterParty': counterParty,
      'id': id,
      'date': date?.toIso8601String(), 
      'type': type.toString(), 
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
        amount: map['amount'] as double,
        counterParty: map['counterParty'] as String?,
        id: map['id'] as String?,
        date: map['date'] != null ? DateTime.parse(map['date']) : null,
        type: map['type'] != null
            ? TransactionType.values
                .firstWhere((type) => type.toString() == map['type'])
            : TransactionType.sentPayment);
  }

  @override
  String toString() {
    return 'TransactionModel(amount: $amount, counterParty: $counterParty, type: $type, date: $date, id: $id)';
  }
}
