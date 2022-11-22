import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:todolist_lite/views/Logging_Page.dart';
import 'package:todolist_lite/views/Login_Page.dart';
import 'package:todolist_lite/views/Register_Page.dart';

class AuthPage extends StatefulWidget {
  static const routeNames = "AuthPage";
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;
  @override
  Widget build(BuildContext context) => isLogin
      ? LoginPage(onClickSignUp: toggle)
      : RegisterPage(
          onClickSignUp: toggle,
        );

  void toggle() {
    setState(() {
      isLogin = !isLogin;
    });
  }
}
