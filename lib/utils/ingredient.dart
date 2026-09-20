import 'package:flutter/material.dart';

class Ingredient extends StatelessWidget {
  const Ingredient({super.key, required this.name, required this.caloriesPer100g, required this.proteinPer100g,
    required this.fatPer100g, required this.carbsPer100g});

  final String name;
  final double caloriesPer100g;
  final double proteinPer100g;
  final double fatPer100g;
  final double carbsPer100g;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25), //outter Padding
      child: Container(
        padding: const EdgeInsets.all(20), //inner Padding
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text("$name \n Calories: $caloriesPer100g \n Protein: $proteinPer100g \n Fat: $fatPer100g \n Carbs: $carbsPer100g"),
      ),
    );
  }
}