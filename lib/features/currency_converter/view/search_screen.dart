import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  final List<String> items;
  final Function(String) onItemTap;
  final String title;
  const SearchScreen(
      {super.key,
      required this.title,
      required this.items,
      required this.onItemTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: CustomScrollView(
        slivers: [
         
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return ListTile(
                onTap: () => onItemTap(items[index]),
                title: Text(items[index]),
              );
            }, childCount: items.length),
          )
        ],
      ),
    );
  }
}
