

import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier{
  String _userName = '';

  String get userName => _userName;

  void getUser(String value){
    _userName = value;
    notifyListeners();
  }

  void clearName(){
    _userName = '';
    notifyListeners();
  }
}