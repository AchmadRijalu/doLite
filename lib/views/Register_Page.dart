import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todolist_lite/main.dart';

class RegisterPage extends StatefulWidget {
  final Function() onClickSignUp;
  static const routeName = "/RegisterPage";
  const RegisterPage({super.key, required this.onClickSignUp});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  void initState() {
    // TODO: implement initState
    super.initState();
    this.emailController;
    this.usernameController;
    this.passwordController;
  }

  final _keyState = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _passwordVisible = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  void _onLoading() {
    showDialog(
        context: context,
        builder: ((context) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Color(0XFF2D31FA),
              color: Colors.blueGrey,
            ),
          );
        }));
    Future.delayed(new Duration(seconds: 3), () {
      Navigator.pop(context); //pop dialog
    });
    navigatorKey.currentState!.popUntil((route) => route.isActive);
  }

  Future signUp() async {
    try {
      _onLoading();
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } on FirebaseException catch (e) {
      if (e.code == "email-already-in-use") {
        return Fluttertoast.showToast(
            msg: "${"Email is already in use"}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }

      print(e);
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    }
  }

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
                      child: Image.asset(
                        "assets/images/logo/doLite-logo.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                              key: _keyState,
                              child: Column(
                                children: [
                                  Container(
                                    child: TextFormField(
                                      controller: emailController,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: (value) {
                                        return !EmailValidator.validate(
                                                value.toString())
                                            ? "Please include '@' in the email address "
                                            : null;
                                      },
                                      decoration: InputDecoration(
                                          label: Text(
                                        "Email",
                                        style: TextStyle(
                                            fontFamily: "Quicksand",
                                            fontWeight: FontWeight.w700,
                                            color: Colors.grey.shade400),
                                      )),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  // Container(
                                  //   child: TextFormField(
                                  //     autovalidateMode:
                                  //         AutovalidateMode.onUserInteraction,
                                  //     autofocus: false,
                                  //     controller: usernameController,
                                  //     validator: (value) {
                                  //       return value.toString().length < 4
                                  //           ? "Username must at least 4 characters"
                                  //           : null;
                                  //     },
                                  //     decoration: InputDecoration(
                                  //       label: Text(
                                  //         "Username",
                                  //         style: TextStyle(
                                  //             fontFamily: "Quicksand",
                                  //             fontWeight: FontWeight.w700,
                                  //             color: Colors.grey.shade400),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  // SizedBox(
                                  //   height: 6,
                                  // ),
                                  Container(
                                    child: TextFormField(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      obscureText: _passwordVisible,
                                      autofocus: false,
                                      controller: passwordController,
                                      validator: (value) {
                                        return value.toString().length < 8
                                            ? "Password must at least 8 characters"
                                            : null;
                                      },
                                      decoration: InputDecoration(
                                          label: Text(
                                            "Password",
                                            style: TextStyle(
                                                fontFamily: "Quicksand",
                                                fontWeight: FontWeight.w700,
                                                color: Colors.grey.shade400),
                                          ),
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              _passwordVisible
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                              color: Colors.black,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _passwordVisible =
                                                    !_passwordVisible;
                                              });
                                            },
                                          )),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 18,
                                  ),
                                  Container(
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
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
                                      onPressed: (() {
                                        if (!_keyState.currentState!
                                            .validate()) {
                                          Fluttertoast.showToast(
                                              msg:
                                                  "Please fill the form as a format!",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor:
                                                  Color(0XFF2D31FA),
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                        } else {
                                          signUp();
                                        }
                                      }),
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
                                RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = widget.onClickSignUp,
                                        text: "Login",
                                        style: TextStyle(
                                            color: Color(0XFF2D31FA),
                                            fontFamily: "Quicksand",
                                            fontWeight: FontWeight.w700)),
                                  ]),
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
