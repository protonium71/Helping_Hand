import 'package:flutter/material.dart';
import 'package:helping_hand/resources/auth_services.dart';
import 'package:helping_hand/user_type_page.dart';
import 'package:helping_hand/views/organisation/post_event_page.dart';
import 'package:helping_hand/widgets/my_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async{
              await AuthService().logoutUser();
              // ignore: use_build_context_synchronously
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const UserType(),
                ),
              );
            }, 
            icon: const Icon(Icons.logout)
          )
        ],
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