import 'package:chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:chat/components/rounded_button.dart';
import 'package:chat/constants.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = '/registration';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
   final FirebaseAuth _auth = FirebaseAuth.instance;
  late String email;
  bool _spinner= false;
  late String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      body:

      ModalProgressHUD(
        inAsyncCall: _spinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: "logo",
                child: Container(
                  height: 120.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email=value;

                  //Do something with the user input.
                },
                decoration: kTextFieldDecoration.copyWith(hintText:"Enter your email")
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(

                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                 password=value;
                  //Do something with the user input.
                },
                decoration: kTextFieldDecoration.copyWith(hintText:"Enter your password"),
              ),
              SizedBox(
                height: 24.0,
              ),
              /*RoundedButton(
                color: Colors.blueAccent,
                onPressed: () async {
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
                    if (newUser != null) {
                      Navigator.pushNamed(context, LoginScreen.id);
                    }
                  } catch (e) {
                    print(e);
                  }
                },
                text: 'Register',
              ),
*/

              RoundedButton(Colors.lightBlueAccent, ()async{
                setState(() {
                _spinner=true;
                });
                try {
                  final newUser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
                  if (newUser != null) {
                    Navigator.pushNamed(context,  ChatScreen.id);
                  }
                  setState(() {
                    _spinner=false;
                  });
                } catch (e) {
                  print(e);
                }

              },'Register'),
            ],
          ),
        ),
      ),
    );
  }
}



