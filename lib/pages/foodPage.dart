import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/database.dart';
import 'package:flutter_application_1/utils/addIngredient.dart';
import 'package:flutter_application_1/utils/addRecipe.dart';
import 'package:flutter_application_1/utils/functions.dart';
import 'package:flutter_application_1/utils/ingredientSubpage.dart';
import 'package:flutter_application_1/utils/recipeSubpage.dart';
import 'package:flutter_application_1/utils/selectedButton.dart';
import 'package:hive_flutter/hive_flutter.dart';


//
// Shows the Ingredients or Recipes in the Database
// Also new Ingredients or Recipes can be created
//
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

  //For switching between Ingretiens and Recipes being shown
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


  void saveNewRecipe(List<int> chosenIngredients, List<TextEditingController> weightControllers){
    //If no ingredients were chosen. Stays in the Dialog window
    if (chosenIngredients.isEmpty) return; 


    setState((){
      List toAdd = [];

      //Goes through the whole list and adds only those ingredients, that were checked
      for(int i in chosenIngredients){
        
        var ingredientWithWeight = [];
        for(var data in widget.db.ingredientList[i]){
          ingredientWithWeight.add(data);
        }

        String w = weightControllers[i].text;

        var weight = double.tryParse(w) ?? 0.0;
        ingredientWithWeight.add(weight);
        toAdd.add(ingredientWithWeight);
        
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
              //Change between Ingredient or Recipe List
              SelectButton(text: "Ingredients", selectedText: selected, changeSelected: handleSelection,),
              SizedBox(width: 15,),
              SelectButton(text: "Recipes", selectedText: selected, changeSelected: handleSelection,),
            ],
          ),
          
          //Show the chosen List
          selected == "Ingredients" ? 
            IngredientSubpage(list: widget.db.ingredientList) : 
            RecipeSubpage(recipeList: widget.db.recipeList,)
        ],
      ),

      //Add new ingredient or Recipe
      floatingActionButton: selected == "Ingredients" ? FloatingActionButton(
              //Ingredient
              onPressed: () {showDialog(
                context: context,
                builder: (context){
                  //Dialog to add an Ingredient
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
              //Recipe
              context: context,
              builder: (context){
                //List for the Checkboxes
                List<int> isChecked = [];
                //Dialog to add a Recipe
                return InputRecipe(
                  ingredients: widget.db.ingredientList, 
                  isChecked: isChecked, 
                  nameController: recipeNameController, 
                  weightControllers: generateControllers(widget.db.ingredientList.length),
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