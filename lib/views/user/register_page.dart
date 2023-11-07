import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:helping_hand/resources/auth_services.dart';
import 'package:helping_hand/utilities/my_button.dart';
import 'package:helping_hand/utilities/my_textField.dart';
import 'package:helping_hand/utilities/square_tile.dart';

// ignore: must_be_immutable
class RegisterPage extends StatefulWidget {
  void Function()? onTap;

  RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text editing controllers
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
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

    //try creating the user
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
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

      //WRONG EMAIL OR PASSWORD
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
              SizedBox(height: height*0.03,),
              Text("Lets create an account for you", 
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 20,
                ),
              ),

              //firstname textfield
              SizedBox(height: height*0.03,),
              MyTextField(controller: firstNameController, hintText: "First Name", obscureText: false, icon: const Icon(Icons.person_2_outlined)),
              
              //lastname textfield
              SizedBox(height: height*0.03,),
              MyTextField(controller: lastNameController, hintText: "Last Name", obscureText: false, icon: const Icon(Icons.person_2_outlined)),
        
        
              //email textfield
              SizedBox(height: height*0.03,),
              MyTextField(controller: emailController, hintText: "Email", obscureText: false, icon: const Icon(Icons.email_outlined),),
        
              //password textfield
              SizedBox(height: height*0.03,),
              MyTextField(controller: passwordController, hintText: "Password", obscureText: true, icon: const Icon(Icons.lock_outline)),
        
              //sign in button
              SizedBox(height: height*0.03),
              MyButton(onTap: signUserUp, text: 'Sign Up',),
        
              //or continue with
              SizedBox(height: height*0.07),
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
              SizedBox(height: height*0.045),
              SquareTile(
                onTap: () => AuthService().signInWithGoogle(),
                imagePath: 'lib/assets/google.png',
              ),
        
              //not a member sign up
              SizedBox(height: height*0.045),
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