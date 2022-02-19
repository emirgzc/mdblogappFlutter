// ignore_for_file: prefer_const_constructors, unused_local_variable, prefer_is_empty

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myblogapp/model/blog.dart';
import 'package:myblogapp/pages/detail_page.dart';
import 'package:myblogapp/theme/color.dart';
import 'package:myblogapp/viewmodel/view_model.dart';
import 'package:provider/provider.dart';

class MyBlogPage extends StatefulWidget {
  const MyBlogPage({Key? key}) : super(key: key);

  @override
  State<MyBlogPage> createState() => _MyBlogPageState();
}

class _MyBlogPageState extends State<MyBlogPage> {
  @override
  Widget build(BuildContext context) {
    UserModel _userModel = Provider.of<UserModel>(context);
    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: FutureBuilder<List<Blog>?>(
                future: _userModel.getAllBlog(),
                builder: (context, sonuc) {
                  if (sonuc.hasData) {
                    var tumBloglar = sonuc.data;
                    if (tumBloglar!.length > 0) {
                      return Wrap(
                        children: [
                          ...List.generate(
                            tumBloglar.length,
                            (index) {
                              if (sonuc.data![index].writerID ==
                                  _userModel.user!.userID) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 10,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context, rootNavigator: true)
                                          .push(
                                        MaterialPageRoute(
                                          fullscreenDialog: true,
                                          builder: (context) => Detailpage(
                                            blog: tumBloglar[index],
                                            likeCount:
                                                tumBloglar[index].blogLikes,
                                            writers: _userModel.user,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 150,
                                          width: 175,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                            ),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                sonuc.data![index].blogImageUrl
                                                    .toString(),
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: grey.withOpacity(0.5),
                                                blurRadius: 10,
                                                offset: Offset(5, 5),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 175,
                                          padding: EdgeInsets.symmetric(
                                            vertical: 8,
                                            horizontal: 1,
                                          ),
                                          decoration: BoxDecoration(
                                            color: white,
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(20),
                                              bottomRight: Radius.circular(20),
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: grey.withOpacity(0.5),
                                                blurRadius: 10,
                                                offset: Offset(5, 5),
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            // ignore: prefer_const_literals_to_create_immutables
                                            children: [
                                              Text(
                                                sonuc.data![index].blogTitle
                                                    .toString(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                sonuc.data![index].blogDate!
                                                    .toDate()
                                                    .toString()
                                                    .substring(0, 16),
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              } else {
                                return SizedBox();
                              }
                            },
                          ),
                        ],
                      );
                    } else {
                      return Center(
                        child: Text("Kayıtlı Blog Yok."),
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
          ),
        ],
      ),
    );
  }
}
