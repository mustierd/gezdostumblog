import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String butonText;
  final Color butonColor;
  final Color textColor;
  final VoidCallback onPressed;

  const MyButton(
      {Key key,
      this.butonText,
      this.butonColor,
      this.onPressed,
      this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(29),
      child: RaisedButton(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        color: butonColor,
        splashColor: Colors.green[700],
        child: Text(
          butonText,
          style: TextStyle(color: textColor),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
