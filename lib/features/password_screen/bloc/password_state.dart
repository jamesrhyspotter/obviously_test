class PasswordState {
  final bool authenticated;
  final String input;
  final bool passError;

  const PasswordState(
      {this.authenticated = false, this.input = '', this.passError = false});

  PasswordState copyWith(
      {bool? authenticated, String? input, bool? passError}) {
    return PasswordState(
        authenticated: authenticated ?? this.authenticated,
        input: input ?? this.input,
        passError: passError ?? this.passError);
  }
}
