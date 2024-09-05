import 'package:flutter/material.dart';

class PaymentState {
  final double currentAmount;
  final String paymentInputString;
  final int pageIndex;
  final PageController paymentPageController;
  final String recipientName;

  PaymentState(
      {this.currentAmount = 0.0,
      this.paymentInputString = '',
      this.pageIndex = 0,
      required this.paymentPageController,
      this.recipientName = ''});

  PaymentState copyWith(
      {double? currentAmount,
      String? paymentInputString,
      int? pageIndex,
      PageController? paymentPageController,
      String? recipientName}) {
    return PaymentState(
        currentAmount: currentAmount ?? this.currentAmount,
        paymentInputString: paymentInputString ?? this.paymentInputString,
        pageIndex: pageIndex ?? this.pageIndex,
        paymentPageController:
            paymentPageController ?? this.paymentPageController,
        recipientName: recipientName ?? this.recipientName);
  }
}
