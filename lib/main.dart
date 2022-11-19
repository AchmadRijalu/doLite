import 'package:flutter/material.dart';
import 'package:todolist_lite/views/Home.dart';
import 'package:todolist_lite/views/Login_Page.dart';
import 'package:todolist_lite/views/Register_Page.dart';
import 'package:todolist_lite/views/Task_View.dart';

void main() {
  runApp(const MyApp());
}

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
      initialRoute: LoginPage.routeNames,
      routes: {
        Home.routeNames: (context) => Home(),
        TaskView.routeNames: (context) => TaskView(),
        LoginPage.routeNames: (context) => LoginPage(),
        RegisterPage.routeName: (context) => RegisterPage()
      },
    );
  }
}
