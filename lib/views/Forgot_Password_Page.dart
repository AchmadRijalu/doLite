part of 'Pages.dart';

class ForgotPasswordPage extends StatefulWidget {
  static const routeName = "/ForgotPassword";
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  TextEditingController emailController = TextEditingController();
  final _keyState = GlobalKey<FormState>();
  void initState() {
    // TODO: implement initState
    super.initState();
    this.emailController;
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
  }

  void _onLoading() {
    showDialog(
        context: context,
        builder: ((context) {
          return LoadingAnimation();
          // return Center(
          //   child: CircularProgressIndicator(
          //     backgroundColor: Color(0XFF2D31FA),
          //     color: Colors.blueGrey,
          //   ),
          // );
        }));
  }

  Future resetPassword() async {
    _onLoading();
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());

      Future.delayed(new Duration(seconds: 1), () {
        Navigator.pop(context); //pop dialog
        return Fluttertoast.showToast(
            msg: "Password reset already sent",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Color(0XFF2D31FA),
            textColor: Colors.white,
            fontSize: 16.0);
      });

      // navigatorKey.currentState!.popUntil((route) => route.isFirst);

    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      return Fluttertoast.showToast(
          msg: "${e}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0XFF2D31FA),
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Forgot Password?",
          style: TextStyle(
              color: Colors.black,
              fontFamily: "Quicksand",
              fontWeight: FontWeight.bold),
        ),
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
                    child: Container(
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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                            color: Colors.grey),
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
                                      onPressed: (() {
                                        if (!_keyState.currentState!
                                            .validate()) {
                                          Fluttertoast.showToast(
                                              msg:
                                                  "Please fill the email form as a format!",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor:
                                                  Color(0XFF2D31FA),
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                        } else {
                                          resetPassword();
                                        }
                                      }),
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
