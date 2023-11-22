import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:helping_hand/resources/auth_services.dart';
import 'package:helping_hand/widgets/my_button.dart';
import 'package:helping_hand/widgets/my_textField.dart';
import 'package:helping_hand/widgets/square_tile.dart';

// ignore: must_be_immutable
class RegisterPageOrg extends StatefulWidget {
  void Function()? onTap;

  RegisterPageOrg({super.key, required this.onTap});

  @override
  State<RegisterPageOrg> createState() => _RegisterPageOrgState();
}

class _RegisterPageOrgState extends State<RegisterPageOrg> {
  //text editing controllers
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //sign user in method
  void signUserUp() async{
    //show loading circle
    showDialog(context: context, builder: (context){
      return const Center(
        child: CircularProgressIndicator(),
      );
    });

    String res;

    QuerySnapshot query = await FirebaseFirestore.instance.collection('organisations').where('email',isEqualTo:emailController.text).get();
    if (query.docs.isEmpty){
      //signup user
      // ignore: use_build_context_synchronously
      res = await AuthService().signUpOrganisation(
        email: emailController.text,
        password: passwordController.text,
        orgname: userNameController.text,
        context: context
      );
    }
    else{
      res = 'user-already-present';
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    }

    //WRONG EMAIL
    if(res == 'invalid-email'){
      showErrorMessage('Invalid Email!');
    }

    //EMPTY FIELDS
    else if(res == 'Enter email and password'){
      showErrorMessage('Enter email and password!');
    }

    //WRONG PASSWORD
    else if(res == 'user-already-present'){
      showErrorMessage('User already present with given email!');
    }

    else{
      showErrorMessage('User registered successfully!');
    }
  }

  void showErrorMessage(String message){
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text(message),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return  Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              //logo
              SizedBox(height: height*0.05,),
              const Icon(Icons.lock, size: 50,),
        
              //Lets create an account for you
              SizedBox(height: height*0.01,),
              Text("Lets create an account for you", 
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 20,
                ),
              ),

              //firstname textfield
              SizedBox(height: height*0.02,),
              MyTextField(controller: userNameController, hintText: "Organisation Name", obscureText: false, icon: const Icon(Icons.person_2_outlined)),
              
              //email textfield
              SizedBox(height: height*0.01,),
              MyTextField(controller: emailController, hintText: "Email", obscureText: false, icon: const Icon(Icons.email_outlined),),
        
              //password textfield
              SizedBox(height: height*0.01,),
              MyTextField(controller: passwordController, hintText: "Password", obscureText: true, icon: const Icon(Icons.lock_outline)),
        
              //sign up button
              SizedBox(height: height*0.02),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: MyButton(onTap: signUserUp, text: 'Sign Up',),
              ),
        
              //or continue with
              SizedBox(height: height*0.02),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  children: [
                    Expanded(child: Divider(thickness: 0.5, color: Colors.grey[400],)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text("Or continue with", style: TextStyle(color: Colors.grey[700]),),
                    ),
                    Expanded(child: Divider(thickness: 0.5, color: Colors.grey[400],)),
                  ],
                ),
              ),
        
              //google sign in
              SizedBox(height: height*0.035),
              SquareTile(
                onTap: () async {
                  bool res = false;
                  await AuthService().signInWithGoogleOrg(context: context);
                  if(FirebaseAuth.instance.currentUser != null){
                    res = true;
                  }
                  await AuthService().logoutUser();
                  if(res){
                    showErrorMessage("User registered successfully!");
                  }
                  else{
                    showErrorMessage("An Error occurred!");
                  }
                },
                imagePath: 'lib/assets/images/google.png',
              ),
        
              //not a member sign up
              SizedBox(height: height*0.035),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have an account?', style: TextStyle(color: Colors.grey[700]),),
                  const SizedBox(width: 4,),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text('Login Now', style: TextStyle(color: Color(0xff6379A5), fontWeight: FontWeight.bold),)
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}