import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todolist_lite/models/toDo.dart';
import 'package:todolist_lite/views/Add_Task_Page.dart';
import 'package:todolist_lite/views/Auth_Page.dart';
import 'package:todolist_lite/views/Edit_Task_Page.dart';
import 'package:todolist_lite/views/Forgot_Password_Page.dart';
import 'package:todolist_lite/views/Home.dart';
import 'package:todolist_lite/views/Logging_Page.dart';
import 'package:todolist_lite/views/Login_Page.dart';
import 'package:todolist_lite/views/Register_Page.dart';
import 'package:todolist_lite/views/Task_Detail_Page.dart';
import 'package:todolist_lite/views/Task_Notification.dart';
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
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(
            color: Colors.black
          )
        ),
        primarySwatch: Colors.blue,
      ).copyWith(
        colorScheme: ThemeData().colorScheme.copyWith(primary: Colors.black),
      ),
      initialRoute: Logging.routeNames,
      routes: {
        Home.routeNames: (context) => Home(),
        AddTaskPage.routeNames: (context) => AddTaskPage(),
        TaskDetailPage.routeNames: (context) => TaskDetailPage(
          todoId: ModalRoute.of(context)!.settings.arguments as Map<dynamic,dynamic>
        ),
        AuthPage.routeNames: (context) => AuthPage(),
        Logging.routeNames: (context) => Logging(),
        ForgotPasswordPage.routeName: (context) => ForgotPasswordPage(),
        EditTaskPage.routeNames:(context) => EditTaskPage(
          id: ModalRoute.of(context)!.settings.arguments as Map<dynamic,dynamic>
        ),
        AddTaskPage.routeNames: (context) => AddTaskPage(),
        TaskNotification.routeNames: (context) => TaskNotification(),
      },
    );
  }
}
