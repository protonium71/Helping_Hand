import 'package:flutter/material.dart';
import 'package:helping_hand/views/organisation/login_or_register.dart';
import 'package:helping_hand/views/user/login_or_register.dart';
import 'package:helping_hand/widgets/my_button.dart';

class UserType extends StatelessWidget {
  const UserType({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyButton(onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginOrRegisterPage(parent: context)));
              }, text: "Volunteer"),
              const SizedBox(height: 50,),
              MyButton(onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginOrRegisterPageOrg(parent: context)));
              }, text: "Organisation"),
            ],
          ),
        ),
      ),
    );
  }
}