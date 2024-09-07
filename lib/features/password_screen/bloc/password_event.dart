abstract class PasswordEvent {}

class HandlePassInput extends PasswordEvent {
  final String input;
  HandlePassInput({required this.input});
}
