import 'package:flutter/material.dart';
import 'package:helping_hand/views/organisation/login_or_register.dart';
import 'package:helping_hand/views/user/login_or_register.dart';
import 'package:helping_hand/widgets/my_button.dart';

class UserType extends StatelessWidget {
  const UserType({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 50,),
              const Text(
                "Choose user",
                style: TextStyle(
                    color: Color(0xFF1D1517),
                    fontSize: 30,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 50,),
              Image.asset(
                "lib/assets/images/select.png",
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 150,),
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