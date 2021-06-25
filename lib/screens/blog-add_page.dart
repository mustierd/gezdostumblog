import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gezdostumblog/database/firebase_storage.dart';
import 'package:gezdostumblog/database/firebase_store.dart';
import 'package:gezdostumblog/models/members.dart';
import 'package:gezdostumblog/models/post_model.dart';
import 'package:gezdostumblog/screens/blog_page.dart';
import 'package:gezdostumblog/screens/home_page.dart';
import 'package:image_picker/image_picker.dart';

class BlogAdd extends StatefulWidget {
  @override
  _BlogAdd createState() => _BlogAdd();
}

class _BlogAdd extends State<BlogAdd> {
  FirebaseAuth auth = FirebaseAuth.instance;
  PostModels postModel = PostModels();
  FireBaseStorage fbStorage = FireBaseStorage();
  FireBaseStore fbStore = FireBaseStore();
  Members member = Members.withZero();

  final _selectedImage = ImagePicker();
  bool _loadingState = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.keyboard_backspace_sharp),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            },
          ),
          title: Text("Gönderi Paylaş"),
          backgroundColor: Colors.green[900],
          centerTitle: true,
          actions: <Widget>[
            GestureDetector(
              onTap: () {
                blogAdd();
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: Icon(
                  Icons.file_upload,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
        body: _loadingState
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          openGallery();
                        },
                        child: postModel.image != null
                            ? Container(
                                height: 200,
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.symmetric(
                                  horizontal: 18,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    postModel.image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            : Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 18, vertical: 10),
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
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 12,
                            ),
                            TextField(
                              decoration: InputDecoration(
                                hintText: "Başlık Yazın",
                                labelText: "Başlık",
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (value) {
                                postModel.baslik = value;
                              },
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            TextField(
                              decoration: InputDecoration(
                                hintText: "Yer Nerede ?",
                                labelText: "Yer",
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (value) {
                                postModel.yer = value;
                              },
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    "Hangi Bölge ? :   ",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  DropdownButton(
                                    value: postModel.bolge,
                                    onChanged: (String newValue) {
                                      setState(() {
                                        postModel.bolge = newValue;
                                      });
                                    },
                                    items: [
                                      'Akdeniz',
                                      'Karadeniz',
                                      'Ege',
                                      'Marmara',
                                      'iç Anadolu',
                                      'Doğu Anadolu',
                                      'Güney Doğu '
                                    ].map((String value) {
                                      return DropdownMenuItem(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                            TextField(
                              decoration: InputDecoration(
                                hintText: "Açıklama giriniz",
                                labelText: "Metin",
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (value) {
                                postModel.metinAlani = value;
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Future openGallery() async {
    final secilenDosya =
        await _selectedImage.getImage(source: ImageSource.gallery);

    setState(() {
      postModel.image = File(secilenDosya.path);
    });
  }

  Future<void> blogAdd() async {
    if (postModel.image != null) {
      setState(() {
        _loadingState = true;
      });

      fbStore.getUserInfo(member);
      String imageUrl = await fbStorage.imageUrlAdd(
          postModel.image, auth.currentUser.email, "blogResimleri", 9);

      await fbStore.setPostInfo(member.getUserName, postModel, imageUrl,
          () /* Başarılı kayıt ettiğinde*/ {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => BlogPage(),
            ),
            (Route<dynamic> route) => false);
      }, () /* Hata aldığında */ {
        Fluttertoast.showToast(msg: "Hata: Hay aksiii....Bir hata olustu :D ");
      });
    } else {
      Fluttertoast.showToast(msg: "Resim Seçin!!");
    }
  }
}
