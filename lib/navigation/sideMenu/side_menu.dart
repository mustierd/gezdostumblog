import 'package:flutter/material.dart';
import 'package:gezdostumblog/screens/contact.dart';
import 'package:gezdostumblog/screens/home_page.dart';
import 'package:gezdostumblog/screens/post_view_selected.dart';
import 'package:gezdostumblog/screens/blog_page.dart';
import 'package:gezdostumblog/screens/equipment_advice_page.dart';
import 'package:gezdostumblog/screens/equipment-list_page.dart';
import 'package:gezdostumblog/screens/profil_edit_page.dart';
import 'package:gezdostumblog/screens/profil_page.dart';
import 'package:gezdostumblog/widgets/insert_image.dart';
import 'package:gezdostumblog/widgets/my_divider.dart';

class SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(right: 150.0),
        child: Drawer(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                },
                child: Container(
                  color: Colors.grey[350],
                  padding:
                      EdgeInsets.only(right: 42, left: 42, bottom: 10, top: 10),
                  child: InsertImage(
                    imageHeight: 120,
                    imageWidth: 160,
                    imageLink: "assets/gezdostumlogo.png",
                  ),
                ),
              ),
              MyDivider(
                dividerColor: Colors.green[900],
                dividerHeight: 1,
                dividerThickness: 5,
              ),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(
                        Icons.person,
                        color: Colors.green[900],
                      ),
                      title: Text(
                        "PROFİL",
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfilPage(),
                          ),
                        );
                      },
                    ),
                    MyDivider(
                      dividerColor: Colors.black,
                      dividerHeight: 1,
                      dividerThickness: 1,
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.follow_the_signs,
                        color: Colors.green[900],
                      ),
                      title: Text("GEZGİN BLOG"),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlogPage(),
                          ),
                        );
                      },
                    ),
                    MyDivider(
                      dividerColor: Colors.black,
                      dividerHeight: 1,
                      dividerThickness: 1,
                    ),
                    ExpansionTile(
                      leading: Icon(
                        Icons.style_sharp,
                        color: Colors.green[900],
                      ),
                      title: Text('KAMP EKİPMANLARI'),
                      children: camp2(context),
                    ),
                    MyDivider(
                      dividerColor: Colors.black,
                      dividerHeight: 1,
                      dividerThickness: 1,
                    ),
                    ExpansionTile(
                      leading: Icon(
                        Icons.map_outlined,
                        color: Colors.green[900],
                      ),
                      title: Text('BÖLGELER'),
                      children: maps7(context),
                    ),
                    MyDivider(
                      dividerColor: Colors.black,
                      dividerHeight: 1,
                      dividerThickness: 1,
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.message_outlined,
                        color: Colors.green[900],
                      ),
                      title: Text("İLETİŞM"),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Contact(),
                          ),
                        );
                      },
                    ),
                    MyDivider(
                      dividerColor: Colors.black,
                      dividerHeight: 1,
                      dividerThickness: 1,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> camp2(BuildContext context) {
    return <Widget>[
      Container(
        margin: EdgeInsets.only(left: 55),
        child: ListTile(
          title: Text('Ekipman Tavsiyeleri'),
          onTap: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => EquipmentAdvicePage(),
                ),
                (Route<dynamic> route) => false);
          },
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 55),
        child: ListTile(
          title: Text('Ekipmanlar'),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EquipmentList(),
                ));
          },
        ),
      ),
    ];
  }

  List<Widget> maps7(BuildContext context) {
    return <Widget>[
      Container(
        margin: EdgeInsets.only(left: 55),
        child: ListTile(
          title: Text('Akdeniz Bölgesi'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PostsViewSelected(
                  blogTitle: "Akdeniz Bölgesi",
                  keyMap: "bolge",
                  valueMap: "Akdeniz",
                  choose: false,
                  profilChoose: true,
                ),
              ),
            );
          },
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 55),
        child: ListTile(
          title: Text('Karadeniz  Bölgesi'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PostsViewSelected(
                  blogTitle: "Karadeniz  Bölgesi",
                  keyMap: "bolge",
                  valueMap: "Karadeniz",
                  choose: false,
                  profilChoose: true,
                ),
              ),
            );
          },
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 55),
        child: ListTile(
          title: Text('Ege Bölgesi'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PostsViewSelected(
                  blogTitle: "Ege Bölgesi",
                  keyMap: "bolge",
                  valueMap: "Ege",
                  choose: false,
                  profilChoose: true,
                ),
              ),
            );
          },
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 55),
        child: ListTile(
          title: Text('Marmara Bölgesi'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PostsViewSelected(
                  blogTitle: "Marmara Bölgesi",
                  keyMap: "bolge",
                  valueMap: "Marmara",
                  choose: false,
                  profilChoose: true,
                ),
              ),
            );
          },
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 55),
        child: ListTile(
          title: Text('İç Anadolu Bölgesi'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PostsViewSelected(
                  blogTitle: "İç Anadolu Bölgesi",
                  keyMap: "bolge",
                  valueMap: "iç Anadolu",
                  choose: false,
                  profilChoose: true,
                ),
              ),
            );
          },
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 55),
        child: ListTile(
          title: Text('Güney D. Bölgesi'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PostsViewSelected(
                  blogTitle: "Doğu Bölgesi",
                  keyMap: "bolge",
                  valueMap: "Güney Doğu",
                  choose: false,
                  profilChoose: true,
                ),
              ),
            );
          },
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 55),
        child: ListTile(
          title: Text('Doğu A. Bölgesi'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PostsViewSelected(
                  blogTitle: "Doğu A. Bölgesi",
                  keyMap: "bolge",
                  valueMap: "Doğu Anadolu",
                  choose: false,
                  profilChoose: true,
                ),
              ),
            );
          },
        ),
      ),
    ];
  }
}
