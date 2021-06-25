import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gezdostumblog/screens/blog_page.dart';
import 'package:gezdostumblog/screens/login_page.dart';
import 'package:gezdostumblog/navigation/sideMenu/side_menu.dart';
import 'package:gezdostumblog/views/grafik.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {
  @override
  bool showAvg = false;

  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Anasayfa"),
        backgroundColor: Colors.green[900],
        centerTitle: true,
        actions: <Widget>[
          Row(
            children: [
              Text(
                'Çıkış',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: IconButton(
                  alignment: Alignment.centerLeft,
                  icon: Icon(
                    Icons.exit_to_app,
                    size: 30,
                  ),
                  onPressed: () {
                    FirebaseAuth.instance.signOut().then((user) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (_) => LoginPage(),
                          ),
                          (Route<dynamic> route) => false);
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      drawer: SideMenu(),
      body: SingleChildScrollView(
        child: Container(
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Gezginler Topluluğuna\n        HOŞ GELDİN",
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(
                  height: 15,
                ),
                LineChartSample2(),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "  Yeni paylaşlımları kaçırmamak \n          için gönderileri takip et...",
                  style: TextStyle(fontSize: 23),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onDoubleTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlogPage(),
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
                              "     Gezgin Paylaşımları...",
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
        ),
      ),
    ));
  }
}
