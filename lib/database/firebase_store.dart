import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gezdostumblog/database/firebase_storage.dart';
import 'package:gezdostumblog/models/members.dart';
import 'package:gezdostumblog/models/post_model.dart';
import 'package:random_string/random_string.dart';

class FireBaseStore {
  FirebaseAuth auth = FirebaseAuth.instance;
  FireBaseStorage fbStorage = FireBaseStorage();

  Future<void> setUserInfo(Members user) async {
    await FirebaseFirestore.instance
        .collection("kullanicilar")
        .doc(user.getEmail)
        .set({
      'kullaniciAdi': user.getUserName,
      'kullaniciSifre': user.getPassword,
      'kullaniciEposta': user.getEmail,
      'sehir': user.getCity,
    });
  }

  Future<Members> getUserInfo(Members user) async {
    await FirebaseFirestore.instance
        .collection('kullanicilar')
        .doc(auth.currentUser.email)
        .get()
        .then((data) async {
      user.setUserName = await data.data()['kullaniciAdi'];
      user.setEmail = await data.data()['kullaniciEposta'];
      user.setPassword = await data.data()['kullaniciSifre'];
      user.setCity = await data.data()['sehir'];
    });
    return user;
  }

  Future<void> updateUserInfo(Members user) async {
    await FirebaseFirestore.instance
        .collection("kullanicilar")
        .doc(user.getEmail)
        .update({
      'kullaniciAdi': user.getUserName,
      'kullaniciSifre': user.getPassword,
      'kullaniciEposta': user.getEmail,
      'sehir': user.getCity,
    });
  }

  Future<void> setPostInfo(
      String userName,
      PostModels postModel,
      String imageUrl,
      VoidCallback successful,
      VoidCallback unSuccessful) async {
    Map<String, String> multiBlogAddData = {
      "kullaniciEmail": auth.currentUser.email,
      "gezgin": userName,
      "baslik": postModel.baslik,
      "yer": postModel.yer,
      "bolge": postModel.bolge,
      "metin": postModel.metinAlani,
      "imageUrl": imageUrl,
      "profilPhotoUrl": await fbStorage.getProfilPhoto()
    };

    await FirebaseFirestore.instance
        .collection("Blogs")
        .doc(postModel.baslik + "_" + randomAlphaNumeric(3))
        .set(multiBlogAddData)
        .then((value) {
      successful();
    }).catchError((onError) {
      unSuccessful();
    });
  }

  /*Future<void> updatePostNameAndMail(
      PostModels postModels, Members oldUserInfo) async {
     FirebaseFirestore.instance
        .collection('Blogs')
        .where("KullaniciEmail", isEqualTo: oldUserInfo.getEmail). 
  }*/
}
