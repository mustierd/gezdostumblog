import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gezdostumblog/database/db_helper.dart';
import 'package:gezdostumblog/database/firebase_storage.dart';
import 'package:gezdostumblog/database/firebase_store.dart';
import 'package:gezdostumblog/models/equipment_post_model.dart';
import 'package:gezdostumblog/models/members.dart';
import 'package:image_picker/image_picker.dart';

class EquipmentAdd extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _EquipmentAdd();
  }
}

class _EquipmentAdd extends State<EquipmentAdd> {
  var dbHelper = DbHelper();
  final _selectedImage = ImagePicker();
  File imagePath;
  bool _loadingState = false;
  Members getMemberInfo = Members.withZero();
  FireBaseStore fbStore = FireBaseStore();
  FirebaseAuth auth = FirebaseAuth.instance;

  FireBaseStorage fbStorage = FireBaseStorage();
  var textProduct = TextEditingController();

  var textTitle = TextEditingController();
  var textBody = TextEditingController();

  void initState() {
    fbStore.getUserInfo(getMemberInfo);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yeni Ürün Ekle"),
        backgroundColor: Colors.green[900],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: Column(
            children: [
              buildGalleryImage(),
              buildNameProduct(),
              buildNameTitle(),
              buildNameBody(),
              SizedBox(height: 10),
              buildSaveButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNameProduct() {
    return TextField(
      decoration: InputDecoration(labelText: "Ürün Adı"),
      controller: textProduct,
    );
  }

  Widget buildNameTitle() {
    return TextField(
      decoration: InputDecoration(labelText: "Gönderi Başlığı"),
      controller: textTitle,
    );
  }

  Widget buildNameBody() {
    return TextField(
      decoration: InputDecoration(labelText: "Gönderi Açıklaması"),
      controller: textBody,
    );
  }

  Widget buildGalleryImage() {
    return GestureDetector(
      onTap: () {
        openGallery();
      },
      child: imagePath != null
          ? Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(
                horizontal: 18,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            )
          : Container(
              margin: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              height: 170,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.add_a_photo,
                color: Colors.black,
              ),
            ),
    );
  }

  buildSaveButton() {
    return ElevatedButton(
      child: Text("Ekle"),
      onPressed: () {
        addEquipment();
      },
      style: ElevatedButton.styleFrom(
        primary: Colors.green[900],
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  void addEquipment() async {
    String imageUrl = await fbStorage.imageUrlAdd(
        imagePath, auth.currentUser.email, "sqliteItemImage", 5);
    if (imageUrl == null) {
      imageUrl =
          "https://www.pehlivanemlak.com.tr/images/Emlak/Buyuk/resim-yok.jpg";
    }

    var result = await dbHelper.insert(EquipmentPostModel(
        product: textTitle.text,
        userName: getMemberInfo.getUserName,
        title: textTitle.text,
        body: textBody.text,
        email: auth.currentUser.email,
        image: imageUrl));

    Navigator.pop(context, true);
  }

  Future openGallery() async {
    final secilenDosya =
        await _selectedImage.getImage(source: ImageSource.gallery);

    setState(() {
      imagePath = File(secilenDosya.path);
    });
  }
}
