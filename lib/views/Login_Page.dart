import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class LoginPage extends StatefulWidget {
  static const routeNames = "/Login";
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.all(24),
        color: Colors.blue,
        width: double.infinity,
        height: double.infinity,
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Expanded(
              child: Container(
            color: Colors.white,
            child: Column(children: [
              Container(
                padding: const EdgeInsets.all(12),
                width: double.infinity,
                height: 240,
                child: Image.asset(
                  "assets/images/login_image.jpg",
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                child: Row(children: [
                  Text(
                    "Login",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                  )
                ]),
              ),
              Container(
                child: Form(
                    child: Column(
                  children: [
                    Container(
                      child: TextFormField(),
                    ),
                    Container(
                      child: TextFormField(),
                    )
                  ],
                )),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: (() {}),
                    child: Text("Login"),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 5, 49, 85))),
                  ))
            ]),
          )),
        ]),
      )),
    );
  }
}
