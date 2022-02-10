// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, unused_local_variable

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myblogapp/pages/add_blog_page.dart';
import 'package:myblogapp/pages/home_page.dart';
import 'package:myblogapp/pages/my_blog._page.dart';
import 'package:myblogapp/pages/one_cikanlar.dart';
import 'package:myblogapp/pages/profil_page.dart';
import 'package:myblogapp/theme/color.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  bool isNotify = true;
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar(),
      body: IndexedStack(
        index: selectedIndex,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          HomePage(),
          OneCikanlar(),
          MyBlogPage(),
          ProfilPage(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: getFloatingActionButton(),
      bottomNavigationBar: builBottomBar(size),
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
          splashRadius: 24,
          onPressed: () {},
          icon: SvgPicture.asset("assets/icons/search.svg"),
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

  ZoomIn getFloatingActionButton() {
    return ZoomIn(
      duration: Duration(milliseconds: 100),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddBlogPage(),
            ),
          );
        },
        child: Container(
          height: 45,
          width: 45,
          decoration: BoxDecoration(
            color: Colors.grey.shade400,
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.add,
              color: black,
            ),
          ),
        ),
      ),
    );
  }
}
