import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myblogapp/app/tab_items.dart';
import 'package:myblogapp/theme/color.dart';

class MyCustomBottomNavigation extends StatelessWidget {
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectedTab;
  final Map<TabItem, Widget> sayfaOlusturucu;
  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys;

  const MyCustomBottomNavigation({
    Key? key,
    required this.currentTab,
    required this.onSelectedTab,
    required this.sayfaOlusturucu,
    required this.navigatorKeys,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          backgroundColor: grey2,
          activeColor: black,
          inactiveColor: Colors.black87,
          items: [
            _navItemOlustur(TabItem.AnaSayfa),
            _navItemOlustur(TabItem.OneCikanlar),
            _navItemOlustur(TabItem.MyBlogPage),
            _navItemOlustur(TabItem.Profil),
          ],
          onTap: (index) => onSelectedTab(
            TabItem.values[index],
          ),
        ),
        tabBuilder: (context, index) {
          final gosterilecekItem = TabItem.values[index];
          return CupertinoTabView(
            navigatorKey: navigatorKeys[gosterilecekItem],
            builder: (context) {
              return Center(
                child: sayfaOlusturucu[gosterilecekItem],
              );
            },
          );
        },
      ),
    );
  }

  BottomNavigationBarItem _navItemOlustur(TabItem tabItem) {
    final olusturulacakTab = TabItemData.tumTablar[tabItem];
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        olusturulacakTab!.icon,
        height: 23,
        color: Colors.black,
      ),
      label: olusturulacakTab.title.toString(),
    );
  }
}
