import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';

class DoubleButtonColumn extends StatelessWidget {
  final String titleOne;
  final Function onTapOne;
  final String titleTwo;
  final Function onTapTwo;
  const DoubleButtonColumn(
      {super.key,
      required this.titleOne,
      required this.onTapOne,
      required this.titleTwo,
      required this.onTapTwo,
      });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        height: 250,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DelayedDisplay(
              delay: const Duration(milliseconds: 250),
              child: ElevatedButton(
                  onPressed: () => onTapOne(),
                  child: Center(
                    child: Text(
                      titleOne,
                       style: Theme.of(context).textTheme.labelLarge,
                    ),
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            DelayedDisplay(
              delay: const Duration(milliseconds: 450),
              child: ElevatedButton(
                  onPressed: () => onTapTwo(),
                  child: Center(
                    child: Text(
                      titleTwo,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  )),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
