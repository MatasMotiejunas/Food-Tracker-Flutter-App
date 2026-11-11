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


  late DayData today;

  @override
  void initState() {
    DateTime now = DateTime.now();
    DateTime nowNormal = DateTime(now.year, now.month, now.day);
    // if(widget.db.days.containsKey(nowNormal)){
    //   today = DayData.createEaten(nowNormal, widget.db.days[nowNormal]);
    // }else{
    //   widget.db.days.update(nowNormal, (value) => value, ifAbsent: () => []);
    //   widget.db.updateDayDatabase();
    //   today = DayData.createEmpty(nowNormal);
    // }

  print("Before initialisation: ${widget.db.days}");
    List value = widget.db.days.putIfAbsent(nowNormal, () => []);
    today = DayData.createEaten(nowNormal, value);
    
    widget.db.updateDayDatabase();
    print("At initialisation: ${widget.db.days}");
    super.initState();
  }

  void addIngredients(List<int> chosenIngredients, List<TextEditingController> weightControllers){
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
      }
      
    });

    Navigator.of(context).pop();
    widget.db.days.update(today.date, (value) => today.eaten, ifAbsent: () => []);
    widget.db.updateDayDatabase();
    print("Updated value: ${widget.db.days}");
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
          Text("Carbs: ${today.carbs}"),
          Text("Fiber: ${today.fiber}"),],
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