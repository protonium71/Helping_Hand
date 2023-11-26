import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_state_city_pro/country_state_city_pro.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:helping_hand/resources/auth_services.dart';
import 'package:helping_hand/widgets/my_button.dart';
import 'package:helping_hand/widgets/my_textField.dart';
import 'package:helping_hand/widgets/square_tile.dart';

// ignore: must_be_immutable
class RegisterPage extends StatefulWidget {
  void Function()? onTap;

  RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final formKey = GlobalKey<FormState>();
  //text editing controllers
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final country = TextEditingController();
  final state = TextEditingController();
  final city = TextEditingController();

  //sign user in method
  void signUserUp() async{
    //show loading circle
    showDialog(context: context, builder: (context){
      return const Center(
        child: CircularProgressIndicator(),
      );
    });

    String res;

    QuerySnapshot query = await FirebaseFirestore.instance.collection('users').where('email',isEqualTo:emailController.text).get();
    if (query.docs.isEmpty){
      //signup user
      // ignore: use_build_context_synchronously
      res = await AuthService().signUpUser(
        email: emailController.text,
        password: passwordController.text,
        username: userNameController.text,
        location: city.text,
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
    if(res == 'Enter email and password'){
      showErrorMessage('Enter email and password!');
    }

    //WRONG PASSWORD
    if(res == 'user-already-present'){
      showErrorMessage('User already present with given email!');
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
    double width = MediaQuery.of(context).size.width;

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
                  MyTextField(controller: userNameController, hintText: "First Name", obscureText: false, icon: const Icon(Icons.person_2_outlined)),
                  
                  //location
                  SizedBox(height: height*0.01,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width*0.06),
                    child: CountryStateCityPicker(
                      country: country,
                      state: state,
                      city: city,
                      dialogColor: Colors.grey.shade200,
                      textFieldDecoration: InputDecoration(
                        fillColor: Colors.grey.shade200,
                        filled: true,
                        suffixIcon: const Icon(Icons.arrow_downward_rounded), 
                        border:  const OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(3.0)))),
                    ),
                  ),
                  
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
                      await AuthService().signInWithGoogle(context: context);
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
        ),
      ),
    );
  }
}