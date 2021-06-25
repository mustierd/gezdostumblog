import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gezdostumblog/database/firebase_signin.dart';
import 'package:gezdostumblog/navigation/buttomMenu/bottom_bridge.dart';
import 'package:gezdostumblog/widgets/insert_image.dart';
import 'package:gezdostumblog/widgets/my_button.dart';
import 'package:gezdostumblog/widgets/my_divider.dart';
import 'package:gezdostumblog/widgets/my_text.dart';
import 'package:gezdostumblog/screens/new_password.dart';
import 'package:gezdostumblog/screens/register.dart';
import 'package:gezdostumblog/funcitons/validation_mixin.dart';
import '../widgets/my_back-ground-img.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPage();
  }
}

class _LoginPage extends State<LoginPage> with ValidationMixin {
  final formKey1 = GlobalKey<FormState>();
  FireBaseSignIn fbSignIn = FireBaseSignIn();

  bool _loadingState = false;
  String email, password;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Stack(
          children: <Widget>[
            MyBackgroundImg(
              myImage: "assets/images/background/hiking-22.jpg",
            ),
            Scaffold(
              backgroundColor: Colors.transparent,
              body: _loadingState
                  ? Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      child: Form(
                        key: formKey1,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                          child: Column(
                            children: <Widget>[
                              InsertImage(
                                imageHeight: 160,
                                imageWidth: 200,
                                imageLink: "assets/gezdostumlogo.png",
                              ),
                              Divider(
                                color: Colors.green[900],
                                endIndent: 78,
                                indent: 72,
                                height: 16,
                                thickness: 5,
                              ),
                              Text(
                                "Türkiye'nin gezgin topluluğuna \n               HOŞGELDİN",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              MyTextLabel(
                                textString: "Email",
                                secBool: false,
                                textIcon: Icon(
                                  Icons.supervised_user_circle,
                                  color: Colors.green[900],
                                ),
                                validatorText: (String value) {
                                  String textString = "Email";
                                  if (textString == "Email") {
                                    return validateEmail(value);
                                  }
                                },
                                onSaved: (value) {
                                  String textString = "Email";
                                  if (textString == "Email") {
                                    email = value;
                                  }
                                },
                              ),
                              MyDivider(
                                dividerColor: Colors.white,
                                dividerHeight: 0,
                              ),
                              MyTextLabel(
                                textString: "Parola",
                                secBool: true,
                                textIcon: Icon(
                                  Icons.miscellaneous_services_rounded,
                                  color: Colors.green[900],
                                ),
                                validatorText: (String value) {
                                  String textString = "Parola";
                                  if (textString == "Parola") {
                                    return validatePassword(value);
                                  }
                                },
                                onSaved: (value) {
                                  String textString = "Parola";
                                  if (textString == "Parola") {
                                    password = value;
                                  }
                                },
                              ),
                              MyDivider(
                                dividerColor: Colors.white,
                                dividerHeight: 0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  MaterialButton(
                                    padding: EdgeInsets.fromLTRB(50, 0, 0, 0),
                                    child: Text(
                                      "Kayıt Ol",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 17),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => RegisterPage(),
                                        ),
                                      );
                                    },
                                  ),
                                  MaterialButton(
                                    padding: EdgeInsets.fromLTRB(0, 0, 45, 0),
                                    child: Text(
                                      "Şifremi Unuttum ?",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => NewPassword(),
                                        ),
                                      );
                                    },
                                  )
                                ],
                              ),
                              MyButton(
                                butonColor: Color(0xFFFFFFFF),
                                textColor: Colors.black87,
                                butonText: "Giriş Yap",
                                onPressed: () {
                                  loginOl();
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> loginOl() async {
    if (formKey1.currentState.validate()) {
      formKey1.currentState.save();
      setState(() {
        _loadingState = true;
      });

      fbSignIn.signInMember(email, password,
          /* Başarılı giriş yaptığında */ () {
        setState(() {
          _loadingState = false;
        });
        Fluttertoast.showToast(msg: "Giriş Başarılı");
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => BottomBridge(),
            ),
            (Route<dynamic> route) => false);
      }, /* Hatalı giriş yaptığında */ () {
        setState(() {
          _loadingState = true;
        });
        Fluttertoast.showToast(msg: "HATALI GİRİŞ");
      });
    }
  }
}
