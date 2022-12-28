part of 'Pages.dart';

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
            return TaskPage();
          } else {
            return AuthPage();
          }
        },
      ),
    );
  }
}
