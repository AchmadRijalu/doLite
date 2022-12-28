part of 'Pages.dart';

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
