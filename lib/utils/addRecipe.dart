import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:flutter_application_1/utils/ingredient.dart';
import 'package:flutter_application_1/utils/searchBar.dart';

class InputRecipe extends StatefulWidget {

  final List ingredients;
  final TextEditingController nameController;
  final List<TextEditingController> weightControllers;
  List<bool> isChecked;

  final void Function(List<bool>, List<TextEditingController>) onSave;
  final VoidCallback onCancel;

  List<int> showIngredientIndex = [];

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
            Expanded(
              child: widget.showIngredientIndex.isEmpty ? Text("No ingredient found") : ListView.builder(
                itemCount: widget.showIngredientIndex.length,
                itemBuilder: (context, listIndex){
                    int index = widget.showIngredientIndex[listIndex];
                    return Row(children: 
                    [
                      Checkbox(value: widget.isChecked[index], onChanged:(value) {
                        setState(() {
                          widget.isChecked[index] = value!;
                        });
                          
                      },),
                      Text(widget.ingredients[index][NAME]),
                      SizedBox(width: 15,),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            keyboardType: TextInputType.numberWithOptions(decimal: true),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Weight",
                            ),
                            controller: widget.weightControllers[index],
                          ),
                        ),
                      ),
                    ]
                    );
                  }

                
              ),
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(), 
                hintText: "Name",
              ),
              controller: widget.nameController,
            ),

            SizedBox(height: 10),

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