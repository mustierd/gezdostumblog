import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gezdostumblog/database/db_helper.dart';
import 'package:gezdostumblog/database/firebase_storage.dart';
import 'package:gezdostumblog/database/firebase_store.dart';
import 'package:gezdostumblog/models/equipment_post_model.dart';
import 'package:gezdostumblog/models/members.dart';
import 'package:image_picker/image_picker.dart';

enum Options { delete, update }

class EquipmentDetail extends StatefulWidget {
  EquipmentPostModel ekipman;
  EquipmentDetail(this.ekipman);
  @override
  _EquipmentDetailState createState() => _EquipmentDetailState(ekipman);
}

class _EquipmentDetailState extends State<EquipmentDetail> {
  EquipmentPostModel ekipman;
  _EquipmentDetailState(this.ekipman);
  var dbHelper = DbHelper();
  Members getMemberInfo = Members.withZero();
  FireBaseStore fbStore = FireBaseStore();
  FireBaseStorage fbStorage = FireBaseStorage();

  FirebaseAuth auth = FirebaseAuth.instance;
  var textProduct = TextEditingController();
  var textTitle = TextEditingController();
  var textBody = TextEditingController();

  final _selectedImage = ImagePicker();
  File imagePath;
  @override
  void initState() {
    fbStore.getUserInfo(getMemberInfo);

    textProduct.text = ekipman.product;
    textTitle.text = ekipman.title;
    textBody.text = ekipman.body;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ürün Detayı"),
        centerTitle: true,
        actions: <Widget>[
          PopupMenuButton<Options>(
            onSelected: selectProcess,
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Options>>[
              PopupMenuItem<Options>(
                value: Options.delete,
                child: Text("Sil"),
              ),
              PopupMenuItem<Options>(
                value: Options.update,
                child: Text("Güncelle"),
              ),
            ],
          ),
        ],
      ),
      body: buildEquipmentDetail(),
    );
  }

  buildSaveButton() {
    return ElevatedButton(
      child: Text("Ekle"),
      onPressed: () {
        openGallery();
      },
      style: ElevatedButton.styleFrom(
        primary: Colors.green[900],
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  Future openGallery() async {
    final secilenDosya =
        await _selectedImage.getImage(source: ImageSource.gallery);

    setState(() {
      imagePath = File(secilenDosya.path);
    });
  }

  buildEquipmentDetail() {
    return SingleChildScrollView(
      child: Card(
        child: Column(
          children: [
            Container(
              child: Image.network(
                ekipman.image,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            buildSaveButton(),
            buildNameProduct(),
            buildNameTitle(),
            buildNameBody(),
          ],
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

  void selectProcess(Options options) async {
    String imageUrl = await fbStorage.imageUrlAdd(
        imagePath, auth.currentUser.email, "sqliteItemImage", 5);
    if (imageUrl == null) {
      imageUrl =
          "https://www.pehlivanemlak.com.tr/images/Emlak/Buyuk/resim-yok.jpg";
    }
    switch (options) {
      case Options.delete:
        await dbHelper.delete(ekipman.id);
        Navigator.pop(context, true);
        break;
      case Options.update:
        await dbHelper.update(
          EquipmentPostModel.withId(
              id: ekipman.id,
              product: textProduct.text,
              userName: getMemberInfo.getUserName,
              title: textTitle.text,
              body: textBody.text,
              email: getMemberInfo.getEmail,
              image: imageUrl),
        );
        Navigator.pop(context, true);
        break;
    }
  }
}
