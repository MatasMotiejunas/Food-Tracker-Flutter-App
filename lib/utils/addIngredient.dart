import 'package:flutter/material.dart';

class InputIngredient extends StatelessWidget {
  
  final TextEditingController nameController;
  final TextEditingController caloriesController;
  final TextEditingController proteinController;
  final TextEditingController fatController;
  final TextEditingController carbsController; 

  VoidCallback onSave;
  VoidCallback onCancel;

  InputIngredient({
    super.key, 
    required this.caloriesController, 
    required this.nameController, 
    required this.proteinController, 
    required this.fatController, 
    required this.carbsController,
    required this.onSave,
    required this.onCancel,});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.amberAccent,
      content: Container(
        color: Colors.green,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Ingredient:"),
            //ingredient name
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(), 
                hintText: "Name",
              ),
              controller: nameController,
            ),

            Text("Calories per 100g:"),
            //ingredient calories
            TextField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              controller: caloriesController,
            ),

            Text("Protein per 100g:"),
            //ingredient protein
            TextField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              controller: proteinController,
            ),

            Text("Fat per 100g:"),
            //ingredient fat
            TextField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              controller: fatController,
            ),

            Text("Carbs per 100g:"),
            //ingredient carbs
            TextField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              controller: carbsController,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MaterialButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: onSave,
                  child: Text("Save"),
                ),
                
                const SizedBox(width: 5),

                MaterialButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: onCancel,
                  child: Text("Cancel"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}