import 'package:flutter/material.dart';
import 'package:helping_hand/models/user.dart' as model;
import 'package:helping_hand/resources/notifications.dart';
import 'package:helping_hand/widgets/my_button.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';

class Temp extends StatefulWidget {
  const Temp({super.key});

  @override
  State<Temp> createState() => _TempState();
}

class _TempState extends State<Temp> {
  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context, listen: false).getUser;
    Map<String, dynamic> userMap = user.getData();
    print(user.email);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(userMap['email']),
            Text(userMap['uid']),
            MyButton(onTap: () => Notifications.createUserList('From Yash'), text: 'Send Notification')
          ],
        ),
      ),
    );
  }
}