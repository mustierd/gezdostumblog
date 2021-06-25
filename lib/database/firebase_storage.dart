import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:random_string/random_string.dart';

class FireBaseStorage {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<String> imageUrlAdd(
      File postImage, String path, String email, int randomNumber) async {
    firebase_storage.Reference depolamaYolu = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child(path)
        .child(email)
        .child("$path${randomAlphaNumeric(randomNumber)}.jpg");

    firebase_storage.UploadTask uploadTask = depolamaYolu.putFile(postImage);
    var dowloandUrl = await (await uploadTask).ref.getDownloadURL();
    String imageUrl = dowloandUrl.toString();

    return imageUrl;
  }

  Future<String> getProfilPhoto() async {
    var profilPhotoUrl = await firebase_storage.FirebaseStorage.instance
        .ref()
        .child("profilResmi")
        .child(auth.currentUser.email)
        .child("profilResmi.jpg")
        .getDownloadURL();

    return profilPhotoUrl.toString();
  }
}
