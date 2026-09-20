import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/ingredient.dart';



class FoodPage extends StatefulWidget {
  const FoodPage({super.key});

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  
  List ingredientList = [
    //[name, calories, protein, fat, carbs]
    ["Ingredient 1", 520.3, 10.1, 15.2, 220.8],
    ["Ingredient 2", 550.1, 10.1, 15.2, 220.8],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[50],
      appBar: AppBar(
        title: Text("Ingredients and Recipes"),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: ListView.builder(
        itemCount: ingredientList.length,
        itemBuilder: (context, index){
          return Ingredient(
            name: ingredientList[index][0],
            caloriesPer100g: ingredientList[index][1],
            proteinPer100g: ingredientList[index][2],
            fatPer100g: ingredientList[index][3],
            carbsPer100g: ingredientList[index][4],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {}, 
        child: Icon(Icons.add),
      ),
    );
  }
}