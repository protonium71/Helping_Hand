import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:helping_hand/resources/auth_services.dart';
import 'package:helping_hand/utilities/my_button.dart';
import 'package:helping_hand/utilities/my_textField.dart';
import 'package:helping_hand/utilities/square_tile.dart';
import 'package:helping_hand/views/user/forget_pw_page.dart';

// ignore: must_be_immutable
class LoginPage extends StatefulWidget {
  void Function()? onTap;

  LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //sign user in method
  void signUserIn() async{

    //show loading circle
    showDialog(context: context, builder: (context){
      return const Center(
        child: CircularProgressIndicator(),
      );
    });

    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text, 
        password: passwordController.text
      );
      //pop the loading circle
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } on FirebaseAuthException catch(e){
      //pop the loading circle
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      print(e.code);

      //WRONG EMAIL
      if(e.code == 'invalid-email'){
        showErrorMessage('Invalid Email!');
      }

      //WRONG PASSWORD
      if(e.code == 'INVALID_LOGIN_CREDENTIALS'){
        showErrorMessage('Incorrect login credentials!');
      }
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
    return  Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //logo
              const SizedBox(height: 30,),
              const Icon(Icons.lock, size: 100,),
        
              //welcome, you have been missed
              const SizedBox(height: 40,),
              Text("Welcome back you've been missed", 
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 20,
                ),
              ),
        
              //username textfield
              const SizedBox(height: 35,),
              MyTextField(controller: emailController, hintText: "Email", obscureText: false, icon: const Icon(Icons.email_outlined),),
        
              //password textfield
              const SizedBox(height: 25,),
              MyTextField(controller: passwordController, hintText: "Password", obscureText: true, icon: const Icon(Icons.lock_outline)),
        
              //forgot password
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (context){
                              return const ForgetPasswordPage();
                            }
                          )
                        );
                      },
                      child: Text(
                        "Forgot password?",
                        style: TextStyle(color: Colors.grey[600], fontSize: 15,),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 55,),
        
              //sign in button
              const SizedBox(height: 25),
              MyButton(onTap: signUserIn, text: 'Sign In',),
        
              //or continue with
              const SizedBox(height: 50),
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
              const SizedBox(height: 40),
              SquareTile(
                onTap: () => AuthService().signInWithGoogle(),
                imagePath: 'lib/assets/google.png',
              ),
        
              //not a member sign up
              const SizedBox(height: 75),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Not a member?', style: TextStyle(color: Colors.grey[700]),),
                  const SizedBox(width: 4,),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text('Register Now', style: TextStyle(color: Color(0xff6379A5), fontWeight: FontWeight.bold),)
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