import 'package:flutter/material.dart';
import 'package:helping_hand/views/user/login_page.dart';
import 'package:helping_hand/views/user/register_page.dart';

// ignore: must_be_immutable
class LoginOrRegisterPage extends StatefulWidget {
  BuildContext parent;
  LoginOrRegisterPage({super.key, required this.parent});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {

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
      return LoginPage(onTap: togglePages, parent: widget.parent);
    }
    else{
      return RegisterPage(onTap: togglePages);
    }
  }
}