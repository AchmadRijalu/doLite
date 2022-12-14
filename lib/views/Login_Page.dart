part of 'Pages.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback onClickSignUp;
  static const routeNames = "/LoginPage";
  const LoginPage({super.key, required this.onClickSignUp});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.emailController;
    this.passwordController;
  }

  final _keyState = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _passwordVisible = true;
  bool isLoad = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  void _onLoading() {
    showDialog(
        context: context,
        builder: ((context) {
          return LoadingAnimation();
        }));
    Future.delayed(new Duration(seconds: 2), () {
      Navigator.pop(context); //pop dialog
    });
  }

  //Login via Email & Password
  Future signIn() async {
    LoadingAnimation();
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim())
          .catchError((err) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Alert!"),
                content: Text(err.message),
                actions: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0XFF2D31FA)),
                    child: Text("Ok"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });
        setState(() {
          isLoad = false;
        });
      });
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  //Sign in with google account
  Future<UserCredential?> signInWithGoogle() async {
    _onLoading();
    try {
      Firebase.initializeApp();
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoad == true
        ? LoadingAnimation()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            body: SafeArea(
                child: Container(
              padding: const EdgeInsets.all(24),
              // color: Colors.blue,
              width: double.infinity,
              height: double.infinity,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
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
                              height: 8,
                            ),
                            Expanded(
                              flex: 3,
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
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    child: Form(
                                        key: _keyState,
                                        child: Column(
                                          children: [
                                            Container(
                                              child: TextFormField(
                                                controller: emailController,
                                                autovalidateMode:
                                                    AutovalidateMode
                                                        .onUserInteraction,
                                                validator: (value) {
                                                  return !EmailValidator
                                                          .validate(
                                                              value.toString())
                                                      ? "Please include '@' in the email address "
                                                      : null;
                                                },
                                                decoration: InputDecoration(
                                                    prefixIcon:
                                                        Icon(Icons.email),
                                                    label: Text(
                                                      "Email",
                                                      style: TextStyle(
                                                          fontFamily:
                                                              "Quicksand",
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: Colors
                                                              .grey.shade500),
                                                    )),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 6,
                                            ),
                                            Container(
                                              child: TextFormField(
                                                autovalidateMode:
                                                    AutovalidateMode
                                                        .onUserInteraction,
                                                obscureText: _passwordVisible,
                                                autofocus: false,
                                                controller: passwordController,
                                                validator: (value) {
                                                  return value
                                                              .toString()
                                                              .length <
                                                          8
                                                      ? "Password must at least 8 characters"
                                                      : null;
                                                },
                                                decoration: InputDecoration(
                                                    prefixIcon:
                                                        Icon(Icons.lock),
                                                    label: Text("Password",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "Quicksand",
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: Colors.grey
                                                                .shade500)),
                                                    suffixIcon: IconButton(
                                                      icon: Icon(
                                                        _passwordVisible
                                                            ? Icons
                                                                .visibility_off
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
                                            )
                                          ],
                                        )),
                                  ),
                                  SizedBox(
                                    height: 18,
                                  ),
                                  Container(
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Ink(
                                            child: InkWell(
                                              onTap: (() {
                                                Navigator.push(
                                                    context, _SlideUp());
                                              }),
                                              child: Text(
                                                "Forgot Password?",
                                                style: TextStyle(
                                                    fontFamily: "Quicksand",
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.blueAccent),
                                              ),
                                            ),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        backgroundColor:
                                                            Color(0XFF2D31FA)),
                                                    onPressed: (() {
                                                      if (!_keyState
                                                          .currentState!
                                                          .validate()) {
                                                        Fluttertoast.showToast(
                                                            msg:
                                                                "Please fill the form as a format!",
                                                            toastLength: Toast
                                                                .LENGTH_SHORT,
                                                            gravity:
                                                                ToastGravity
                                                                    .BOTTOM,
                                                            timeInSecForIosWeb:
                                                                1,
                                                            backgroundColor:
                                                                Color(
                                                                    0XFF2D31FA),
                                                            textColor:
                                                                Colors.white,
                                                            fontSize: 16.0);
                                                      } else {
                                                        setState(() {
                                                          isLoad = true;
                                                        });
                                                        signIn();
                                                      }
                                                    }),
                                                    child: Text(
                                                      "Login",
                                                      style: TextStyle(
                                                          fontFamily:
                                                              "Quicksand",
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    )),
                                              ),
                                              SizedBox(
                                                height: 12,
                                              ),
                                              Container(
                                                child: Row(children: [
                                                  Expanded(
                                                      flex: 2,
                                                      child: Container(
                                                          child: Divider())),
                                                  Expanded(
                                                      child: Container(
                                                    child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            "OR",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontFamily:
                                                                    "Quicksand",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
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
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        backgroundColor: Colors
                                                            .grey.shade200),
                                                    onPressed: (() {
                                                      signInWithGoogle();
                                                    }),
                                                    child: Row(
                                                      children: [
                                                        Flexible(
                                                          child: Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        4),
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
                                                                      color: Colors
                                                                          .black38,
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
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "New to doLite?",
                                                  style: TextStyle(
                                                      fontFamily: "Quicksand",
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  width: 4,
                                                ),
                                                RichText(
                                                  text: TextSpan(children: [
                                                    TextSpan(
                                                        recognizer:
                                                            TapGestureRecognizer()
                                                              ..onTap = widget
                                                                  .onClickSignUp,
                                                        text: "Register",
                                                        style: TextStyle(
                                                            color: Color(
                                                                0XFF2D31FA),
                                                            fontFamily:
                                                                "Quicksand",
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700)),
                                                  ]),
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

//Animation Transition
Route _SlideUp() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        const ForgotPasswordPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
