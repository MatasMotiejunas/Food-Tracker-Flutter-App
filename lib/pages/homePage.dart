import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/database.dart';
import 'package:flutter_application_1/utils/addToDay.dart';
import 'package:flutter_application_1/utils/dayData.dart';
import 'package:flutter_application_1/utils/functions.dart';
import 'package:flutter_application_1/utils/updateDailyGoals.dart';

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

  TextEditingController caloriesGoalController = TextEditingController();
  TextEditingController proteinGoalController = TextEditingController();
  TextEditingController fatGoalController = TextEditingController();
  TextEditingController carbsGoalController = TextEditingController();
  TextEditingController fiberGoalController = TextEditingController();


  @override
  void initState() {
    DateTime now = DateTime.now();
    DateTime nowNormal = DateTime(now.year, now.month, now.day);


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

      //ChosenIngredients containc indeces of ingredients
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


  void saveGoals(){
    setState(() {
      int calories = int.tryParse(caloriesGoalController.text)?? -1; 
      int protein = int.tryParse(proteinGoalController.text)?? -1;
      int fat = int.tryParse(fatGoalController.text)?? -1; 
      int carbs = int.tryParse(carbsGoalController.text)?? -1;
      int fiber = int.tryParse(fiberGoalController.text)?? -1;

      if(calories != -1){
        widget.db.caloriesGoal = calories;
      }
      if(protein != -1){
        widget.db.proteinGoal = protein;
      }
      if(fat != -1){
        widget.db.fatGoal = fat;
      }
      if(carbs != -1){
        widget.db.carbsGoal = carbs;
      }
      if(fiber != -1){
        widget.db.fiberGoal = fiber;
      }
      clearControllers();
    });
    Navigator.of(context).pop();
    widget.db.updateFoodDatabase();
  }


  void onCancel(){
    Navigator.of(context).pop();
    clearControllers();
  }

  void clearControllers(){
    caloriesGoalController.clear();
    proteinGoalController.clear();
    fatGoalController.clear();
    carbsGoalController.clear();
    fiberGoalController.clear();
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
            Text("Calories ${today.calories} / ${widget.db.caloriesGoal}"),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
              child: LinearProgressIndicator(value: today.calories/widget.db.caloriesGoal),
            ),
            Text("Protein ${today.protein} / ${widget.db.proteinGoal}"),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
              child: LinearProgressIndicator(value: today.protein/widget.db.proteinGoal),
            ),            
            Text("Fat ${today.fat} / ${widget.db.fatGoal}"),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
              child: LinearProgressIndicator(value: today.fat/widget.db.fatGoal),
            ),
            Text("Carbs ${today.carbs} / ${widget.db.carbsGoal}"),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
              child: LinearProgressIndicator(value: today.carbs/widget.db.carbsGoal),
            ),
            Text("Fiber ${today.fiber} / ${widget.db.fiberGoal}"),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
              child: LinearProgressIndicator(value: today.fiber/widget.db.fiberGoal),
            ),      
            
            
            MaterialButton(
              onPressed: () {showDialog(
                context: context,
                builder: (context){
                  return UpdateGoals(
                    caloriesGoalController: caloriesGoalController,
                    proteinGoalController: proteinGoalController,
                    fatGoalController: fatGoalController,
                    carbsGoalController: carbsGoalController,
                    fiberGoalController: fiberGoalController,
                    onSave: saveGoals,
                    onCancel: onCancel,
                  );
                }, );},
              
              color: Colors.lightGreen,
              child: Text("Change Goals"),),
              
          ],
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

        },
        child: Icon(Icons.add)),
    );
  }
}