import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:helping_hand/resources/auth_page.dart';
import 'package:helping_hand/widgets/my_button.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> with SingleTickerProviderStateMixin{
  @override
  void initState(){
    //super.initState();
    //SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(Duration(seconds: 0),(){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const AuthPage()));
    });
  }
  // @override
  // void dispose(){
  //   super.dispose();
  //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
  // }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
    //backgroundColor: Colors.red,
    body: Container(
        
      decoration: const BoxDecoration(
        gradient: LinearGradient(
        begin: Alignment(1.00, -0.08),
        end: Alignment(-1, 0.08),
        colors: [Color(0xFF92A3FD), Color(0xFF9DCEFF)],
        ),
        
      ),
      // ignore: prefer_const_constructors
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          //SizedBox(height: height * 0.3,),
          Center(
            child: Text(
              "Helping Hand",
              style: TextStyle(
                color: Colors.white,
                fontSize: 45,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text('making a difference', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),),
          //SizedBox(height: height * 0.35,),
          // GestureDetector(
          //   onTap: (){
          //     Navigator.pop(context);
          //     Navigator.push(context, MaterialPageRoute(builder: (context) =>
          //                 AuthPage()));
          //   },
          //   // child: Container(
          //   //   padding: const EdgeInsets.all(20),
          //   //   margin: const EdgeInsets.symmetric(horizontal: 25),
          //   //   decoration: ShapeDecoration(
          //   //     color: Color.fromARGB(255, 235, 236, 237), 
                
          //   //   shape: RoundedRectangleBorder(
          //   //     borderRadius: BorderRadius.circular(50),
          //   //   ), 
          //   //   ),
          //   //   child: Center(
          //   //     child: Text('Get Started', style: const TextStyle(color: Color(0xFF92A3FD), fontWeight: FontWeight.bold, fontSize: 20),),
          //   //   ),
          //   // ),
          // ),
        ],
      ),
    ),
        );
  }
  }




