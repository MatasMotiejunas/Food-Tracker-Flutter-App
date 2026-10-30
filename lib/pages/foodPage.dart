import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/database.dart';
import 'package:flutter_application_1/utils/addIngredient.dart';
import 'package:flutter_application_1/utils/addRecipe.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:flutter_application_1/utils/ingredientSubpage.dart';
import 'package:flutter_application_1/utils/ingredient.dart';
import 'package:flutter_application_1/utils/recipeSubpage.dart';
import 'package:flutter_application_1/utils/selectedButton.dart';
import 'package:hive_flutter/hive_flutter.dart';



class FoodPage extends StatefulWidget {
  Database db;

  FoodPage({super.key, required this.db});

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {

  final myBox = Hive.box('myBox');



  //Controllers for each of the input fields when adding an ingredient
  final TextEditingController nameController = TextEditingController();
  final TextEditingController caloriesController = TextEditingController();
  final TextEditingController proteinController = TextEditingController();
  final TextEditingController fatController = TextEditingController();
  final TextEditingController carbsController = TextEditingController();
  final TextEditingController recipeNameController = TextEditingController();


  String selected = "Ingredients";

  void clearIngredientControllers(){
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
      

      widget.db.ingredientList.add([name.trim(), 
      double.tryParse(calories)?? 0.0, 
      double.tryParse(protein)?? 0.0, 
      double.tryParse(fat)?? 0.0, 
      double.tryParse(carbs)?? 0.0]);

      clearIngredientControllers();
    });
    Navigator.of(context).pop();
    widget.db.updateDatabase();
  }

  List<TextEditingController> generateControllers(){
    List<TextEditingController> list = [];
    for(var _ in widget.db.ingredientList){
      list.add(TextEditingController());
    }
    return list;
  }

  void saveNewRecipe(List<bool> chosenIngredients, List<TextEditingController> weightControllers){
    bool allFalse = !chosenIngredients.contains(true);
    if (allFalse) return;

    setState((){
      List toAdd = [];

      for(int i=0; i<chosenIngredients.length; i++){
        if(chosenIngredients[i]){
          var ingredientWithWeight = [];
          for(var data in widget.db.ingredientList[i]){
            ingredientWithWeight.add(data);
          }

          String w = weightControllers[i].text;

          var weight = double.tryParse(w) ?? 0.0;
          ingredientWithWeight.add(weight);
          toAdd.add(ingredientWithWeight);
        }
      }
      
      widget.db.recipeList.add([recipeNameController.text.trim(), toAdd]);
      

      recipeNameController.clear();
      
    });

    Navigator.of(context).pop();
    widget.db.updateDatabase();
  }

  void onCancel () {
    Navigator.of(context).pop();
    clearIngredientControllers();
  }

  void handleSelection(String value){
    setState(() {
      selected = value;
    });
  }

  void resetHive(){
    setState(() {
      myBox.clear();
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
          
          selected == "Ingredients" ? IngredientSubpage(list: widget.db.ingredientList) : RecipeSubpage(recipeList: widget.db.recipeList,)
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
                for(var _ in widget.db.ingredientList){
                  isChecked.add(false);
                }
                return InputRecipe(
                  ingredients: widget.db.ingredientList, 
                  isChecked: isChecked, 
                  nameController: recipeNameController, 
                  weightControllers: generateControllers(),
                  onSave: saveNewRecipe,
                  onCancel: (){
                    recipeNameController.clear(); 
                    Navigator.of(context).pop();}
                  );
              }
              
            )},
            child: Icon(Icons.add),
            ),
            persistentFooterButtons: [
              MaterialButton(onPressed: resetHive,
              child: Text("Clear Hive"),),
            ],

    );
  }
}