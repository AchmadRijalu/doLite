import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:todolist_lite/utils/Loading.dart';
import 'package:todolist_lite/views/Auth_Page.dart';
import 'package:todolist_lite/views/Login_Page.dart';

import 'Home.dart';

class Logging extends StatelessWidget {
  static const routeNames = "Logging";
  const Logging({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Text(""));
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Something went wrong :("),
            );
          } else if (snapshot.hasData) {
            return Home();
          } else {
            return AuthPage();
          }
        },
      ),
    );
  }
}
