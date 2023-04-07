import 'package:flutter/material.dart';
import 'package:chat/screens/login_screen.dart';
import "package:chat/screens/registration_screen.dart";
import 'package:chat/components/rounded_button.dart';
class WelcomeScreen extends StatefulWidget {
  static const String id = "/";
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {

  late AnimationController controller;
  late Animation animation;
  late Animation anime;
  @override
  void initState(){
    super.initState();
    controller=AnimationController(upperBound:1 ,duration:Duration(seconds: 3) , vsync: this);
    animation=CurvedAnimation(parent: controller, curve: Curves.easeIn);
    //anime=ColorTween(begin: Colors.grey, end: Colors.orange, animate(controller));
    controller.forward();

    controller.addListener(() { setState(() {

    });});
  }

  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Hero(
                    tag: "logo",
                    child: Container(
                      child: Image.asset('images/logo.png'),
                      height: animation.value * 100,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(Colors.lightBlueAccent,() {

              Navigator.pushNamed(context, LoginScreen.id);
            },'Log In'),
            RoundedButton(Colors.blueAccent, () {
 
              Navigator.pushNamed(context, RegistrationScreen.id);
            },'Register'),

          ],
        ),
      ),
    );
  }
}


