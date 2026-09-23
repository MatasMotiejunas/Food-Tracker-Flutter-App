import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/addIngredient.dart';
import 'package:flutter_application_1/utils/ingredient.dart';

class IngredientSubpage extends StatelessWidget {
  final List<Ingredient> list;

  const IngredientSubpage({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return Expanded(
          // child: ListView.builder(
          //   itemCount: list.length,
          //   itemBuilder: (context, index){
          //     return Ingredient(
          //       name: list[index][0], 
          //       caloriesPer100g: list[index][1], 
          //       proteinPer100g: list[index][2], 
          //       fatPer100g: list[index][3], 
          //       carbsPer100g: list[index][4]);
          //   },
            
          // )

          child: ListView(children: list,)  

        );
  }
    
}