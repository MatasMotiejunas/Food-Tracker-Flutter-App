import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/ingredient.dart';

class InputRecipe extends StatefulWidget {

  final List<Ingredient> ingredients;
  final TextEditingController nameController;
  List<bool> isChecked;

  final ValueChanged<List<bool>> onSave;
  final VoidCallback onCancel;

  InputRecipe({super.key, required this.ingredients, required this.nameController, required this.isChecked, required this.onSave, required this.onCancel});

  @override
  State<InputRecipe> createState() => _InputRecipeState();
}

class _InputRecipeState extends State<InputRecipe> {


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
            Expanded(
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
                  onPressed: () => widget.onSave(widget.isChecked),
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