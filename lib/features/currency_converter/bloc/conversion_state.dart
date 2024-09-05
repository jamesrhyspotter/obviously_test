import 'package:obviously_test_final/features/currency_converter/models/conversion_model.dart';

class ConversionState {
  final Map<String, dynamic> conversionData;
  final bool initialised;
  final Map<String, dynamic> conversionDataSearchResults;
  final ConversionModel selectedCurrency;
  final double inputAmount;
  final bool keyboardVisible;

  ConversionState(
      {this.conversionData = const {},
      this.initialised = false,
      this.conversionDataSearchResults = const {},
      required this.selectedCurrency,
      this.inputAmount = 0.0,
      this.keyboardVisible = false});

  ConversionState copyWith(
      {Map<String, dynamic>? conversionData,
      bool? initialised,
      Map<String, dynamic>? conversionDataSearchResults,
      ConversionModel? selectedCurrency,
      bool? keyboardVisible,
      double? inputAmount}) {
    return ConversionState(
        initialised: initialised ?? this.initialised,
        conversionData: conversionData ?? this.conversionData,
        conversionDataSearchResults:
            conversionDataSearchResults ?? this.conversionDataSearchResults,
        selectedCurrency: selectedCurrency ?? this.selectedCurrency,
        inputAmount: inputAmount ?? this.inputAmount,
        keyboardVisible: keyboardVisible ?? this.keyboardVisible);
  }
}
