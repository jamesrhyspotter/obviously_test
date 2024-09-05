import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final Function(String) onInput;
  final TextInputType keyboardType;
  final Function? onTap;

  const CustomTextField(
      {super.key,
      required this.onInput,
      this.keyboardType = TextInputType.text,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: TextField(
        keyboardType: keyboardType,
        onTap: () {
          if (onTap != null){
             onTap!();
          }
        },
        onChanged: (value) {
          onInput(value);
        },
        style: theme.textTheme.displayMedium, // color
        cursorColor: Colors.white, // White cursor color
      ),
    );
  }
}
