import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/IngList.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:flutter_application_1/utils/searchBar.dart';


//
// Dialog for creating a Recipe
//
class InputRecipe extends StatefulWidget {

  final List ingredients;
  final TextEditingController nameController;
  final List<TextEditingController> weightControllers;
  List<bool> isChecked;
  //List of indexes of those ingredients, that have to be shown under the SearchBar
  List<int> showIngredientIndex = []; 

  final void Function(List<bool>, List<TextEditingController>) onSave;
  final VoidCallback onCancel;


  InputRecipe({super.key, 
  required this.ingredients, 
  required this.nameController, 
  required this.weightControllers,
  required this.isChecked, 
  required this.onSave, 
  required this.onCancel}){
        showIngredientIndex = List.generate(ingredients.length, (i) => i);
  }

  @override
  State<InputRecipe> createState() => _InputRecipeState();
}

class _InputRecipeState extends State<InputRecipe> {

  //Updates the shown list when interacting with the SearchBar
  void checkName(String search){
    setState(() {
      if (search.isEmpty) {
        //show all
        widget.showIngredientIndex = List.generate(widget.ingredients.length, (i) => i);
      }else{
        //show the ones that contain the input string 'search'
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

            //Creates the List with Checkbox, Ingredient and Weight Input
            IngredientList(showIngredientIndex: widget.showIngredientIndex,
              isChecked: widget.isChecked, 
              ingredients: widget.ingredients, 
              weightControllers: widget.weightControllers),
           
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(), 
                hintText: "Name",
              ),
              controller: widget.nameController,
            ),

            SizedBox(height: 10),


            //Save and Cancel Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MaterialButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: () => widget.onSave(widget.isChecked, widget.weightControllers),
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
        )
      ),
    );
  }
}