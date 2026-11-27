import 'package:flutter/material.dart';

class RecipeList extends StatefulWidget {
  RecipeList({super.key,
  required this.recipes,
  required this.isChecked, 
  required this.showRecipeIndex});

  final List recipes;
  List<int> isChecked;
  List<int> showRecipeIndex;
  

  @override
  State<RecipeList> createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  @override
  Widget build(BuildContext context) {
    return  Expanded(
      child: widget.showRecipeIndex.isEmpty ? Text("No recipe found") : ListView.builder(
        itemCount: widget.showRecipeIndex.length,
        itemBuilder: (context, listIndex){
            int index = widget.showRecipeIndex[listIndex];
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
              Text(widget.recipes[index][0]),
              
            ]
            );
          }

        
      ),
    );
  }
}