// ignore_for_file: prefer_const_constructors, unused_local_variable, unnecessary_brace_in_string_interps, unused_element, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myblogapp/model/blog.dart';
import 'package:myblogapp/model/user.dart';
import 'package:myblogapp/pages/author_page.dart';
import 'package:myblogapp/pages/detail_page.dart';
import 'package:myblogapp/theme/color.dart';
import 'package:myblogapp/viewmodel/view_model.dart';
import 'package:provider/provider.dart';

class BuildBlog extends StatelessWidget {
  Future<String?> _userIDGet(BuildContext context) async {
    UserModel _userModel = Provider.of<UserModel>(context, listen: false);
    var getUser = await _userModel.getUserID(blog.writerID.toString());
    return getUser!.profilUrl;
  }

  final Blog blog;

  const BuildBlog({
    Key? key,
    required this.blog,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userIdd = _userIDGet(context);
    UserModel _userModel = Provider.of<UserModel>(context);

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2),
          ),
          child: FutureBuilder<MyUser?>(
            future: _userModel.getUserID(blog.writerID.toString()),
            builder: (context, sonuc) {
              if (sonuc.hasData) {
                var tekUser = sonuc.data;
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Flexible(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () async {
                            Navigator.of(context, rootNavigator: true).push(
                              MaterialPageRoute(
                                fullscreenDialog: true,
                                builder: (context) => AuthorPage(
                                  writers: tekUser,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(
                                  tekUser!.profilUrl.toString(),
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 5,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 12,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  tekUser.nameSurname.toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  blog.blogDate!
                                      .toDate()
                                      .toString()
                                      .substring(0, 16),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: PopupMenuButton(
                          color: Colors.grey.shade300,
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              child: Text('Share'),
                            ),
                            PopupMenuItem(
                              child: Text('More'),
                            ),
                          ],
                          child: SvgPicture.asset(
                            "assets/icons/more.svg",
                            height: 20,
                          ),
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
        FutureBuilder<MyUser?>(
          future: _userModel.getUserID(blog.writerID.toString()),
          builder: (context, sonuc) {
            if (sonuc.hasData) {
              var tekUserr = sonuc.data;
              return GestureDetector(
                onTap: () {
                  Navigator.of(context, rootNavigator: true).push(
                    MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (context) => Detailpage(
                        blog: blog,
                        likeCount: blog.blogLikes,
                        writers: tekUserr,
                      ),
                    ),
                  );
                },
                child: Hero(
                  tag: "${blog.blogID}",
                  child: Container(
                    height: 220,
                    decoration: BoxDecoration(
                      /*borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40), bottomRight: Radius.circular(40)),*/
                      color: Colors.transparent,
                      image: DecorationImage(
                        image: NetworkImage(
                          blog.blogImageUrl.toString(),
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
        ),
        Container(
          padding: EdgeInsets.only(
            top: 5,
          ),
          width: double.infinity,
          decoration: BoxDecoration(
            color: grey.withOpacity(0.2),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  blog.blogTitle.toString(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 7),
                Text(
                  blog.blogDesc!.substring(0, 150) + "...",
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 1),
                    tagButtonTwo(
                      text: "Likes",
                      value: blog.blogLikes.toString(),
                    ),
                    SizedBox(width: 10),
                    tagButtonTwo(
                      text: "Comments",
                      value: blog.blogComment.toString(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<List<MyUser>> allUser(BuildContext context) async {
    UserModel _userModel = Provider.of<UserModel>(context, listen: false);
    List<MyUser>? tumUser = await _userModel.getAllUser();
    List<MyUser> tumUserlar = [];
    for (var users in tumUser!) {
      tumUserlar.add(users);
      debugPrint(users.toString());
    }
    return tumUserlar;
  }

  Widget tagButtonTwo({required String text, required String value}) {
    return Row(
      children: [
        Text(
          text,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(width: 5),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}
