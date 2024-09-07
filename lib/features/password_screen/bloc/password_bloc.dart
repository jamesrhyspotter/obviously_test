import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:obviously_test_final/features/password_screen/bloc/password_event.dart';
import 'package:obviously_test_final/features/password_screen/bloc/password_state.dart';

String password = '000000';

class PasswordBloc extends Bloc<PasswordEvent, PasswordState> {
  PasswordBloc() : super(const PasswordState()) {
    on<HandlePassInput>((event, emit) {
      String input = state.input;
      if (event.input != '<') {
        if (input.length < 6) {
          input = '${state.input}${event.input}';
        }
      } else {
        if (input.length <= 1) {
          input = '';
        } else {
          input = input.substring(0, input.length - 1);
        }
      }

      emit(state.copyWith(input: input, passError: (input.length == 6 && input != password), authenticated: input == password));
    });
  }
}
