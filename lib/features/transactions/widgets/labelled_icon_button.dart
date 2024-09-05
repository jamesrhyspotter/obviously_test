import 'package:flutter/material.dart';

class LabelledAssetButton extends StatelessWidget {
  final Function onTap;
  final String label;
  final String assetPath;
  const LabelledAssetButton({
    super.key,
    required this.label,
    required this.onTap,
    required this.assetPath,
  });

  @override
  Widget build(BuildContext context) {
     final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => onTap(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Image.asset(assetPath, height: 60,), Text(label, style: theme.textTheme.bodySmall)],
      ),
    );
  }
}
