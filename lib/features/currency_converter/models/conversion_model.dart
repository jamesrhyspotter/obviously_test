class ConversionModel {
  final String key;
  final double rate;

  ConversionModel({required this.key, required this.rate});

  static ConversionModel fromEmpty() {
    return  ConversionModel(
      key: '', // Empty string as a placeholder
      rate: 0.0, // Default rate of 0.0
    );
  }
}
