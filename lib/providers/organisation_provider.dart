import 'package:flutter/material.dart';
import 'package:helping_hand/models/organisation.dart';
import 'package:helping_hand/models/user.dart';
import 'package:helping_hand/resources/auth_services.dart';

//This class is used as the singleton class for the user
//It provides the user object
class OrganisationProvider with ChangeNotifier {
  Organisation? _organisation;

  Organisation get getOrganisation => _organisation!;

  Future<void> refreshOrganisation() async {
    Organisation organisation = await AuthService().getOrganisationDetails();
    _organisation = organisation;
    notifyListeners();
  }
}