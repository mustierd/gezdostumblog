import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gezdostumblog/widgets/insert_image.dart';
import 'package:gezdostumblog/widgets/my_back-ground-img.dart';
import 'package:gezdostumblog/widgets/my_divider.dart';

import '../widgets/my_button.dart';
import '../widgets/my_text.dart';

class NewPassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NewPassword();
  }
}

class _NewPassword extends State<NewPassword> {
  final formKey3 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: <Widget>[
          MyBackgroundImg(
            myImage: "assets/images/background/loginfoto2.jpg",
          ),
          Scaffold(
            appBar: AppBar(
              title: Text("Giriş Sayfası"),
              backgroundColor: Colors.green[900],
            ),
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Form(
                key: formKey3,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.fromLTRB(30, 0, 0, 20),
                        child: Row(
                          children: [
                            InsertImage(
                              imageHeight: 80,
                              imageWidth: 100,
                              imageLink: "assets/gezdostumlogo.png",
                            ),
                            Text(
                              'Şifremi Unuttum!',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Raleway',
                              ),
                            ),
                          ],
                        ),
                      ),
                      MyTextLabel(
                        textString: "Kullanıcı Adı",
                        secBool: false,
                        textIcon: Icon(
                          Icons.supervised_user_circle,
                          color: Colors.green[900],
                        ),
                        validatorText: (String value) {},
                        onSaved: (value) {},
                      ),
                      MyDivider(
                        dividerColor: Colors.white,
                        dividerHeight: 0,
                      ),
                      MyTextLabel(
                        textString: "Güvenlik Sorusu",
                        secBool: false,
                        textIcon: Icon(
                          Icons.screen_lock_portrait_outlined,
                          color: Colors.green[900],
                        ),
                        validatorText: (String value) {},
                        onSaved: (value) {},
                      ),
                      MyDivider(
                        dividerColor: Colors.white,
                        dividerHeight: 0,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      MyButton(
                        butonColor: Color(0xFFFFFFFF),
                        textColor: Colors.black87,
                        butonText: "Şifre Al",
                        onPressed: () {
                          FirebaseFirestore firestore =
                              FirebaseFirestore.instance;
                          CollectionReference testCollectionRef =
                              firestore.collection('testCollection');
                          testCollectionRef.add({'test': 'alexde'});
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
