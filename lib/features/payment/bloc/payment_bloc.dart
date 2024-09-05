import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:obviously_test_final/app/helpers/helper_functions.dart';
import 'package:obviously_test_final/features/payment/bloc/payment_event.dart';
import 'package:obviously_test_final/features/payment/bloc/payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(PaymentState(paymentPageController: PageController())) {
    on<HandleKeyboardInput>((event, emit) {
      String amountString = state.paymentInputString;

      // Case 1: Trying to input zeros when no amount is set
      if (state.currentAmount == 0 && event.input == '0') {
        // Do nothing
      } else {
        // Case 2: Deleting digits
        if (event.input == '<') {
          try {
            if (amountString.isEmpty) {
              // No action if there are no characters
            } else {
              // Remove the last character
              if (amountString.endsWith('.')) {
                amountString =
                    amountString.substring(0, amountString.length - 2);
              } else {
                amountString =
                    amountString.substring(0, amountString.length - 1);
              }
            }
          } catch (e) {
            debugPrint('Could not delete');
          }
        } else {
          // Case 3: Appending input to amount string
          // Only allow valid inputs based on current amount string

          if (event.input == '.') {
            // Only allow a decimal point if there isn't already one
            if (!amountString.contains('.')) {
              amountString = '$amountString.';
            }
          } else {
            // Check if the input is after a decimal point
            if (amountString.contains('.')) {
              int decimalIndex = amountString.indexOf('.');

              // Allow appending numbers only if there are less than 2 digits after the decimal point
              if (amountString.length - decimalIndex <= 2) {
                // If it's zero, check that it won't be a leading zero after the decimal
                if (event.input == '0' && amountString.endsWith('0')) {
                  // Do not append 0 if it's past the decimal point and already ends with 0
                } else {
                  // Ensure only 2 digits after decimal and valid input
                  amountString = '$amountString${event.input}';
                }
              }
            } else {
              // If there is no decimal point, append input as usual
              amountString = '$amountString${event.input}';
            }
          }
        }

        // Final state emission with the new amount string and amount
        emit(state.copyWith(
            paymentInputString: amountString,
            currentAmount:
                convertStringToCurrencyAmount(string: amountString)));
      }
    });

    on<NavigatePage>((event, emit) {
      state.paymentPageController.animateToPage(event.index,
          duration: const Duration(milliseconds: 250),
          curve: Curves.decelerate);

      emit(state.copyWith(pageIndex: event.index));
    });

    on<UpdateRecipientName>((event, emit) {
      emit(state.copyWith(recipientName: event.input));
    });

    on<ResetBloc>((event, emit) {
      emit(state.copyWith(
          paymentPageController: PageController(),
          currentAmount: 0.0,
          paymentInputString: '',
          pageIndex: 0,
          recipientName: ''));
    });
  }
}
