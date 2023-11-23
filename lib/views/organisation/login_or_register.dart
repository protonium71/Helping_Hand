import 'package:flutter/material.dart';
import 'package:helping_hand/views/organisation/login_page.dart';
import 'package:helping_hand/views/organisation/register_page.dart';

// ignore: must_be_immutable
class LoginOrRegisterPageOrg extends StatefulWidget {
  BuildContext parent;
  LoginOrRegisterPageOrg({super.key, required this.parent});

  @override
  State<LoginOrRegisterPageOrg> createState() => _LoginOrRegisterPageOrgState();
}

class _LoginOrRegisterPageOrgState extends State<LoginOrRegisterPageOrg> {

  //show initially login page
  bool showLoginPage = true;

  //toggle between login and register page
  void togglePages(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showLoginPage){
      return LoginPageOrg(onTap: togglePages, parent: widget.parent);
    }
    else{
      return RegisterPageOrg(onTap: togglePages);
    }
  }
}