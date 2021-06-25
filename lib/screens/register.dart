import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gezdostumblog/database/firebase_signin.dart';
import 'package:gezdostumblog/database/firebase_storage.dart';
import 'package:gezdostumblog/database/firebase_store.dart';
import 'package:gezdostumblog/screens/home_page.dart';
import 'package:gezdostumblog/widgets/insert_image.dart';
import 'package:gezdostumblog/widgets/my_back-ground-img.dart';
import 'package:gezdostumblog/widgets/my_divider.dart';
import 'package:gezdostumblog/funcitons/validation_mixin.dart';
import 'package:gezdostumblog/models/members.dart';
import 'package:gezdostumblog/widgets/my_button.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/my_text.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegisterPage();
  }
}

class _RegisterPage extends State<RegisterPage> with ValidationMixin {
  Members member = new Members.withZero();
  FireBaseStore fbStore = new FireBaseStore();
  FireBaseSignIn fbSignIn = FireBaseSignIn();
  FireBaseStorage fbStorage = FireBaseStorage();

  final formKey2 = GlobalKey<FormState>();
  bool _loadingState = false;
  final _selectedImage = ImagePicker();
  File imagePath;
  String profilPhoto = null, profilPhotoUrl;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: <Widget>[
          MyBackgroundImg(
            myImage: "assets/images/background/loginfoto.jpg",
          ),
          _loadingState
              ? Center(child: CircularProgressIndicator())
              : Scaffold(
                  appBar: AppBar(
                    title: Text("Giriş Sayfası"),
                    backgroundColor: Colors.green[900],
                  ),
                  backgroundColor:
                      Colors.transparent, // scaffoldun rengini saydam yapıyor.
                  body: newMethod(),
                )
        ],
      ),
    );
  }

  SingleChildScrollView newMethod() {
    return SingleChildScrollView(
      child: Form(
        key: formKey2,
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
                      'Aramıza Katıl',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Raleway',
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  profilPhotoAdd();
                },
                child: Container(
                  width: 85,
                  height: 85,
                  decoration: BoxDecoration(
                    border: Border.all(width: 4, color: Colors.white),
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: 2,
                        blurRadius: 10,
                        color: Colors.green[900].withOpacity(1),
                      ),
                    ],
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: profilPhoto == null
                            ? NetworkImage(
                                "https://im0-tub-tr.yandex.net/i?id=fda522c8eb8141b507f015f7cde37408&n=13")
                            : NetworkImage(profilPhoto)),
                  ),
                ),
              ),
              MyTextLabel(
                textString: "Kullanıcı Adı",
                secBool: false,
                textIcon: Icon(
                  Icons.supervised_user_circle,
                  color: Colors.green[900],
                ),
                validatorText: (String value) {
                  String textString = "Kullanıcı Adı";
                  if (textString == "Kullanıcı Adı") {
                    return validateUserName(value);
                  }
                },
                onSaved: (value) {
                  String textString = "Kullanıcı Adı";
                  if (textString == "Kullanıcı Adı") {
                    member.setUserName = value;
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
                    member.setPassword = value;
                  }
                },
              ),
              MyDivider(
                dividerColor: Colors.white,
                dividerHeight: 0,
              ),
              MyTextLabel(
                textString: "Email",
                secBool: false,
                textIcon: Icon(
                  Icons.email,
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
                    member.setEmail = value;
                  }
                },
              ),
              MyDivider(
                dividerColor: Colors.white,
                dividerHeight: 0,
              ),
              MyTextLabel(
                textString: "Şehir",
                secBool: false,
                textIcon: Icon(
                  Icons.location_city,
                  color: Colors.green[900],
                ),
                validatorText: (String value) {
                  String textString = "Şehir";
                  if (textString == "Şehir") {
                    return validateCity(value);
                  }
                },
                onSaved: (value) {
                  String textString = "Şehir";
                  if (textString == "Şehir") {
                    member.setCity = value;
                  }
                },
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
                butonText: "Kayıt Ol",
                onPressed: () {
                  registerAdd();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> registerAdd() async {
    if (formKey2.currentState.validate()) {
      formKey2.currentState.save();
      setState(() {
        _loadingState = true;
      });

      fbSignIn.createMember(member, /* Başarılı kayıt ettiğinde*/ () async {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
            (Route<dynamic> route) => false);
      }, /* Hata aldığında */ () {
        setState(() {
          _loadingState = true;
        });
        Fluttertoast.showToast(msg: "Hata: Hay aksi...Bir şeyler ters gitti.");
      });
    }
  }

  Future<void> profilPhotoAdd() async {
    final secilenDosya =
        await _selectedImage.getImage(source: ImageSource.gallery);

    setState(() {
      imagePath = File(secilenDosya.path);
    });
    if (imagePath != null) {
      String url = await fbStorage.imageUrlAdd(
          imagePath, member.getEmail, "profilResmi", 0);
      setState(() {
        profilPhoto = url;
      });
    } else
      Fluttertoast.showToast(msg: "Resim Seçin!!");
  }
}
