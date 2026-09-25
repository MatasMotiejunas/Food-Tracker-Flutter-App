import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/recipe.dart';

class RecipeSubpage extends StatelessWidget {
  final List recipeList;


  const RecipeSubpage({super.key, required this.recipeList});

  @override
  Widget build(BuildContext context) {
    return Expanded(
          child: ListView.builder(
            //show ingredients
            itemCount: recipeList.length,
            itemBuilder: (context, index){
              //create ingredient for an item in the list
              return Recipe(
                name: recipeList[index][0],
                ingredients: recipeList[index][1],
              );
            },
          ),
        );
  }
    
}