import 'package:flutter/material.dart';

class MySearchBar extends StatelessWidget {

  final void Function(String) check;

  const MySearchBar({super.key, required this.check});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: SearchBar(
        leading: Icon(Icons.search),
        hintText: "Search ingredient",
        onChanged: (value) => check(value),
      ));
  }
}