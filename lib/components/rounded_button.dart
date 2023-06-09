import 'package:flutter/material.dart';



class RoundedButton extends StatelessWidget {
  late Color colours;
  late String text;
  late final VoidCallback onPressed;
  RoundedButton(this.colours,this.onPressed,this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: colours,
        //Colors.lightBlueAccent,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            //'Log In',
              text,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}