import 'package:flutter/material.dart';
import 'package:chat/components/rounded_button.dart';
import 'package:chat/constants.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'package:chat/screens/chat_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  static const String id = "/login";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _spinner=false;
  late String email="";
  late String password="";
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall:_spinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: "logo",
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                  //Do something with the user input.
                },
                decoration:
                    kTextFieldDecoration.copyWith(hintText: "Enter your email"),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(

                textAlign: TextAlign.center,
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                  //Do something with the user input.
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: "Enter your password"),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(Colors.lightBlueAccent, () async {
                setState(() {
                  _spinner=true;
                });
                try {
                  UserCredential user = await _auth.signInWithEmailAndPassword(
                      email: email, password: password);
                  if (user != null) Navigator.pushNamed(context, ChatScreen.id);

                  setState(() {
                    _spinner=false;
                  });
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'user-not-found' || e.code == 'wrong-password') {
                    setState(() {
                      _spinner=false;
                    });
                    _showDialog(context, "WRONG CREDENTIALS !");
                  }
                }
              }, 'Log In'),
            ],
          ),
        ),
      ),
    );
  }
}

void _showDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Message"),
        content: Text(message),
        actions: [
          TextButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
