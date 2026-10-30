import 'package:flutter/material.dart';

List<TextEditingController> generateControllers(int length){
  List<TextEditingController> list = [];
  for(int i=0; i<length; i++){
    list.add(TextEditingController());
  }
  return list;
}