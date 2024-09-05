import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:obviously_test_final/features/payment/widgets/recipient_text_field.dart';

class RecipientScreen extends StatelessWidget {
  final Function(String) onkeyboardInput;
  final Function onPayTap;
  final bool canPay;

  const RecipientScreen(
      {super.key,
      required this.onkeyboardInput,
      required this.onPayTap,
      required this.canPay});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
            child: Center(
                child: Text('To Who?', style: theme.textTheme.displayMedium))),
        Expanded(
            flex: 1,
            child: CustomTextField(onInput: (input) {
              onkeyboardInput(input);
            })),
        AnimatedOpacity(
          duration: const Duration(milliseconds: 250),
          opacity: canPay ? 1 : 0.5,
          child: Padding(
            padding: const EdgeInsets.all(60.0),
            child: ElevatedButton(
              onPressed: () {
                // Handle next button press
                if (canPay) {
                  HapticFeedback.lightImpact();
                  onPayTap();
                }
              },
              child: Center(
                child: Text(
                  'Pay',
                  style: theme.textTheme.displaySmall,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
