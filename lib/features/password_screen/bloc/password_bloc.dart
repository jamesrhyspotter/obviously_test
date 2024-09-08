import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:obviously_test_final/features/password_screen/bloc/password_event.dart';
import 'package:obviously_test_final/features/password_screen/bloc/password_state.dart';

class PasswordBloc extends Bloc<PasswordEvent, PasswordState> {
  final String password; 

  PasswordBloc({this.password = '000000'}) : super(const PasswordState()) {
    on<HandlePassInput>(_handlePassInput);
  }

  // Private method to handle pass input logic
  void _handlePassInput(HandlePassInput event, Emitter<PasswordState> emit) {
    final newInput = _processInput(state.input, event.input);

    if (newInput == password) {
      emit(PasswordSuccessState()); // Emit success state
    } else {
      emit(
        state.copyWith(
          input: newInput,
          passError: newInput.length == 6 && newInput != password,
        ),
      );
    }
  }

  // Private method to handle input logic
  String _processInput(String currentInput, String newInput) {
    if (newInput == '<') {
      // Handle backspace
      return currentInput.isEmpty
          ? ''
          : currentInput.substring(0, currentInput.length - 1);
    } else if (currentInput.length < 6) {
      // Append new input
      return '$currentInput$newInput';
    }
    return currentInput; // No change if input exceeds length
  }
}
