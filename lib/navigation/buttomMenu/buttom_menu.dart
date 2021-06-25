import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gezdostumblog/navigation/buttomMenu/tab_items.dart';

class ButtomMenu extends StatelessWidget {
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectedTab;
  final Map<TabItem, Widget> sayfaOlusturucu;

  const ButtomMenu(
      {Key key,
      @required this.currentTab,
      @required this.onSelectedTab,
      @required this.sayfaOlusturucu})
      : super(key: key);

  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: Colors.grey[350],
        items: [
          _navItemOlustur(TabItem.Anasayfa),
          _navItemOlustur(TabItem.Paylas),
        ],
        onTap: (index) => onSelectedTab(TabItem.values[index]),
      ),
      tabBuilder: (context, index) {
        final gosterilecekItem = TabItem.values[index];
        return CupertinoTabView(
          builder: (context) {
            return sayfaOlusturucu[gosterilecekItem];
          },
        );
      },
    );
  }
}

BottomNavigationBarItem _navItemOlustur(TabItem tabItem) {
  final olusturulacakTab = TabItemData.tumtablar[tabItem];
  return BottomNavigationBarItem(
    icon: Icon(
      olusturulacakTab.icon,
      size: 28,
      color: Colors.green[900],
    ),
    title: Text(
      olusturulacakTab.title,
      style: TextStyle(
        fontSize: 18,
        color: Colors.green[900],
      ),
    ),
  );
}
