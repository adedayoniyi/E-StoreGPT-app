import 'package:flutter/material.dart';

import '../models/admin_model.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    fullname: '',
    username: '',
    email: '',
    password: '',
    token: '',
    id: '',
  );

  //creating getter for user
  User get user => _user;

  void setUser(String user) {
    //data fromjson coming from models/user.dart
    _user = User.fromJson(user);
    notifyListeners();
  }
}
