
import 'package:flutter/foundation.dart';

class ItemProvider extends ChangeNotifier{
  final List<String> _task = [];

  List<String> get task => _task;

  void add(String value){
    _task.add(value);
    notifyListeners();
  }

  void remove(int index){
    _task.removeAt(index);
    notifyListeners();
  }


}