import 'package:flutter/material.dart';

class RateRow extends StatelessWidget {
  final bool conversionSelected; 
  final String rateString; 
  const RateRow({super.key, required this.conversionSelected, required this.rateString});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Rate:',
          style: theme.textTheme.displaySmall,
        ),
        Text(
          !conversionSelected 
              ? '-'
              : rateString,
          style: theme.textTheme.displaySmall,
        ),
      ],
    );
  }
}
