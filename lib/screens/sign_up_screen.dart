import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:login_app/utilities/constants.dart';

class SignUpScreen extends StatefulWidget {
  final FirebaseAuth auth;
  const SignUpScreen({super.key, required this.auth});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late FirebaseAuth authT = widget.auth;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    print("SignUpScreen - Start");
    print("Current user build: ${authT.currentUser}");
    bool showSpinner = false;
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.transparent,
        title: const Text("Sign Up"),
      ),
      body: Stack(
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
              ),
            ),
          ),
          Container(
            height: double.infinity,
            child: SingleChildScrollView(
              // img logo k bi bể khi mở bàn phím
              physics: AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                //thu gọn các phần tử bên trong
                horizontal: 40.0,
                vertical: 120.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SizedBox(
                  //   height: 30.0,
                  // ),
                  _buildNameTF(),
                  // SizedBox(
                  //   height: 30.0,
                  // ),
                  _buildEmailTF(),
                  // SizedBox(
                  //   height: 30.0,
                  // ),
                  _buildPasswordTF(),
                  _buildConfirmPasswordTF(),
                  _buildCreateAccountBtn(),
                  _buildSignInWithText(),
                  _buildSocialBtnRow(),
                  _buildLoginBtn(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   'Email',
        //   style: kLabelStyle,
        // ),
        SizedBox(
          height: 10.0,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: emailController,
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

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   'Password',
        //   style: kLabelStyle,
        // ),
        SizedBox(
          height: 10.0,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: passwordController,
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

  Widget _buildConfirmPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   'Password',
        //   style: kLabelStyle,
        // ),
        SizedBox(
          height: 10.0,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: confirmPasswordController,
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
              hintText: 'Confirm your Password',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNameTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   'Name',
        //   style: kLabelStyle,
        // ),
        SizedBox(
          height: 10.0,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: nameController,
            keyboardType: TextInputType.name,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none, //line ngang trong input
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              hintText: 'Enter your Name',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCreateAccountBtn() {
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

        onPressed: () async {
          print("Create account button pressed!!!!");
          // signIn(email: email.text, password: password.text);

          //   setState(() {
          //   showSpinner = true;
          // });
          if (passwordController.text
                  .compareTo(confirmPasswordController.text) ==
              0) {
            try {
              print("createUserWithEmailAndPassword - start");
              final newUser = await authT.createUserWithEmailAndPassword(
                  email: emailController.text,
                  password: passwordController.text);
              if (newUser != null) {
                print("Sign up successfully!!!!!!!");
                print("newUser: ${newUser}");
                // Navigator.pushNamed(context, 'home_screen');
              }
            } catch (e) {
              print(e);
            }
          } else {
            print("Wrong confirmPassword - Sign Up fail");
          }

          setState(() {
            showSpinner = false;
          });
          // print("Sign up button data: ${email.text} - ${password.text}");
        },
        child: const Text(
          "Create Account",
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

  Widget _buildLoginBtn() {
    return GestureDetector(
      // onTap: () => print("Sign up button pressed!!"),
      onTap: () {
        Navigator.pop(context);

        print("Log in in SignUp Screen pressed!!!");
      },
      child: RichText(
        text: const TextSpan(children: [
          TextSpan(
            text: "Already have an account?",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          TextSpan(
            text: "Log In",
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
}
