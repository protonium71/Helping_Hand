import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:helping_hand/resources/auth_services.dart';
import 'package:helping_hand/views/user/navigation.dart';
import 'package:helping_hand/widgets/my_button.dart';
import 'package:helping_hand/widgets/my_textField.dart';
import 'package:helping_hand/widgets/square_tile.dart';
import 'package:helping_hand/views/user/forget_pw_page.dart';

// ignore: must_be_immutable
class LoginPage extends StatefulWidget {
  void Function()? onTap;
  BuildContext parent;

  LoginPage({super.key, required this.onTap, required this.parent});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final formKey = GlobalKey<FormState>();
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

    //login user
    String res = await AuthService().loginUser(
      email: emailController.text,
      password: passwordController.text,
    );

    // ignore: avoid_print
    print(res);

    // ignore: use_build_context_synchronously
    Navigator.pop(context);

    //WRONG EMAIL
    if(res == 'invalid-email'){
      showErrorMessage('Invalid Email!');
    }

    //EMPTY FIELDS
    if(res == 'Enter email and password'){
      showErrorMessage('Enter email and password!');
    }

    //WRONG PASSWORD
    if(res == 'INVALID_LOGIN_CREDENTIALS'){
      showErrorMessage('Incorrect login credentials!');
    }

    if (FirebaseAuth.instance.currentUser != null) {
      // ignore: use_build_context_synchronously
      Navigator.pop(widget.parent);
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const Navigation(),
        ),
      );
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
      body: GestureDetector(
        onTap: () => {
          FocusScope.of(context).requestFocus(
            FocusNode(),
          ),
        },
        child: Form(
          key: formKey,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //logo
                  SizedBox(height: height*0.05,),
                  const Icon(Icons.lock, size: 100,),
                      
                  //welcome, you have been missed
                  SizedBox(height: height*0.05,),
                  Text("Welcome back you've been missed", 
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 20,
                    ),
                  ),
                      
                  //username textfield
                  SizedBox(height: height*0.04,),
                  MyTextField(controller: emailController, hintText: "Email", obscureText: false, icon: const Icon(Icons.email_outlined),),
                      
                  //password textfield
                  SizedBox(height: height*0.025,),
                  MyTextField(controller: passwordController, hintText: "Password", obscureText: true, icon: const Icon(Icons.lock_outline)),
                      
                  //forgot password
                  SizedBox(height: height*0.015,),
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
                          child: const Text(
                            "Forgot password?",
                            style: TextStyle(color: Color(0xff6379A5), fontSize: 15,),
                          ),
                        ),
                      ],
                    ),
                  ),
                      
                  //sign in button
                  SizedBox(height: height*0.075),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: MyButton(onTap: signUserIn, text: 'Sign In',),
                  ),
                      
                  //or continue with
                  SizedBox(height: height*0.06),
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
                  SizedBox(height: height*0.04),
                  SquareTile(
                    onTap: () async {
                      await AuthService().signInWithGoogle(context: context);
                      if (FirebaseAuth.instance.currentUser != null) {
                        // ignore: use_build_context_synchronously
                        Navigator.pop(widget.parent);
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const Navigation(),
                          ),
                        );
                      }
                    },
                    imagePath: 'lib/assets/images/google.png',
                  ),
                      
                  //not a member sign up
                  SizedBox(height: height*0.04),
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
        ),
      ),
    );
  }
}