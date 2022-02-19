// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myblogapp/model/blog.dart';
import 'package:myblogapp/model/user.dart';
import 'package:myblogapp/pages/author_page.dart';
import 'package:myblogapp/pages/detail_page.dart';
import 'package:myblogapp/theme/color.dart';
import 'package:myblogapp/viewmodel/view_model.dart';
import 'package:provider/provider.dart';

class AllPopularBlogs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserModel _userModel = Provider.of<UserModel>(context);
    return Scaffold(
      backgroundColor: grey2,
      appBar: AppBar(
        backgroundColor: grey2,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset("assets/icons/back.svg"),
        ),
        title: Text(
          "All Popular Blogs",
          style: TextStyle(
            color: Colors.black.withOpacity(0.6),
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(height: 10),
            FutureBuilder<List<Blog>?>(
              future: _userModel.getAllBlogLike(),
              builder: (context, sonuc) {
                if (sonuc.hasData) {
                  var tumBlog = sonuc.data;
                  if (tumBlog!.length - 1 > 0) {
                    return SizedBox(
                      child: Center(
                        child: Wrap(
                          children: List.generate(
                            tumBlog.length,
                            (index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                child: FutureBuilder<MyUser?>(
                                  future: _userModel.getUserID(
                                      tumBlog[index].writerID.toString()),
                                  builder: (context, sonuc) {
                                    var tekUser = sonuc.data;
                                    if (sonuc.hasData) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
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
                                                    blog: tumBlog[index],
                                                    likeCount: tumBlog[index]
                                                        .blogLikes,
                                                    writers: tekUser,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Stack(
                                              children: [
                                                Container(
                                                  height: 180,
                                                  width: 155,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                        tumBlog[index]
                                                            .blogImageUrl
                                                            .toString(),
                                                      ),
                                                      fit: BoxFit.cover,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    border: Border.all(
                                                      color: black
                                                          .withOpacity(0.1),
                                                      width: 1,
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: grey
                                                            .withOpacity(0.5),
                                                        blurRadius: 10,
                                                        offset: Offset(10, 5),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Positioned(
                                                  bottom: 0,
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 3),
                                                    width: 155,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          grey.withOpacity(0.7),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        bottomRight:
                                                            Radius.circular(10),
                                                        bottomLeft:
                                                            Radius.circular(10),
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            tekUser!.nameSurname
                                                                .toString(),
                                                            style: TextStyle(
                                                              color: grey2,
                                                              fontSize: 11,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              letterSpacing:
                                                                  0.5,
                                                            ),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                          Text(
                                                            tumBlog[index]
                                                                    .blogLikes
                                                                    .toString() +
                                                                " Likes",
                                                            style: TextStyle(
                                                              color: grey2,
                                                              fontSize: 10.5,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              letterSpacing:
                                                                  0.5,
                                                            ),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          SizedBox(
                                            width: 140,
                                            child: Text(
                                              tumBlog[index]
                                                  .blogTitle
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w800,
                                              ),
                                              textAlign: TextAlign.center,
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
                          ),
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
            SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
