import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:todolist_lite/widgets/Task_Tile.dart';

class SpendingPage extends StatelessWidget {
  static const routeNames = "Spending";
  const SpendingPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future signOut() async {
      Firebase.initializeApp();
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn().signOut().then((value) {});
    }

    return Scaffold(
        body: Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            ElevatedButton(
                onPressed: (() {
                  signOut();
                }),
                child: Text("Log out"))
          ]),
        )
      ]),
    ));
  }
}
