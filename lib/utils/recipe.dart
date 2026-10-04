import "package:flutter/material.dart";
import "package:flutter_application_1/utils/constants.dart";

class Recipe extends StatelessWidget {
  final List ingredients;
  final String name;

  double calories = 0.0;
  double protein = 0.0;
  double fat = 0.0;
  double carbs = 0.0;

  Recipe({super.key, required this.name, required this.ingredients}){
    for(var ing in ingredients){
      calories += ing[CALORIES] * ing[WEIGHT] / 100;
      protein += ing[PROTEIN] * ing[WEIGHT] / 100;
      fat += ing[FAT] * ing[WEIGHT] / 100;
      carbs += ing[CARBS] * ing[WEIGHT] / 100;
    }

    calories = double.parse(calories.toStringAsFixed(1));
    protein = double.parse(protein.toStringAsFixed(1));
    fat = double.parse(fat.toStringAsFixed(1));
    carbs = double.parse(carbs.toStringAsFixed(1));
  }


  List<Text> ingredientNames(){
    List<Text> names = [Text("$name: Cal = $calories")];
    for(var ing in ingredients) {
      var nm = ing[NAME];
      var cal = ing[CALORIES] * ing[WEIGHT] / 100;
      cal = double.parse(cal.toStringAsFixed(1));
      var weight = ing[WEIGHT];
      names.add(Text("$nm Cal = $cal, weight = $weight"));
    }
    return names;
  }

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
        child: Column(
          children: ingredientNames(),
        ),
      ),
    );
  }
}