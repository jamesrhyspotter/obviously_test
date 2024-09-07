
import 'package:flutter/material.dart';

Widget ripple({required BuildContext context, bool expanded = true}) {
  return AnimatedPositioned(
    duration: const Duration(seconds: 1),
    right:  -150,
    bottom:    -150,
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      height: expanded ? MediaQuery.of(context).size.height * 1.5 : 0,
      width: expanded ? MediaQuery.of(context).size.height * 1.5 : 0,
      decoration:  BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).colorScheme.secondary,
      ),
    ),
  );
}
