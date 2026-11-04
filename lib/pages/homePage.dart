import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/database.dart';
import 'package:flutter_application_1/utils/addToDay.dart';
import 'package:flutter_application_1/utils/day.dart';
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

  Day today = Day(date: DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.tealAccent[100],
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text("Home Page"),
      ),
      body: today,

      //Add eaten Ingredient
      floatingActionButton: FloatingActionButton(onPressed: (){
        showDialog(
          context: context,
          builder: (context) {
            List<int> isChecked = [];
            return AddToDay(
              ingredients: widget.db.ingredientList, 
              weightControllers: generateControllers(widget.db.ingredientList.length), 
              isChecked: isChecked);
          }
        );
      }),
      );
  }
}