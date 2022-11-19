import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:todolist_lite/views/Home.dart';
import 'package:todolist_lite/views/Register_Page.dart';

class LoginPage extends StatefulWidget {
  static const routeNames = "/LoginPage";
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                      padding: const EdgeInsets.all(12),
                      width: double.infinity,
                      height: 240,
                      child: Image.asset(
                        "assets/images/logo/doLite-logo.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                        child: Column(
                      children: [
                        Row(children: [
                          Text(
                            "Login",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 28,
                                fontFamily: "Quicksand"),
                          )
                        ]),
                        Container(
                          child: Form(
                              child: Column(
                            children: [
                              Container(
                                child: TextFormField(),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Container(
                                child: TextFormField(),
                              )
                            ],
                          )),
                        ),
                        SizedBox(
                          height: 14,
                        ),
                        Container(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                      fontFamily: "Quicksand",
                                      fontWeight: FontWeight.w700,
                                      color: Colors.blueAccent),
                                )
                              ]),
                        ),
                      ],
                    )),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Expanded(
                      flex: 2,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Container(
                                      height: 44,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              backgroundColor:
                                                  Color(0XFF2D31FA)),
                                          onPressed: (() {
                                            Navigator.pushNamed(
                                                context, Home.routeNames);
                                          }),
                                          child: Text(
                                            "Login",
                                            style: TextStyle(
                                                fontFamily: "Quicksand",
                                                fontWeight: FontWeight.w700),
                                          )),
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Container(
                                      child: Row(children: [
                                        Expanded(
                                            flex: 2,
                                            child: Container(child: Divider())),
                                        Expanded(
                                            child: Container(
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "OR",
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontFamily: "Quicksand",
                                                      fontWeight:
                                                          FontWeight.w700),
                                                )
                                              ]),
                                        )),
                                        Expanded(
                                            flex: 2,
                                            child: Container(
                                              child: Divider(),
                                            ))
                                      ]),
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Container(
                                      height: 44,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              backgroundColor:
                                                  Colors.grey.shade200),
                                          onPressed: (() {}),
                                          child: Row(
                                            children: [
                                              Flexible(
                                                child: Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(horizontal: 4),
                                                  child: Image.asset(
                                                    "assets/images/logo/google-logo.png",
                                                    height: 32,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                  flex: 3,
                                                  child: Container(
                                                      // color: Colors.red,
                                                      child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "Login with Google",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black38,
                                                            fontFamily:
                                                                "Quicksand",
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                      ),
                                                    ],
                                                  )))
                                            ],
                                          )),
                                    ),
                                  ]),
                            ),
                            Flexible(
                                child: Container(
                              child: Container(
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "New to DoLite?",
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
                                              Navigator.pushNamed(context,
                                                  RegisterPage.routeName);
                                            },
                                            child: Text(
                                              "Register",
                                              style: TextStyle(
                                                  color: Color(0XFF2D31FA),
                                                  fontFamily: "Quicksand",
                                                  fontWeight: FontWeight.w700),
                                            )),
                                      )
                                    ]),
                              ),
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
