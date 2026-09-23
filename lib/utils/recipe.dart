import "package:flutter/material.dart";
import "package:flutter_application_1/utils/ingredient.dart";

class Recipe extends StatelessWidget {
  final List<Ingredient> ingredients;
  final String name;

  const Recipe({super.key, required this.name, required this.ingredients});


  List<Text> ingredientNames(){
    List<Text> names = [Text(name)];
    for(Ingredient ing in ingredients) {
      names.add(Text(ing.name));
    }
    return names;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25), //outter Padding
      child: Container(
        padding: const EdgeInsets.all(20), //inner Padding
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: ingredientNames(),
        ),
      ),
    );
  }
}