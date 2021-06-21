import 'package:flutter/material.dart';

class UserModel extends ChangeNotifier {
  UserModel({this.isLoggedIn = false});
  bool isLoggedIn;

  bool get userAccountState => isLoggedIn;

  void userLoggedIn() {
    isLoggedIn = true;
    notifyListeners();
  }

  void userLoggedOut() {
    isLoggedIn = false;
    notifyListeners();
  }
}
