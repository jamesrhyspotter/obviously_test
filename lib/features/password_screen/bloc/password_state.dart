class PasswordState {
  final String input;
  final bool passError;

  const PasswordState({this.input = '', this.passError = false});

  PasswordState copyWith(
      {String? input, bool? passError}) {
    return PasswordState(
        input: input ?? this.input, passError: passError ?? this.passError);
  }
}

class PasswordSuccessState extends PasswordState {}
