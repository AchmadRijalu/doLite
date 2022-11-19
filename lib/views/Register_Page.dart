import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class RegisterPage extends StatefulWidget {
  static const routeName = "/RegisterPage";
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.all(24),
        // color: Colors.blue,
        width: double.infinity,
        height: double.infinity,
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Expanded(
              child: Container(
            padding: const EdgeInsets.all(12),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      width: double.infinity,
                      height: 240,
                      child: Image.asset(
                        "assets/images/register_image.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(children: [
                          Text(
                            "Sign Up",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 28,
                                fontFamily: "Quicksand"),
                          )
                        ]),
                        Container(
                          child: Form(
                              child: Column(
                            children: [
                              Container(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      label: Text(
                                    "Email",
                                    style: TextStyle(
                                        fontFamily: "Quicksand",
                                        fontWeight: FontWeight.w700,
                                        color: Colors.grey),
                                  )),
                                ),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Container(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      label: Text(
                                    "Username",
                                    style: TextStyle(
                                        fontFamily: "Quicksand",
                                        fontWeight: FontWeight.w700,
                                        color: Colors.grey),
                                  )),
                                ),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Container(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      label: Text(
                                    "Password",
                                    style: TextStyle(
                                        fontFamily: "Quicksand",
                                        fontWeight: FontWeight.w700,
                                        color: Colors.grey),
                                  )),
                                ),
                              ),
                              SizedBox(
                                height: 18,
                              ),
                              Container(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "By signing up, You'll attract your task easily with doLite",
                                        style: TextStyle(
                                            fontFamily: "Quicksand",
                                            fontWeight: FontWeight.w700,
                                            color: Colors.grey.shade400),
                                      )
                                    ]),
                              ),
                            ],
                          )),
                        ),
                      ],
                    )),
                  ),
                  Expanded(
                      child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  height: 44,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          backgroundColor: Color(0XFF2D31FA)),
                                      onPressed: (() {}),
                                      child: Text(
                                        "Sign up",
                                        style: TextStyle(
                                            fontFamily: "Quicksand",
                                            fontWeight: FontWeight.w700),
                                      )),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                              ]),
                        ),
                        Flexible(
                            child: Container(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Joined before?",
                                  style: TextStyle(
                                      fontFamily: "Quicksand",
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Ink(
                                  child: InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "Login",
                                        style: TextStyle(
                                            color: Color(0XFF2D31FA),
                                            fontFamily: "Quicksand",
                                            fontWeight: FontWeight.w700),
                                      )),
                                )
                              ]),
                        ))
                      ],
                    ),
                  )),
                ]),
          )),
        ]),
      )),
    );
  }
}
