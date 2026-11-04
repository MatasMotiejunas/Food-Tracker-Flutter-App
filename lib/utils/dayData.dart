import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/constants.dart';

class DayData extends StatelessWidget {
  final DateTime date;
  
  double calories = 0.0;
  double protein = 0.0;
  double fat = 0.0;
  double carbs = 0.0;

  List eaten = [];


  DayData({super.key,
    required this.date,
  });



  void addValues(List ingredient){
    calories += ingredient[CALORIES] * ingredient[WEIGHT] / 100;
    protein += ingredient[PROTEIN] * ingredient[WEIGHT] / 100;
    fat += ingredient[FAT] * ingredient[WEIGHT] / 100;
    carbs += ingredient[CARBS] * ingredient[WEIGHT] / 100;

    calories = double.parse(calories.toStringAsFixed(1));
    protein = double.parse(protein.toStringAsFixed(1));
    fat = double.parse(fat.toStringAsFixed(1));
    carbs = double.parse(carbs.toStringAsFixed(1));
  }

  void addIngredient(List ingredient){
    addValues(ingredient);
    eaten.add([INGREDIENT, ingredient]);
  
  }

  void addRecipe(List recipe){
    List ingredients = recipe[1];

    for(var ing in ingredients){
      addValues(ing);
    }

    eaten.add([RECIPE, recipe]);      

  }

  @override
  Widget build(BuildContext context) {
    return Placeholder();
  }

}