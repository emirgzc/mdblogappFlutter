// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myblogapp/model/blog.dart';
import 'package:myblogapp/model/writers.dart';
import 'package:myblogapp/pages/author_page.dart';
import 'package:myblogapp/pages/detail_page.dart';
import 'package:myblogapp/theme/color.dart';

class OneCikanlar extends StatefulWidget {
  const OneCikanlar({Key? key}) : super(key: key);

  @override
  State<OneCikanlar> createState() => _OneCikanlarState();
}

class _OneCikanlarState extends State<OneCikanlar> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: SizedBox(
              height: 50,
              width: double.infinity,
              child: TextFormField(
                cursorColor: grey,
                decoration: InputDecoration(
                  labelText: "Search...",
                  hintText: "Search...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
          ),
          Row(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  "Popular Blogs",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              height: 170,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  popularBlogs.length,
                  (index) => Padding(
                    padding: EdgeInsets.only(
                      left: 20,
                      right: popularBlogs.length - 1 == index ? 30 : 0,
                    ),
                    child: Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context, rootNavigator: true).push(
                              MaterialPageRoute(
                                fullscreenDialog: true,
                                builder: (context) => Detailpage(
                                  blog: popularBlogs[index],
                                  likeCount: popularBlogs[index].blogLikes,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(7),
                              image: DecorationImage(
                                image: AssetImage(
                                  popularBlogs[index].blogImageUrl,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 7,
                          left: 7,
                          child: Text(
                            popularBlogs[index].blogDate,
                            style: TextStyle(
                              color: white.withOpacity(0.7),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 15,
                          left: 7,
                          child: Text(
                            popularBlogs[index].blogTitle,
                            style: TextStyle(
                              color: white.withOpacity(0.7),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Row(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  "Writers",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  allWriters.length,
                  (index) => Padding(
                    padding: EdgeInsets.only(
                      left: 20,
                      right: allWriters.length - 1 == index ? 30 : 0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context, rootNavigator: true).push(
                              MaterialPageRoute(
                                fullscreenDialog: true,
                                builder: (context) => AuthorPage(
                                  writers: allWriters[index],
                                ),
                              ),
                            );
                          },
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  allWriters[index].image,
                                ),
                                fit: BoxFit.cover,
                              ),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: grey.withOpacity(0.5),
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          allWriters[index].name +
                              " " +
                              allWriters[index].surname,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 7),
          Row(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  "Son Bloglar",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: List.generate(
              lastBlogs.length,
              (index) => Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  top: (index == 0) ? 10 : 15,
                  bottom: lastBlogs.length - 1 == index ? 30 : 0,
                ),
                child: Row(
                  children: [
                    Flexible(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context, rootNavigator: true).push(
                                MaterialPageRoute(
                                  fullscreenDialog: true,
                                  builder: (context) => Detailpage(
                                    blog: lastBlogs[index],
                                    likeCount: lastBlogs[index].blogLikes,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              height: 120,
                              width: size.width / 2.5,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  image: AssetImage(
                                    lastBlogs[index].blogImageUrl,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 20),
                    Flexible(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(lastBlogs[index].blogTitle),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(lastBlogs[index].blogDate),
                                    SizedBox(height: 5),
                                    Text(
                                      lastBlogs[index].blogWriter.name +
                                          " " +
                                          lastBlogs[index].blogWriter.surname,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset(
                          lastBlogs[index].isSelect == true
                              ? "assets/icons/bookmark.svg"
                              : "assets/icons/bookmark_fill.svg",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
