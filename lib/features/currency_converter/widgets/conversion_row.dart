import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:obviously_test_final/features/currency_converter/view/search_screen.dart';

class ConversionRow extends StatelessWidget {
  final Function(String) onSearchItemTapped;
  final List<String> listItems;
  final String selectedItem;
  final bool showSearchIcon;
  const ConversionRow(
      {super.key,
      required this.onSearchItemTapped,
      required this.listItems,
      required this.showSearchIcon,
      required this.selectedItem});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Expanded(
        flex: 4,
        child: Text(
          'Convert to:',
          style: theme.textTheme.displaySmall,
        ),
      ),
      IconButton(
          onPressed: () {
            showCupertinoModalPopup(
                context: context,
                builder: (context) {
                  return SearchScreen(
                    onItemTap: (label) {
                      onSearchItemTapped(label);
                    },
                    title: 'Select Conversion',
                    items: listItems,
                  );
                });
          },
          icon: !showSearchIcon
              ? Text(
                  selectedItem,
                  style: theme.textTheme.displaySmall,
                )
              : const Icon(Icons.search))
      // Expanded(
      //   flex: 1, child: CustomTextField(onInput: (input){}))
    ]);
  }
}
