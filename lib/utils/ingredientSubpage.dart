import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:flutter_application_1/utils/ingredient.dart';

class IngredientSubpage extends StatelessWidget {
  final List list;

  const IngredientSubpage({super.key, required this.list});

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
                carbsPer100g: list[index][CARBS]);
            },
            
          )

          //child: ListView(children: list,)  

        );
  }
    
}