import 'package:flutter/material.dart';
import 'package:gezdostumblog/navigation/buttomMenu/tab_items.dart';
import 'package:gezdostumblog/screens/blog-add_page.dart';

import 'buttom_menu.dart';
import '../../screens/home_page.dart';

class BottomBridge extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BottomBridge();
  }
}

class _BottomBridge extends State<BottomBridge> {
  TabItem _currentTab = TabItem.Anasayfa;

  Map<TabItem, Widget> tumSayfalar() {
    return {
      TabItem.Anasayfa: HomePage(),
      TabItem.Paylas: BlogAdd(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ButtomMenu(
        currentTab: _currentTab,
        onSelectedTab: (secilenTab) {
          setState(() {
            _currentTab = secilenTab;
          });
          print("Seçilen tab item:" + secilenTab.toString());
        },
        sayfaOlusturucu: tumSayfalar(),
      ),
    );
  }
}
