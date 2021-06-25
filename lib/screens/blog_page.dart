import 'package:flutter/material.dart';
import 'package:gezdostumblog/screens/blog-add_page.dart';
import 'package:gezdostumblog/navigation/sideMenu/side_menu.dart';
import 'package:gezdostumblog/screens/post_view_selected.dart';

class BlogPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BlogPage();
  }
}

class _BlogPage extends State<BlogPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: SideMenu(),
        body: PostsViewSelected(
          blogTitle: "Gezgin Blog",
          keyMap: " ",
          valueMap: " ",
          choose: true,
          profilChoose: true,
        ),
        floatingActionButton: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(31, 0, 0, 0),
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlogAdd(),
                      ),
                    );
                  },
                  child: Icon(Icons.add),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
