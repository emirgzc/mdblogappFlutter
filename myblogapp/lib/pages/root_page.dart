// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, unused_local_variable, prefer_final_fields, unused_field

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myblogapp/app/my_custom_bottom_nav.dart';
import 'package:myblogapp/app/tab_items.dart';
import 'package:myblogapp/model/user.dart';
import 'package:myblogapp/pages/add_blog_page.dart';
import 'package:myblogapp/pages/home_page.dart';
import 'package:myblogapp/pages/my_blog._page.dart';
import 'package:myblogapp/pages/one_cikanlar.dart';
import 'package:myblogapp/pages/profil_page.dart';
import 'package:myblogapp/theme/color.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key? key, required this.user}) : super(key: key);
  final MyUser? user;

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  TabItem _currentTab = TabItem.AnaSayfa;

  Map<TabItem, Widget> tumSayfalar() {
    return {
      TabItem.AnaSayfa: HomePage(),
      TabItem.OneCikanlar: OneCikanlar(),
      TabItem.MyBlogPage: MyBlogPage(),
      TabItem.Profil: ProfilPage(),
    };
  }

  Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.AnaSayfa: GlobalKey<NavigatorState>(),
    TabItem.OneCikanlar: GlobalKey<NavigatorState>(),
    TabItem.MyBlogPage: GlobalKey<NavigatorState>(),
    TabItem.Profil: GlobalKey<NavigatorState>(),
  };
  bool isNotify = true;
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar(),
      body: WillPopScope(
        onWillPop: () async =>
            !await navigatorKeys[_currentTab]!.currentState!.maybePop(),
        child: MyCustomBottomNavigation(
          sayfaOlusturucu: tumSayfalar(),
          navigatorKeys: navigatorKeys,
          currentTab: _currentTab,
          onSelectedTab: (secilenTab) {
            if (secilenTab == _currentTab) {
              navigatorKeys[secilenTab]!.currentState!.popUntil(
                    (route) => route.isFirst,
                  ); // ilk sayfaya kadar geri gelir
              debugPrint(
                "seçilen tab item: " +
                    secilenTab.toString() +
                    " " +
                    _currentTab.toString(),
              );
            } else {
              setState(() {
                _currentTab = secilenTab;
              });
              debugPrint(
                "seçilen tab item: " + secilenTab.toString(),
              );
            }
          },
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      leading: IconButton(
        splashRadius: 24,
        onPressed: () {},
        icon: SvgPicture.asset("assets/icons/menu.svg"),
      ),
      title: Text(
        "MD Blog App",
        style: TextStyle(
          color: black,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).push(
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: (context) => AddBlogPage(),
              ),
            );
          },
          icon: Icon(
            Icons.add,
            color: black,
            size: 28,
          ),
          splashRadius: 24,
        ),
        IconButton(
          splashRadius: 24,
          onPressed: () {},
          icon: SvgPicture.asset(
            "assets/icons/search.svg",
          ),
        ),
        SizedBox(width: 5),
      ],
    );
  }

  Container builBottomBar(Size size) {
    return Container(
      height: 55,
      width: size.width,
      child: BottomAppBar(
        elevation: 0,
        shape: CircularNotchedRectangle(),
        notchMargin: 5,
        child: Row(
          children: [
            Container(
              width: size.width / 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        selectedIndex = 0;
                      });
                    },
                    icon: selectedIndex == 0
                        ? ElasticIn(
                            child: SvgPicture.asset(
                              "assets/icons/home_active.svg",
                              height: 22,
                            ),
                          )
                        : SvgPicture.asset(
                            "assets/icons/home_inactive.svg",
                            height: 22,
                          ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        selectedIndex = 1;
                      });
                    },
                    icon: selectedIndex == 1
                        ? ElasticIn(
                            child: SvgPicture.asset(
                              "assets/icons/search_active.svg",
                              height: 30,
                            ),
                          )
                        : SvgPicture.asset(
                            "assets/icons/search_inactive.svg",
                            height: 30,
                          ),
                  ),
                ],
              ),
            ),
            Container(
              width: size.width / 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        selectedIndex = 2;
                      });
                    },
                    icon: selectedIndex == 2
                        ? ElasticIn(
                            child: SvgPicture.asset(
                              "assets/icons/heart_active.svg",
                              height: 22,
                            ),
                          )
                        : SvgPicture.asset(
                            "assets/icons/heart_inactive.svg",
                            height: 22,
                          ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        selectedIndex = 3;
                      });
                    },
                    icon: selectedIndex == 3
                        ? ElasticIn(
                            child: SvgPicture.asset(
                              "assets/icons/user_active.svg",
                              height: 22,
                            ),
                          )
                        : SvgPicture.asset(
                            "assets/icons/user_inactive.svg",
                            height: 22,
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
