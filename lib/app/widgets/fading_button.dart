import 'package:flutter/material.dart';

class FadingButton extends StatelessWidget {
  final bool isVisible;
  final Function onTap;
  const FadingButton({super.key, required this.isVisible, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedOpacity(
      opacity: isVisible ? 1 : 0,
      duration: Duration(milliseconds: isVisible ? 250 : 0),
      child: Container(
          decoration: BoxDecoration(
              color: theme.highlightColor,
              borderRadius: BorderRadius.circular(10)),
          child: IconButton(
              onPressed: () => onTap(),
              icon: Icon(
                Icons.keyboard_arrow_down_sharp,
                color: theme.primaryColor,
              ))),
    );
  }
}
