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
    widget.calories += ingredient[CALORIES] * ingredient[WEIGHT] / 100;
    widget.protein += ingredient[PROTEIN] * ingredient[WEIGHT] / 100;
    widget.fat += ingredient[FAT] * ingredient[WEIGHT] / 100;
    widget.carbs += ingredient[CARBS] * ingredient[WEIGHT] / 100;

    widget.calories = double.parse(widget.calories.toStringAsFixed(1));
    widget.protein = double.parse(widget.protein.toStringAsFixed(1));
    widget.fat = double.parse(widget.fat.toStringAsFixed(1));
    widget.carbs = double.parse(widget.carbs.toStringAsFixed(1));
  }

  void addIngredient(List ingredient){
    setState(() {
      addValues(ingredient);
      eaten.add([INGREDIENT, ingredient]);
    });
  
  }

  void addRecipe(List recipe){
    setState(() {
      List ingredients = recipe[1];

      for(var ing in ingredients){
        addValues(ing);
      }

      eaten.add([RECIPE, recipe]);      
    });

  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text("Calories: ${widget.calories} /n Protein: ${widget.protein} /n Fat: ${widget.fat} /n Carbs: ${widget.carbs}"),
    );
  }
}