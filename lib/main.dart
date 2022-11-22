import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todolist_lite/views/Auth_Page.dart';
import 'package:todolist_lite/views/Forgot_Password_Page.dart';
import 'package:todolist_lite/views/Home.dart';
import 'package:todolist_lite/views/Logging_Page.dart';
import 'package:todolist_lite/views/Login_Page.dart';
import 'package:todolist_lite/views/Register_Page.dart';
import 'package:todolist_lite/views/Task_Detail_Page.dart';
import 'package:todolist_lite/views/Task_Page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: Logging.routeNames,
      routes: {
        Home.routeNames: (context) => Home(),
        TaskDetailPage.routeNames: (context) => TaskDetailPage(),
        TaskPage.routeNames: (context) => TaskPage(),
        AuthPage.routeNames: (context) => AuthPage(),
        Logging.routeNames: (context) => Logging(),
        ForgotPasswordPage.routeName: (context) => ForgotPasswordPage()
      },
    );
  }
}
