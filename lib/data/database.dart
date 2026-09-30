import 'package:hive_flutter/hive_flutter.dart';

class Database {

  List ingredientList = [];
  List recipeList = [];

  final myBox = Hive.box('myBox');

  //run if app opened for the first time ever
  void createInitialdata(){
    ingredientList = [
      ["Ingredient 1", 520.3, 10.1, 15.2, 220.8],
      ["Ingredient 2", 550.1, 15.0, 3.1, 27.0],
      ["Ingredient 3", 250.9, 5.2, 2.6, 3.0],
    ];

    recipeList = [
      ["Recipe 1", [
        ["Ingredient 1", 520.3, 10.1, 15.2, 220.8],
        ["Ingredient 2", 550.1, 10.1, 15.2, 220.8]]],
      ["Recipe 2", [
        ["Ingredient 2", 550.1, 10.1, 15.2, 220.8],
        ["Ingredient 3", 250, 5, 2, 3]]],
    ];
  }


  void loadData(){
    ingredientList = myBox.get("INGREDIENTLIST");
    recipeList = myBox.get("RECIPELIST");
  }


  void updateDatabase(){
    myBox.put("INGREDIENTLIST", ingredientList);
    myBox.put("RECIPELIST", recipeList);
  }

}