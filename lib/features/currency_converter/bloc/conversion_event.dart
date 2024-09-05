import 'package:obviously_test_final/features/currency_converter/models/conversion_model.dart';

abstract class ConversionEvent {}

class FetchConversions extends ConversionEvent {}

class UpdateSelectedCurrency extends ConversionEvent {
  final ConversionModel conversionModel; 
  UpdateSelectedCurrency({required this.conversionModel});
}

class UpdateInputAmount extends ConversionEvent {
  final double amount; 
  UpdateInputAmount({required this.amount});
}

class ToggleKeyboardVisible extends ConversionEvent {
  final bool isVisible; 
  ToggleKeyboardVisible({required this.isVisible});
}

class ResetBloc extends ConversionEvent {
  
}