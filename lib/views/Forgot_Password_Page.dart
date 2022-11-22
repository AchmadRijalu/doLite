import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ForgotPasswordPage extends StatefulWidget {
  static const routeName = "/ForgotPassword";
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password?"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
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
                      // color: Colors.amber,
                      padding: const EdgeInsets.all(14),
                      width: double.infinity,
                      height: 240,
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
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(children: [
                          Container(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Forgot",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 28,
                                    fontFamily: "Quicksand"),
                              ),
                              Text(
                                "Password?",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 28,
                                    fontFamily: "Quicksand"),
                              ),
                            ],
                          ))
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
                                height: 18,
                              ),
                              Container(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "Please enter the email associated with your account.",
                                        style: TextStyle(
                                            fontFamily: "Quicksand",
                                            fontWeight: FontWeight.w700,
                                            color: Colors.grey.shade500),
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
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 16),
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
                                        "Submit",
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
