import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/addIngredient.dart';
import 'package:flutter_application_1/utils/ingredient.dart';
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

  List ingredientList = [
    //[name, calories, protein, fat, carbs]
    ["Ingredient 1", 520.3, 10.1, 15.2, 220.8],
    ["Ingredient 2", 550.1, 10.1, 15.2, 220.8],
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
      
      ingredientList.add([name.trim(), double.parse(calories), double.parse(protein), double.parse(fat), double.parse(carbs)]);
      clearControllers();
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
          
          Expanded(
            child: ListView.builder(
              //show ingredients
              itemCount:ingredientList.length,
              itemBuilder: (context, index){
                //create ingredient for an item in the list
                return Ingredient(
                  name: ingredientList[index][0],
                  caloriesPer100g: ingredientList[index][1],
                  proteinPer100g: ingredientList[index][2],
                  fatPer100g: ingredientList[index][3],
                  carbsPer100g: ingredientList[index][4],
                );
              },
            ),
          ),
        ],
      ),
      //Button for adding an ingredient
      floatingActionButton: FloatingActionButton(
        onPressed: () => {showDialog(
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
        )}, 
        child: Icon(Icons.add),
      ),
    );
  }
}