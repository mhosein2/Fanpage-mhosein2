import 'package:fanpage/screens/adminpage.dart';
import 'package:fanpage/screens/homepage.dart';

import '../reusuable_widgets/reusuable_widgets.dart';
import 'package:fanpage/screens/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



void main() {
  runApp(MaterialApp(
      home: Scaffold(
          appBar: AppBar(
    title: Text("Fanpage"),
    centerTitle: true,
    backgroundColor: Colors.black54,
  ))));
}

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.blue,
          child: Padding(
              padding: EdgeInsets.fromLTRB(
                  20, MediaQuery.of(context).size.height * 0.2, 20, 0),
              child: Column(children: <Widget>[
                 reusableTextField("Enter E-Mail Address", Icons.person_outline,
                    false, _emailTextController),
                SizedBox(
                  height: 20,
                ),
                 reusableTextField("Enter Password", Icons.lock_outline, true,
                    _passwordTextController),
                SizedBox(
                  height: 20,
                ),
                signInSignUpButton(context, true, () {
                  FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: _emailTextController.text,
                          password: _passwordTextController.text)
                      .then((value) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  });
                }),
                signUpOpt()
              ]))),
    );
  }

  Row signUpOpt() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Need an account? ", style: TextStyle(color: Colors.white)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
          child: const Text(
            "Sign Up",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
