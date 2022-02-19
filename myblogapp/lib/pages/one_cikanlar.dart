// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myblogapp/model/blog.dart';
import 'package:myblogapp/model/user.dart';
import 'package:myblogapp/pages/all_popular_blog_page.dart';
import 'package:myblogapp/pages/all_writers_page.dart';
import 'package:myblogapp/pages/author_page.dart';
import 'package:myblogapp/pages/detail_page.dart';
import 'package:myblogapp/theme/color.dart';
import 'package:myblogapp/viewmodel/view_model.dart';
import 'package:provider/provider.dart';

class OneCikanlar extends StatefulWidget {
  const OneCikanlar({Key? key}) : super(key: key);

  @override
  State<OneCikanlar> createState() => _OneCikanlarState();
}

class _OneCikanlarState extends State<OneCikanlar> {
  @override
  Widget build(BuildContext context) {
    UserModel _userModel = Provider.of<UserModel>(context);
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Text(
                  "Popular Blogs",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (context) => AllPopularBlogs(),
                      ),
                    );
                  },
                  child: Text(
                    "See All",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: FutureBuilder<List<Blog>?>(
              future: _userModel.getAllBlogLike(),
              builder: (context, sonuc) {
                if (sonuc.hasData) {
                  var tumBloglar = sonuc.data;
                  return SizedBox(
                    height: 170,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ...List.generate(
                          tumBloglar!.length ~/ 2,
                          (index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                left: 20,
                                right: 5 - 1 == index ? 30 : 0,
                              ),
                              child: FutureBuilder<MyUser?>(
                                future: _userModel.getUserID(
                                  tumBloglar[index].writerID.toString(),
                                ),
                                builder: (context, sonuc) {
                                  var tekUser = sonuc.data;
                                  if (sonuc.hasData) {
                                    return Stack(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .push(
                                              MaterialPageRoute(
                                                fullscreenDialog: true,
                                                builder: (context) =>
                                                    Detailpage(
                                                  blog: tumBloglar[index],
                                                  likeCount: tumBloglar[index]
                                                      .blogLikes,
                                                  writers: tekUser,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            height: 150,
                                            width: 150,
                                            decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  tumBloglar[index]
                                                      .blogImageUrl
                                                      .toString(),
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 7,
                                          right: 7,
                                          child: Container(
                                            height: 17,
                                            width: 80,
                                            decoration: BoxDecoration(
                                              color: grey2.withOpacity(0.8),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Column(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    tumBloglar[index]
                                                            .blogLikes
                                                            .toString() +
                                                        " Likes",
                                                    style: TextStyle(
                                                      color: black,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  } else {
                                    return SizedBox();
                                  }
                                },
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Text(
                  "All Writers",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (context) => AllWriters(),
                      ),
                    );
                  },
                  child: Text(
                    "See All",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: FutureBuilder<List<MyUser>?>(
              future: _userModel.getAllUser(),
              builder: (context, sonuc) {
                if (sonuc.hasData) {
                  var tumUsers = sonuc.data;
                  if (tumUsers!.length - 1 > 0) {
                    return SizedBox(
                      height: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          tumUsers.length ~/ 2,
                          (index) {
                            var oankiUser = sonuc.data![index];
                            if (oankiUser.userID != _userModel.user!.userID) {
                              return Padding(
                                padding: EdgeInsets.only(
                                  left: 20,
                                  right: 5 == index ? 30 : 0,
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .push(
                                          MaterialPageRoute(
                                            fullscreenDialog: true,
                                            builder: (context) => AuthorPage(
                                              writers: tumUsers[index],
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              tumUsers[index]
                                                  .profilUrl
                                                  .toString(),
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
                                      tumUsers[index].nameSurname.toString(),
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
                      ),
                    );
                  } else {
                    return Center(
                      child: Text("Kayıtlı Kullanıcı Yok."),
                    );
                  }
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
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
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: FutureBuilder<List<Blog>?>(
              future: _userModel.getAllBlog(),
              builder: (context, sonuc) {
                if (sonuc.hasData) {
                  var tumBloglar = sonuc.data;
                  return Column(
                    children: [
                      ...List.generate(
                        5,
                        (index) => Padding(
                          padding: EdgeInsets.only(
                            left: 20,
                            top: (index == 0) ? 10 : 15,
                            bottom: tumBloglar!.length - 1 == index ? 30 : 0,
                          ),
                          child: Row(
                            children: [
                              Flexible(
                                flex: 3,
                                child: FutureBuilder<MyUser?>(
                                  future: _userModel.getUserID(
                                    tumBloglar[index].writerID.toString(),
                                  ),
                                  builder: (context, sonuc) {
                                    if (sonuc.hasData) {
                                      var tekUserrr = sonuc.data;
                                      return Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.of(context,
                                                      rootNavigator: true)
                                                  .push(
                                                MaterialPageRoute(
                                                  fullscreenDialog: true,
                                                  builder: (context) =>
                                                      Detailpage(
                                                    blog: tumBloglar[index],
                                                    likeCount: tumBloglar[index]
                                                        .blogLikes,
                                                    writers: tekUserrr,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              height: 120,
                                              width: size.width / 2.5,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                    tumBloglar[index]
                                                        .blogImageUrl
                                                        .toString(),
                                                  ),
                                                  fit: BoxFit.cover,
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color:
                                                        grey.withOpacity(0.5),
                                                    blurRadius: 10,
                                                    offset: Offset(5, 5),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    } else {
                                      return Container();
                                    }
                                  },
                                ),
                              ),
                              SizedBox(width: 20),
                              Flexible(
                                flex: 3,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      tumBloglar[index].blogTitle.toString(),
                                    ),
                                    SizedBox(height: 5),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          tumBloglar[index]
                                              .blogDate!
                                              .toDate()
                                              .toString()
                                              .substring(0, 16),
                                        ),
                                        SizedBox(height: 5),
                                        /*Text(
                                          tumBloglar[index]
                                                  .blogWriter
                                                  .name +
                                              " " +
                                              tumBloglar[index]
                                                  .blogWriter
                                                  .surname,
                                        ),*/
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
                                    "assets/icons/bookmark_fill.svg",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
