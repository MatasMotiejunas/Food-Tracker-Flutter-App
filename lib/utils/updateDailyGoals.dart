import 'package:flutter/material.dart';

class UpdateGoals extends StatelessWidget {

  final TextEditingController caloriesGoalController;
  final TextEditingController proteinGoalController;
  final TextEditingController fatGoalController;
  final TextEditingController carbsGoalController;
  final TextEditingController fiberGoalController; 

  final VoidCallback onSave;
  final VoidCallback onCancel;

  const UpdateGoals({super.key,
  required this.caloriesGoalController, 
  required this.proteinGoalController,
  required this.fatGoalController, 
  required this.carbsGoalController,
  required this.fiberGoalController, 
  required this.onSave,
  required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.amberAccent,
      content: Container(
        color: Colors.green,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            Text("Calories"),
            //ingredient calories
            TextField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              controller: caloriesGoalController,
            ),

            Text("Protein"),
            //ingredient protein
            TextField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              controller: proteinGoalController,
            ),

            Text("Fat"),
            //ingredient fat
            TextField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              controller: fatGoalController,
            ),

            Text("Carbs"),
            //ingredient carbs
            TextField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              controller: carbsGoalController,
            ),


            Text("Fiber"),
            //ingredient carbs
            TextField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              controller: fiberGoalController,
            ),


            //Save and Cancel Buttons
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
            ),
          ],
        ),
      ),
    );
  }
}