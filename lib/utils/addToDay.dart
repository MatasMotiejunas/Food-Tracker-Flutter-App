import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/IngList.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:flutter_application_1/utils/recipeList.dart';
import 'package:flutter_application_1/utils/searchBar.dart';
import 'package:flutter_application_1/utils/selectedButton.dart';

class AddToDay extends StatefulWidget {

  final List ingredients;
  final List recipes;
  final List<TextEditingController> weightControllers;
  List<int> isCheckedIng = [];
  List<int> isCheckedRec = [];
  List<int> showIngredientIndex = []; 
  List<int> showRecipeIndex = [];

  String selected = "Ingredients";

  final void Function(List<int>, List<TextEditingController>, List<int>) onSave;
  final VoidCallback onCancel;

  AddToDay({super.key, 
  required this.ingredients,
  required this.recipes,
  required this.weightControllers,
  required this.onSave,
  required this.onCancel}){
    showIngredientIndex = List.generate(ingredients.length, (i) => i);
    showRecipeIndex = List.generate(recipes.length, (i) => i);
  }

  @override
  State<AddToDay> createState() => _AddToDayState();
}

class _AddToDayState extends State<AddToDay> {

  void checkName(String search){
    setState(() {
      if(widget.selected == "Ingredients"){
        if (search.isEmpty) {
          widget.showIngredientIndex = List.generate(widget.ingredients.length, (i) => i);
        }else{
          widget.showIngredientIndex = [
            for(int i=0; i<widget.ingredients.length; i++)
              if(widget.ingredients[i][NAME].toLowerCase().contains(search.toLowerCase()))
                i
          ]; 
        }
      }else{
        if(search.isEmpty){
          widget.showRecipeIndex = List.generate(widget.recipes.length, (i) => i);
        }else{
          widget.showRecipeIndex = [
            for(int i=0; i<widget.recipes.length; i++)
              if(widget.recipes[i][0].toLowerCase().contains(search.toLowerCase()))
                i
          ];
        }
      }
      
    });
  }


  void changeSelected(String select){
    setState(() {
      widget.selected = select;
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
            Row(
              children:[
                SelectButton(text: "Ingredients", selectedText: widget.selected, changeSelected: changeSelected),
                SelectButton(text: "Recipes", selectedText: widget.selected, changeSelected: changeSelected),

              ]
            ),
           
            MySearchBar(check: checkName),

            widget.selected == "Ingredients" ? 
              IngredientList(showIngredientIndex: widget.showIngredientIndex,
                isChecked: widget.isCheckedIng, 
                ingredients: widget.ingredients, 
                weightControllers: widget.weightControllers) :
              RecipeList(showRecipeIndex: widget.showRecipeIndex,
                isChecked: widget.isCheckedRec,
                recipes: widget.recipes,),
            
            

            //Save and Cancel Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MaterialButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: () => widget.onSave(widget.isCheckedIng, widget.weightControllers, widget.isCheckedRec),
                  child: Text("Save"),
                ),
                
                const SizedBox(width: 5),

                MaterialButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: widget.onCancel,
                  child: Text("Cancel"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}