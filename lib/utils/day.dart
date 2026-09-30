import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/constants.dart';

class Day extends StatefulWidget {
  final DateTime date;
  
  double calories = 0.0;
  double protein = 0.0;
  double fat = 0.0;
  double carbs = 0.0;


  Day({super.key,
    required this.date,
  });

  @override
  State<Day> createState() => _DayState();
}

class _DayState extends State<Day> {
  List eaten = [];

  void addValues(List ingredient){
    widget.calories += ingredient[CALORIES];
    widget.protein += ingredient[PROTEIN];
    widget.fat += ingredient[FAT];
    widget.carbs += ingredient[CARBS];
  }

  void addIngredient(List ingredient, int index){
    setState(() {
      addValues(ingredient);
      eaten.add([INGREDIENT, index]);
    });
  
  }

  void addRecipe(List recipe, int index){
    setState(() {
      List ingredients = recipe[1];

      for(var ing in ingredients){
        addValues(ing);
      }

      eaten.add([RECIPE, index]);      
    });

  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text("Calories: ${widget.calories} /n Protein: ${widget.protein} /n Fat: ${widget.fat} /n Carbs: ${widget.carbs}"),
    );
  }
}