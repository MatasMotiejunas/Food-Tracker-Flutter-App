import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:flutter_application_1/utils/ingredient.dart';

class ShowEaten extends StatelessWidget {

  final List list;
  final Function(String, double) removeIngredient;

  const ShowEaten({super.key, required this.list, required this.removeIngredient});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index){
            if(list[index][0] == 0){
              return Ingredient(
                  name: list[index][1][NAME], 
                  caloriesPer100g: list[index][1][CALORIES], 
                  proteinPer100g: list[index][1][PROTEIN], 
                  fatPer100g: list[index][1][FAT], 
                  carbsPer100g: list[index][1][CARBS],
                  fiberPer100g: list[index][1][FIBER],
                  weight: list[index][1][WEIGHT],
                  removeIngredient: removeIngredient,);
            }
            
        },
              
      ),
    );
  }
}