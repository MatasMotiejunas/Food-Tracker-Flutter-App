import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/IngList.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:flutter_application_1/utils/searchBar.dart';

class AddToDay extends StatefulWidget {

  final List ingredients;
  final List<TextEditingController> weightControllers;
  List<int> isChecked;
  List<int> showIngredientIndex = []; 

  AddToDay({super.key, 
  required this.ingredients,
  required this.weightControllers,
  required this.isChecked}){
    showIngredientIndex = List.generate(ingredients.length, (i) => i);
  }

  @override
  State<AddToDay> createState() => _AddToDayState();
}

class _AddToDayState extends State<AddToDay> {

  void checkName(String search){
    setState(() {
      if (search.isEmpty) {
        widget.showIngredientIndex = List.generate(widget.ingredients.length, (i) => i);
      }else{
        widget.showIngredientIndex = [
          for(int i=0; i<widget.ingredients.length; i++)
            if(widget.ingredients[i][NAME].toLowerCase().contains(search.toLowerCase()))
              i
        ];
        
      }
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.amberAccent,
      content: Container(
        height: 400,
        width: 250,
        color: Colors.green,
        child: Column(
          children: [
            MySearchBar(check: checkName),

            IngredientList(showIngredientIndex: widget.showIngredientIndex,
              isChecked: widget.isChecked, 
              ingredients: widget.ingredients, 
              weightControllers: widget.weightControllers),
          ],
        ),
      ),
    );
  }
}