abstract class PaymentEvent {}


class HandleKeyboardInput extends PaymentEvent {
  final String input;

  HandleKeyboardInput({required this.input}); 
}

class NavigatePage extends PaymentEvent {
  final int index; 
  NavigatePage({required this.index});
}

class UpdateRecipientName extends PaymentEvent {
  final String input; 
  UpdateRecipientName({required this.input});
}

class ResetBloc extends PaymentEvent {}