import 'package:flutter/material.dart';

//
// Simple SearchBar
//
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
        // Called every time a new charcater is written/deleted
        onChanged: (value) => check(value),
      ));
  }
}