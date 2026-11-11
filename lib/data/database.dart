import 'package:hive_flutter/hive_flutter.dart';

class Database {

  List ingredientList = [];
  List recipeList = [];

  //Element: [date, [Ing/Rec (with weight), ...]]
  Map days = <DateTime, List>{};

  final myBox = Hive.box('myBox');


  //run if app opened for the first time ever
  void createInitialdata(){
    ingredientList = [
      ["Ingredient 1", 520.3, 10.1, 15.2, 220.8, 5.0],
      ["Ingredient 2", 550.1, 15.0, 3.1, 27.0, 2.3],
      ["Ingredient 3", 250.9, 5.2, 2.6, 3.0, 0.3],
    ];

    recipeList = [
      ["Recipe 1", [
        ["Ingredient 1", 520.3, 10.1, 15.2, 220.8, 5.0, 50.0],
        ["Ingredient 2", 550.1, 15.0, 3.1, 27.0, 2.3, 75.0]]],
      ["Recipe 2", [
        ["Ingredient 2", 550.1, 15.0, 3.1, 27.0, 2.3, 80.5],
        ["Ingredient 3", 250.9, 5.2, 2.6, 3.0, 0.3, 22.5]]],
    ];


  }


  void loadData(){
    ingredientList = myBox.get("INGREDIENTLIST");
    recipeList = myBox.get("RECIPELIST");
    days = myBox.get("DAYS");
    print("Loaded days: $days");
  }


  void updateDatabase(){
    myBox.put("INGREDIENTLIST", ingredientList);
    myBox.put("RECIPELIST", recipeList);
  }

  void updateDayDatabase(){
    myBox.put("DAYS", days);
    print("Updated hive: ${myBox.get("DAYS")}");
  }


}