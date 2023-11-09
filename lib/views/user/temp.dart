import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:helping_hand/models/user.dart' as model;
import 'package:helping_hand/utilities/utils.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';

class Temp extends StatelessWidget {
  const Temp({super.key});

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
          ],
        ),
      ),
    );
  }
}