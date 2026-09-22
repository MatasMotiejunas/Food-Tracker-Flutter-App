import 'package:flutter/material.dart';

class SelectButton extends StatelessWidget {

  final String text;
  final String selectedText;
  final ValueChanged<String> changeSelected;

  const SelectButton({
    super.key,
    required this.text,
    required this.selectedText,
    required this.changeSelected});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => changeSelected(text),
      child: Container(
        padding: EdgeInsets.all(5),
        color: text == selectedText ? Colors.lightGreen[700] : Colors.lightGreen[400],
        child: Text(text),
      ),
    );
  }
}