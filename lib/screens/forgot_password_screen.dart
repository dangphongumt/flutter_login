import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../utilities/constants.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reset password"),
      ),
      body: Column(
        children: [
          _buildEmailTF(emailController),
          _buildSubmitBtn(emailController),
        ],
      ),
    );
  }

  Widget _buildEmailTF(dynamic textController) {
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

  Widget _buildSubmitBtn(TextEditingController email) {
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
          print("Resset password button pressed!!!!");
          // signIn(email: email.text, password: password.text);
        },
        child: const Text(
          "Submit",
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
}
