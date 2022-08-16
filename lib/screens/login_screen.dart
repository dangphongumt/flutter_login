import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:login_app/database/authentication.dart';
import 'package:login_app/screens/forgot_password_screen.dart';
import 'package:login_app/screens/main_screen.dart';
import 'package:login_app/screens/sign_up_screen.dart';
import 'package:login_app/utilities/constants.dart';

//https://www.youtube.com/watch?v=6kaEbTfb444

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  get user => _auth.currentUser;
  bool _rememberMe = false;

  Widget _buildEmailTF(dynamic textController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Email',
          style: kLabelStyle,
        ),
        SizedBox(
          height: 10.0,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: textController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none, //line ngang trong input
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Enter your Email',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF(dynamic textController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Password',
          style: kLabelStyle,
        ),
        SizedBox(
          height: 10.0,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: textController,
            obscureText: true,
            // keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none, //line ngang trong input
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Enter your Password',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
          style: TextButton.styleFrom(
              textStyle: const TextStyle(
                  // fontSize: 20.0,
                  color: Colors.pink,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans'),
              primary: Colors.white),
          onPressed: () {
            print("Forgot password button pressed!!!!!!!!!!!!!!!!!");
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ForgotPasswordScreen(),
              ),
            );
          },
          child: const Text("Forgot Password?")),
    );
  }

  Widget _buildRememberMeCheckbox() {
    return Container(
      height: 20.0,
      child: Row(
        children: [
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: _rememberMe,
              checkColor: Colors.green,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value!;
                });
                print("Checkbox pressed!!!!");
              },
            ),
          ),
          Text(
            'Remember me',
            style: kLabelStyle,
          )
        ],
      ),
    );
  }

  Widget _buildLoginBtn(
      TextEditingController email, TextEditingController password) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity, //kéo chiều ngang
      child: ElevatedButton(
        // style: ButtonStyle(
        //   elevation: 0.1,
        // ),
        style: ElevatedButton.styleFrom(
          elevation: 0.1,
          padding: EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(30.0), //tạo border button tròn các cạnh
          ),
          primary: Colors.white,
        ),

        onPressed: () {
          // print("Login button pressed!!!!");
          signIn(email: email.text, password: password.text);
        },
        child: const Text(
          "LOGIN",
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget _buildSignInWithText() {
    return Column(
      children: [
        Text(
          '- OR - ',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Text(
          'Sign in with',
          style: kLabelStyle,
        ),
      ],
    );
  }

  Widget _buildSocialBtn(Function onTap, AssetImage logo) {
    return GestureDetector(
      onTap: onTap as Function(),
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ], //bóng mờ phía sau hình

          image: DecorationImage(
            image: logo,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialBtnRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildSocialBtn(() => print("Login with Facebook!!!!!"),
              AssetImage('assets/logos/facebook.jpg')),
          _buildSocialBtn(() => print("Login with Googlge!!!!!"),
              AssetImage('assets/logos/google.jpg')),
        ],
      ),
    );
  }

  Widget _buildSignUpBtn(TextEditingController email,
      TextEditingController password, bool showSpinner) {
    return GestureDetector(
      // onTap: () => print("Sign up button pressed!!"),
      onTap: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SignUpScreen(auth: _auth),
          ),
        );
        // setState(() {
        //   showSpinner = true;
        // });
        // try {
        //   print("createUserWithEmailAndPassword - start");
        //   final newUser = await _auth.createUserWithEmailAndPassword(
        //       email: email.text, password: password.text);
        //   if (newUser != null) {
        //     print("Sign up successfully!!!!!!!");
        //     // Navigator.pushNamed(context, 'home_screen');
        //   }
        // } catch (e) {
        //   print(e);
        // }
        // setState(() {
        //   showSpinner = false;
        // });
        print("Sign up button data: ${email.text} - ${password.text}");
      },
      child: RichText(
        text: const TextSpan(children: [
          TextSpan(
            text: "Don't have an Account?",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          TextSpan(
            text: "Sign Up",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ]),
      ),
    );
  }

  // final FirebaseAuth _auth = FirebaseAuth.instance;
  //   get user => _auth.currentUser;

  //SIGN UP METHOD
  //Future signUp({required String email, required String password}) async {
  // try {
  //   await _auth.createUserWithEmailAndPassword(
  //     email: email,
  //     password: password,
  //   );
  //   return null;
  // } on FirebaseAuthException catch (e) {
  //   return e.message;
  // }
  //}

  //SIGN IN METHOD
  Future signIn({required String email, required String password}) async {
    print("signIn - start ");
    if (user != null) {
      print("signIn method found a currentUser: ${user} ");
      // print("object")
      signOut();
    }
    try {
      dynamic user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      print("user signIn: ${user}");
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SIGN OUT METHOD
  Future signOut() async {
    print("signOut- start ");
    await _auth.signOut();

    print('signout');
  }

  @override
  Widget build(BuildContext context) {
    // dynamic firebase = Firebase.initializeApp();
    // print("Firebase.initializeApp data: ${firebase}");
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    // final FirebaseAuth _auth = FirebaseAuth.instance;
    print("LoginScreen - Start");
    print("Current user build: ${_auth.currentUser}");
    String email;
    String password;
    bool showSpinner = false;
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          //phat hien cu chi
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF73AEF5),
                      Color(0xFF61A4F1),
                      Color(0xFF478DE0),
                      Color(0xFF398AE5),
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 120.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Sign In",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'OpenSans',
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      _buildEmailTF(emailController),
                      SizedBox(
                        height: 30.0,
                      ),
                      _buildPasswordTF(passwordController),
                      _buildForgotPasswordBtn(),
                      _buildRememberMeCheckbox(),
                      _buildLoginBtn(emailController, passwordController),
                      _buildSignInWithText(),
                      //_buildSocialBtnRow(),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildSocialBtn(
                                () => print("Login with Facebook!!!!!"),
                                AssetImage('assets/logos/facebook.jpg')),
                            GestureDetector(
                              onTap: () async {
                                print("Login with Googlge!!!!!");
                                // setState(() {
                                //   _isSigningIn = true;
                                // });

                                User? user =
                                    await Authentication.signInWithGoogle(
                                        auth: _auth, context: context);

                                // setState(() {
                                //   _isSigningIn = false;
                                // });

                                if (user != null) {
                                  print(
                                      "Login with Googlge successfully: ${user}");
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => MainScreen(
                                          // user: user,
                                          ),
                                    ),
                                  );
                                } else {
                                  print("Login with google fail");
                                }
                              },
                              child: Container(
                                height: 60.0,
                                width: 60.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      offset: Offset(0, 2),
                                      blurRadius: 6.0,
                                    ),
                                  ], //bóng mờ phía sau hình

                                  image: DecorationImage(
                                    image:
                                        AssetImage('assets/logos/google.jpg'),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      _buildSignUpBtn(
                          emailController, passwordController, showSpinner),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
