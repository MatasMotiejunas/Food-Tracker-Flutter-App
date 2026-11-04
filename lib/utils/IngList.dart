import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/constants.dart';


//
// Creates a List of Checkboxes, Ingredients and Weight Input fields
//
class IngredientList extends StatefulWidget {

  final List ingredients;
  final List<TextEditingController> weightControllers; 

  List<int> showIngredientIndex; 
  List<int> isChecked;

  
  IngredientList({super.key, 
  required this.showIngredientIndex,
  required this.isChecked, 
  required this.ingredients, 
  required this.weightControllers});

  @override
  State<IngredientList> createState() => _IngredientListState();
}

class _IngredientListState extends State<IngredientList> {
  @override
  Widget build(BuildContext context) {
    return  Expanded(
      child: widget.showIngredientIndex.isEmpty ? Text("No ingredient found") : ListView.builder(
        itemCount: widget.showIngredientIndex.length,
        itemBuilder: (context, listIndex){
            int index = widget.showIngredientIndex[listIndex];
            bool contains = widget.isChecked.contains(index);
            return Row(children: 
            [
              Checkbox(value: contains, onChanged:(value) {
                setState(() {
                  if(contains){
                    widget.isChecked.remove(index);
                  }else{
                    widget.isChecked.add(index);
                  }
                  
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
    );
  }
}