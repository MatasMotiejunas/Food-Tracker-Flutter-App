import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:flutter_application_1/utils/ingredient.dart';
import 'package:flutter_application_1/utils/recipe.dart';

class ShowEaten extends StatelessWidget {

  final List list;
  final Function(String, double) removeIngredient;
  final Function(String) removeRecipe;

  const ShowEaten({super.key, required this.list, 
  required this.removeIngredient, required this.removeRecipe});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index){
            if(list[index][0] == INGREDIENT){
              return Ingredient(
                  name: list[index][1][NAME], 
                  caloriesPer100g: list[index][1][CALORIES], 
                  proteinPer100g: list[index][1][PROTEIN], 
                  fatPer100g: list[index][1][FAT], 
                  carbsPer100g: list[index][1][CARBS],
                  fiberPer100g: list[index][1][FIBER],
                  weight: list[index][1][WEIGHT],
                  removeIngredient: removeIngredient,);
            }else{
              return Recipe(
                name: list[index][1][0], 
                ingredients: list[index][1][1], 
                removeRecipe: removeRecipe);
            }
            
        },
              
      ),
    );
  }
}