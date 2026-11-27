import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:flutter_application_1/utils/ingredient.dart';

//
// Builds the Ingredients
//
class IngredientSubpage extends StatelessWidget {
  final List list;
  final Function(String, double) removeIngredient;

  const IngredientSubpage({super.key, required this.list, required this.removeIngredient});

  @override
  Widget build(BuildContext context) {
    return Expanded(
          child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index){
              return Ingredient(
                name: list[index][NAME], 
                caloriesPer100g: list[index][CALORIES], 
                proteinPer100g: list[index][PROTEIN], 
                fatPer100g: list[index][FAT], 
                carbsPer100g: list[index][CARBS],
                fiberPer100g: list[index][FIBER],
                weight: 0.0,
                removeIngredient: removeIngredient,);
            },
            
          )

          //child: ListView(children: list,)  

        );
  }
    
}