import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';

class PasswordIndicator extends StatelessWidget {
  final int filledCircles; // Number of filled circles
  final int totalCircles; // Total number of circles (password length)
  final Color? filledColor;
  const PasswordIndicator({
    super.key,
    required this.filledCircles,
    this.filledColor,
    this.totalCircles = 6, // Default to a 6-character password length
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalCircles, (index) {
        return DelayedDisplay(
          delay: Duration(milliseconds: 100 * index),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 8.0), // Add spacing between circles
            child: CircleAvatar(
              radius: 12.0, // Size of the circles
              backgroundColor: index < filledCircles
                  ? filledColor ?? theme.highlightColor // Filled circle
                  : Colors.grey, // Empty circle
            ),
          ),
        );
      }),
    );
  }
}
