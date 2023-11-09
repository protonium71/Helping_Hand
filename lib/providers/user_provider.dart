import 'package:flutter/material.dart';
import 'package:helping_hand/models/user.dart';
import 'package:helping_hand/resources/auth_services.dart';

//This class is used as the singleton class for the user
//It provides the user object
class UserProvider with ChangeNotifier {
  User? _user;

  User get getUser => _user!;

  Future<void> refreshUser() async {
    User user = await AuthService().getUserDetails();
    _user = user;
    notifyListeners();
  }
}