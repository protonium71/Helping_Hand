import 'package:flutter/material.dart';
import 'package:helping_hand/models/organisation.dart';
import 'package:helping_hand/resources/auth_services.dart';

//This class is used as the singleton class for the user
//It provides the user object
class OrganisationProvider with ChangeNotifier {
  Organisation? _user;

  Organisation get getOrganisation => _user!;

  Future<void> refreshUser() async {
    Organisation user = await AuthService().getOrganisationDetails();
    _user = user;
    notifyListeners();
  }
}