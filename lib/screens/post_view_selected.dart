import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gezdostumblog/navigation/sideMenu/side_menu.dart';
import 'package:gezdostumblog/widgets/insert_blogClips.dart';
import 'package:gezdostumblog/widgets/insert_profilClips.dart';

class PostsViewSelected extends StatelessWidget {
  final String blogTitle;

  final String keyMap;
  final String valueMap;
  final bool choose;
  final bool profilChoose;

  const PostsViewSelected(
      {Key key,
      @required this.keyMap,
      @required this.valueMap,
      @required this.choose,
      @required this.blogTitle,
      @required this.profilChoose})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //choose=true =>  All post(_usersStreamTrue)
    final Stream<QuerySnapshot> _usersStreamTrue =
        FirebaseFirestore.instance.collection('Blogs').snapshots();

    //choose=false => Selected post(_usersStreamFalse)
    final Query _usersStreamFalse = FirebaseFirestore.instance
        .collection('Blogs')
        .where(keyMap, isEqualTo: valueMap);

    //toplam post sayısını buluyor
    String usersStreamFalseTotal;
    Future<String> getir() async {
      await _usersStreamFalse.get().then((value) {
        usersStreamFalseTotal = value.docs.length.toString();
      });
      return usersStreamFalseTotal;
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green[900],
        title: Text(blogTitle),
        actions: [
          IconButton(
            icon: Icon(Icons.push_pin_outlined),
            onPressed: () {},
          ),
        ],
      ),
      drawer: profilChoose != false ? SideMenu() : null,
      body: StreamBuilder<QuerySnapshot>(
        stream:
            choose == true ? _usersStreamTrue : _usersStreamFalse.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          return new ListView(
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;

              return Column(
                children: [
                  SizedBox(
                    height: 7,
                  ),
                  stackWidget(data, context),
                  SizedBox(
                    height: 7,
                  ),
                ],
              );
            }).toList(),
          );
        },
      ),
    );
  }

  Stack stackWidget(Map<String, dynamic> data, BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            data["imageUrl"],
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
        Column(
          children: [
            profilChoose != false
                ? Center(
                    child: InsertProfilClips(
                      profilPhoto: data["profilPhotoUrl"],
                      onTap: () {},
                    ),
                  )
                : Text(""),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  profilChoose != false
                      ? Text(
                          "Gezgin: " + data["gezgin"],
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                          ),
                        )
                      : Text(""),
                  Text(
                    "Yer:" + data["yer"],
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
