import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/database.dart';
import 'package:flutter_application_1/utils/addToDay.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:flutter_application_1/utils/day.dart';

class HomePage extends StatefulWidget {
  
  Database db;

  HomePage({super.key, required this.db});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<TextEditingController> generateControllers(){
    List<TextEditingController> list = [];
    for(var _ in widget.db.ingredientList){
      list.add(TextEditingController());
    }
    return list;
  }

  Day today = Day(date :DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.tealAccent[100],
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text("Home Page"),
      ),
      body: today,
      floatingActionButton: FloatingActionButton(onPressed: (){
        showDialog(
          context: context,
          builder: (context) {
            List<bool> isChecked = [];
            for(var _ in widget.db.ingredientList){
              isChecked.add(false);
            }
            return AddToDay(
              ingredients: widget.db.ingredientList, 
              weightControllers: generateControllers(), 
              isChecked: isChecked);
          }
        );
      }),
      );
  }
}