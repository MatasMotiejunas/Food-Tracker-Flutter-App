import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/recipe.dart';

//
// Builds the Recipes
//
class RecipeSubpage extends StatelessWidget {
  final List recipeList;
  final Function(String) removeRecipe;

  const RecipeSubpage({super.key, required this.recipeList, required this.removeRecipe});

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
                removeRecipe: removeRecipe,
              );
            },
          ),
        );
  }
    
}