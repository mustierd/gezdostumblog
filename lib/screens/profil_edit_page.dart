import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gezdostumblog/database/firebase_storage.dart';
import 'package:gezdostumblog/database/firebase_store.dart';
import 'package:gezdostumblog/models/members.dart';
import 'package:gezdostumblog/models/post_model.dart';
import 'package:gezdostumblog/widgets/insert_profilClips.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gezdostumblog/funcitons/validation_mixin.dart';

class EditProfilPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _EditProfilPage();
  }
}

class _EditProfilPage extends State<EditProfilPage> with ValidationMixin {
  final formKey4 = GlobalKey<FormState>();

  FireBaseStore fbStore = FireBaseStore();
  PostModels postModel = PostModels();
  FireBaseStorage fbStorage = FireBaseStorage();
  FirebaseAuth auth = FirebaseAuth.instance;

  Members editMember = Members.withZero();
  Members getMemberInfo = Members.withZero();

  String profilPhoto, profilPhotoUrl;

  final _selectedImage = ImagePicker();
  bool isObscurePassword = true;

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await fbStore.getUserInfo(getMemberInfo);
      profilPhotoView();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        title: Text('Profil Ayarları'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 15, top: 20, right: 15),
        child: GestureDetector(
          onTap: () {
            profilPhotoAdd();
          },
          child: ListView(
            children: [
              Center(
                child: Stack(
                  children: [
                    InsertProfilClips(
                      profilPhoto: profilPhoto,
                      onTap: () {},
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 4,
                            color: Colors.green[900],
                          ),
                          color: Colors.green[800],
                        ),
                        child: Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Form(
                  key: formKey4,
                  child: Column(
                    children: [
                      buildTextField(
                        "Kullanıcı Adı",
                        getMemberInfo.getUserName,
                        false,
                      ),
                      buildTextField(
                        "Parola",
                        "******",
                        true,
                      ),
                      buildTextField(
                        "Şehir",
                        getMemberInfo.getCity,
                        false,
                      ),
                    ],
                  )),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "İptal",
                        style: TextStyle(
                          fontSize: 15,
                          letterSpacing: 2,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey,
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey4.currentState.validate()) {
                          fbStore.updateUserInfo(editMember);
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        "Kayıt",
                        style: TextStyle(
                          fontSize: 15,
                          letterSpacing: 2,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green[900],
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> profilPhotoAdd() async {
    final secilenDosya =
        await _selectedImage.getImage(source: ImageSource.gallery);

    setState(() {
      postModel.image = File(secilenDosya.path);
    });
    if (postModel.image != null) {
      String url = await fbStorage.imageUrlAdd(
          postModel.image, auth.currentUser.email, "profilResmi", 0);
      setState(() {
        profilPhoto = url;
      });
    } else
      Fluttertoast.showToast(msg: "Resim Seçin!!");
  }

  profilPhotoView() async {
    profilPhotoUrl = await fbStorage.getProfilPhoto();
    if (profilPhotoUrl != null) {
      setState(() {
        profilPhoto = profilPhotoUrl;
      });
    }
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: Form(
        child: TextFormField(
          validator: (value) {
            if (labelText == "Kullanıcı Adı")
              return validateUserName(value);
            else if (labelText == "Parola")
              return validatePassword(value);
            else if (labelText == "Şehir")
              return validateCity(value);
            else
              return "Geçerli bilgi girişi yapınız...";
          },
          keyboardType: TextInputType.emailAddress,
          obscureText: isPasswordTextField ? isObscurePassword : false,
          decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
                    icon: Icon(Icons.remove_red_eye, color: Colors.grey),
                    onPressed: () {
                      setState(() {
                        isObscurePassword = !isObscurePassword;
                      });
                    })
                : null,
            contentPadding: EdgeInsets.only(bottom: 5),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          onChanged: (value) {
            if (labelText == "Kullanıcı Adı")
              editMember.setUserName = value;
            else if (labelText == "Parola")
              editMember.setPassword = value;
            else if (labelText == "Şehir") editMember.setCity = value;
            editMember.setEmail = getMemberInfo.getEmail;
          },
        ),
      ),
    );
  }
}
