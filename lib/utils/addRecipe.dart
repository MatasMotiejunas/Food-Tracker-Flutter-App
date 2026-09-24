import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/ingredient.dart';

class InputRecipe extends StatefulWidget {

  final List<Ingredient> ingredients;
  List<bool> isChecked;

  InputRecipe({super.key, required this.ingredients, required this.isChecked});

  @override
  State<InputRecipe> createState() => _InputRecipeState();
}

class _InputRecipeState extends State<InputRecipe> {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.amberAccent,
      content: Container(
        height: 300,
        width: 250,
        color: Colors.green,
        child: ListView.builder(
          itemCount: widget.ingredients.length,
          itemBuilder: (context, index) => 
            Row(children: 
              [
                Checkbox(value: widget.isChecked[index], onChanged:(value) {
                  setState(() {
                    widget.isChecked[index] = value!;
                  });
                    
                },),
                Text(widget.ingredients[index].name),

              ]
            ),
          
        )
      ),
    );
  }
}