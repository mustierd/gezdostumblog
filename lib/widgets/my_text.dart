import 'package:flutter/material.dart';

class MyTextLabel extends StatelessWidget {
  final String textString;
  final bool secBool;
  final Widget textIcon;
  final Function validatorText;
  final Function onSaved;

  const MyTextLabel(
      {Key key,
      this.textString,
      this.secBool,
      this.textIcon,
      this.validatorText,
      this.onSaved})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: size.height * 0.08,
        width: size.width * 0.8,
        decoration: BoxDecoration(
          color: Colors.grey[500].withOpacity(0.7),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: TextFormField(
            
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: textIcon,
              ),
              labelText: textString,
              labelStyle: TextStyle(color: Colors.white),
            ),
            obscureText: secBool,
            validator: validatorText,
            onSaved: onSaved,
          ),
        ),
      ),
    );
  }
}
