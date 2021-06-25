import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gezdostumblog/database/firebase_storage.dart';
import 'package:gezdostumblog/database/firebase_store.dart';
import 'package:gezdostumblog/models/members.dart';
import 'package:gezdostumblog/screens/post_view_selected.dart';
import 'package:gezdostumblog/screens/profil_edit_page.dart';
import 'package:gezdostumblog/widgets/insert_profilClips.dart';

class ProfilPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfilPage();
  }
}

class _ProfilPage extends State<ProfilPage> {
  FireBaseStorage fbStorage = FireBaseStorage();
  Members getMemberInfo = Members.withZero();
  FireBaseStore fbStore = FireBaseStore();
  FirebaseAuth auth = FirebaseAuth.instance;

  String profilPhotoUrl;
  String profilPhoto;
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
    return SafeArea(
      child: Scaffold(
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
              icon: Icon(Icons.people_alt),
              onPressed: () {},
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(left: 15, top: 20, right: 15),
            child: Column(
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
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditProfilPage(),
                              ),
                            );
                          },
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
                              Icons.edit,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Column(
                    children: [
                      Text(
                        getMemberInfo.getUserName == null
                            ? "-----"
                            : getMemberInfo.getUserName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        auth.currentUser.email,
                        style: TextStyle(
                          color: Colors.grey[900],
                          fontSize: 19,
                        ),
                      ),
                      SizedBox(height: 7),
                      Container(
                        width: 100,
                        child: Row(
                          children: [
                            Icon(Icons.location_on),
                            Text(
                              getMemberInfo.getCity == null
                                  ? "-----"
                                  : getMemberInfo.getCity,
                              style: TextStyle(
                                color: Colors.grey[900],
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.green[900],
                        endIndent: 100,
                        indent: 100,
                        height: 20,
                        thickness: 2,
                      ),
                      Container(
                        child: Column(
                          children: [
                            Text(
                              " 30",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 23,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "      Tüm \n Gönderiler",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PostsViewSelected(
                                blogTitle: "Gönderilerim",
                                keyMap: "kullaniciEmail",
                                valueMap: auth.currentUser.email,
                                choose: false,
                                profilChoose: false,
                              ),
                            ),
                          );
                        },
                        child: Stack(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                "https://i0.hippopx.com/photos/591/544/913/tree-palms-palme-palm-tree-preview.jpg",
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width,
                                height: 200,
                              ),
                            ),
                            Container(
                              height: 200,
                              decoration: BoxDecoration(
                                color: Colors.black54.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(75),
                              child: Column(
                                children: [
                                  Text(
                                    "Tüm Gönderilerim",
                                    style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_sharp,
                                    size: 50,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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

  profilPhotoView() async {
    profilPhotoUrl = await fbStorage.getProfilPhoto();
    if (profilPhotoUrl != null) {
      setState(() {
        profilPhoto = profilPhotoUrl;
      });
    } else {
      profilPhotoUrl = null;
    }
  }
}
