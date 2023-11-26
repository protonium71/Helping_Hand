import 'package:flutter/material.dart';
import 'package:helping_hand/views/organisation/login_or_register.dart';
import 'package:helping_hand/views/user/login_or_register.dart';
import 'package:helping_hand/widgets/my_button.dart';

class UserType extends StatelessWidget {
  const UserType({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: height*0.02,),
                const Text(
                  "Choose user",
                  style: TextStyle(
                      color: Color(0xFF1D1517),
                      fontSize: 30,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: height*0.07,),
                Image.asset(
                  "lib/assets/images/select.png",
                  fit: BoxFit.cover,
                ),
                SizedBox(height: height*0.25,),
                MyButton(onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginOrRegisterPage(parent: context)));
                }, text: "Volunteer"),
                SizedBox(height: height*0.05,),
                MyButton(onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginOrRegisterPageOrg(parent: context)));
                }, text: "Organisation"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}