import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/addIngredient.dart';
import 'package:flutter_application_1/utils/addRecipe.dart';
import 'package:flutter_application_1/utils/ingredientSubpage.dart';
import 'package:flutter_application_1/utils/ingredient.dart';
import 'package:flutter_application_1/utils/recipeSubpage.dart';
import 'package:flutter_application_1/utils/selectedButton.dart';



class FoodPage extends StatefulWidget {
  const FoodPage({super.key});

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {

  //Controllers for each of the input fields when adding an ingredient
  final TextEditingController nameController = TextEditingController();
  final TextEditingController caloriesController = TextEditingController();
  final TextEditingController proteinController = TextEditingController();
  final TextEditingController fatController = TextEditingController();
  final TextEditingController carbsController = TextEditingController();
  final TextEditingController recipeNameController = TextEditingController();

  List<Ingredient> ingredientList = [
    //[name, calories, protein, fat, carbs]
    // ["Ingredient 1", 520.3, 10.1, 15.2, 220.8],
    // ["Ingredient 2", 550.1, 15.0, 3.1, 27.0],
    // ["Ingredient 3", 250.9, 5.2, 2.6, 3.0],
    Ingredient(name: "Ingredient 1", caloriesPer100g: 520.3, proteinPer100g: 10.1, fatPer100g: 15.2, carbsPer100g: 220.8),
    Ingredient(name: "Ingredient 2", caloriesPer100g: 550.1, proteinPer100g: 10.1, fatPer100g: 15.2, carbsPer100g: 220.8),
    Ingredient(name: "Ingredient 3", caloriesPer100g: 250, proteinPer100g: 5, fatPer100g: 2, carbsPer100g: 3),
  ];

  List recipeList = [
    ["Recipe 1", [Ingredient(name: "Ingredient 1", caloriesPer100g: 520.3, proteinPer100g: 10.1, fatPer100g: 15.2, carbsPer100g: 220.8),
    Ingredient(name: "Ingredient 2", caloriesPer100g: 550.1, proteinPer100g: 10.1, fatPer100g: 15.2, carbsPer100g: 220.8),]],
    ["Recipe 2", [Ingredient(name: "Ingredient 2", caloriesPer100g: 550.1, proteinPer100g: 10.1, fatPer100g: 15.2, carbsPer100g: 220.8),
    Ingredient(name: "Ingredient 3", caloriesPer100g: 250, proteinPer100g: 5, fatPer100g: 2, carbsPer100g: 3),]],
  ];

  String selected = "Ingredients";

  void clearControllers(){
    nameController.clear();
    caloriesController.clear();
    proteinController.clear();
    fatController.clear();
    carbsController.clear();
  }

  void saveNewIngredient(){
    setState(() {
      String name = nameController.text;
      String calories = caloriesController.text;
      String protein = proteinController.text;
      String fat = fatController.text;
      String carbs = carbsController.text;
      
      //ingredientList.add([name.trim(), double.parse(calories), double.parse(protein), double.parse(fat), double.parse(carbs)]);
      ingredientList.add(Ingredient(
        name: name.trim(), 
        caloriesPer100g: double.tryParse(calories)?? 0.0, 
        proteinPer100g: double.tryParse(protein) ?? 0.0, 
        fatPer100g: double.tryParse(fat) ?? 0.0, 
        carbsPer100g: double.tryParse(carbs) ?? 0.0));

      clearControllers();
    });
    Navigator.of(context).pop();
  }

  void saveNewRecipe(List<bool> chosenIngredients){
    bool allFalse = !chosenIngredients.contains(true);
    if (allFalse) return;

    setState((){
      List<Ingredient> toAdd = [];

      for(int i=0; i<chosenIngredients.length; i++){
        if(chosenIngredients[i]){
          toAdd.add(ingredientList[i]);
        }
      }
      
      recipeList.add([recipeNameController.text.trim(), toAdd]);
      

      recipeNameController.clear();
      
    });

    Navigator.of(context).pop();
  }

  void onCancel () {
    Navigator.of(context).pop();
    clearControllers();
  }

  void handleSelection(String value){
    setState(() {
      selected = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[50],
      appBar: AppBar(
        title: Text("Ingredients and Recipes"),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SelectButton(text: "Ingredients", selectedText: selected, changeSelected: handleSelection,),
              SizedBox(width: 15,),
              SelectButton(text: "Recipes", selectedText: selected, changeSelected: handleSelection,),
            ],
          ),
          
          selected == "Ingredients" ? IngredientSubpage(list: ingredientList) : RecipeSubpage(recipeList: recipeList,)
        ],
      ),
      floatingActionButton: selected == "Ingredients" ? FloatingActionButton(
              onPressed: () {showDialog(
                context: context,
                builder: (context){
                  //show InputIngredient from utils/addIngredient.dart
                  return InputIngredient(
                    nameController: nameController,
                    caloriesController: caloriesController,
                    proteinController: proteinController,
                    fatController: fatController,
                    carbsController: carbsController,
                    onSave: saveNewIngredient,
                    onCancel: onCancel,
                  );
                }
              );}, 
              child: Icon(Icons.add),
            ) : FloatingActionButton(onPressed: () => {showDialog(
              context: context,
              builder: (context){
                List<bool> isChecked = [];
                for(var _ in ingredientList){
                  isChecked.add(false);
                }
                return InputRecipe(
                  ingredients: ingredientList, 
                  isChecked: isChecked, 
                  nameController: recipeNameController, 
                  onSave: saveNewRecipe,
                  onCancel: (){
                    recipeNameController.clear(); 
                    Navigator.of(context).pop();}
                  );
              }
            )}),

    );
  }
}