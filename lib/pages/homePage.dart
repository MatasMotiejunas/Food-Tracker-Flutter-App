import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/database.dart';
import 'package:flutter_application_1/utils/addToDay.dart';
import 'package:flutter_application_1/utils/dayData.dart';
import 'package:flutter_application_1/utils/functions.dart';

//
// Shows todays details (eaten things, progress bar)
// Eaten Ingredients and Recipes can be added
//
class HomePage extends StatefulWidget {
  
  Database db;

  HomePage({super.key, required this.db});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  DayData today = DayData(date: DateTime.now());
  int counter = 0;

  void addIngredients(List<int> chosenIngredients, List<TextEditingController> weightControllers){
    
    print("List is: " + chosenIngredients.toString());
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
      
      for(var ing in toAdd){
        today.addIngredient(ing);
        counter++;
      }
      
      print(today.calories);
      print(today.eaten);
      
    });

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.tealAccent[100],
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text("Home Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, 
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          Text("Calories: ${today.calories}"), 
          Text("Protein :${today.protein}"),
          Text("Fat: ${today.fat}"),
          Text("Carbs: ${today.carbs}"),],
        ),
      ),

      //Add eaten Ingredient
      floatingActionButton: FloatingActionButton(onPressed: (){
        showDialog(
          context: context,
          builder: (context) {
            List<int> isChecked = [];
            return AddToDay(
              ingredients: widget.db.ingredientList, 
              weightControllers: generateControllers(widget.db.ingredientList.length), 
              isChecked: isChecked, 
              onSave: addIngredients,
              onCancel: (){
                Navigator.of(context).pop();
              });
          }
        );
      }),
      );
  }
}