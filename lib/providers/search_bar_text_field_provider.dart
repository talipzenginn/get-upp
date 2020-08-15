import 'package:flutter/material.dart';

class SearchBarTextFieldProvider extends ChangeNotifier{
  String query;
  final controller = TextEditingController();
  bool showCursor=false;

  void setQuery(String value){
    query = value;
    if(query == null||query==''){
      showCursor = false;
    }else{
      showCursor = true;
    }
    notifyListeners();
  }
  void removeQuery(){
    query = null;
    showCursor = false;
notifyListeners();
  }
  void controllerClear(){
    controller.clear();
    notifyListeners();
  }
}