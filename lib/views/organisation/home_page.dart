import 'package:flutter/material.dart';
import 'package:helping_hand/views/organisation/post_event_page.dart';
import 'package:helping_hand/widgets/my_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key,});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState(){
    super.initState();
    // print("hii");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true, 
        backgroundColor: const Color(0xffCDD4E0),
        title: const Text('Home Feed'),
      ),
      body: SafeArea(
        child: MyButton(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const PostEventPage()));
          }, 
          text: "Go to post event",
        )
      ),
    );
  }
}