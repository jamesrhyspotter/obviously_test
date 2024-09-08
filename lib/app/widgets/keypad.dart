import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class KeyPad extends StatelessWidget {
  final Function(String) handleInput;
  final bool showDecimal; 

  const KeyPad({super.key, required this.handleInput, this.showDecimal = true});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DelayedDisplay(
       delay: const Duration(milliseconds: 750),
                    slidingBeginOffset: const Offset(0, 0),
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.all(10.0),
        crossAxisCount: 3,
        childAspectRatio: 2,
        children: [
          for (var i = 1; i <= 9; i++)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () {
                  HapticFeedback.lightImpact();
                  handleInput('$i');
                },
                child: Text('$i', style: theme.textTheme.displayMedium),
              ),
            ),
      
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: showDecimal ? 
            
            TextButton(
              onPressed: () {
                HapticFeedback.lightImpact();
                handleInput('.');
              },
              child: Text('.', style: theme.textTheme.displayMedium),
            ): const SizedBox(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () {
                HapticFeedback.lightImpact();
                handleInput('0');
              },
              child: Text('0', style: theme.textTheme.displayMedium),
            ),
          ),
          IconButton(
            onPressed: () {
              HapticFeedback.lightImpact();
              handleInput('<');
            },
            icon: const Icon(Icons.arrow_back_ios_new, size: 24.0),
          ),
        ],
      ),
    );
  }
}
