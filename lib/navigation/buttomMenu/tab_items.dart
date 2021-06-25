import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum TabItem { Anasayfa, Paylas }

class TabItemData {
  final String title;
  final IconData icon;

  TabItemData(this.title, this.icon);

  static Map<TabItem, TabItemData> tumtablar = {
    TabItem.Anasayfa: TabItemData("Anasayfa", Icons.home),
    TabItem.Paylas: TabItemData("Paylaş", Icons.edit_location_sharp)
  };
}
