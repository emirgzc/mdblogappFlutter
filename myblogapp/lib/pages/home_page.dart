// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:flutter/material.dart';
import 'package:myblogapp/model/blog.dart';
import 'package:myblogapp/model/user.dart';
import 'package:myblogapp/viewmodel/view_model.dart';
import 'package:myblogapp/widget/build_blog.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return buildBlog(context);
  }

  FutureBuilder<List<Blog>?> buildBlog(BuildContext context) {
    UserModel _userModel = Provider.of<UserModel>(context);
    return FutureBuilder<List<Blog>?>(
      future: _userModel.getAllBlog(),
      builder: (context, sonuc) {
        if (sonuc.hasData) {
          var tumBloglar = sonuc.data;
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                ...List.generate(
                  tumBloglar!.length,
                  (index) {
                    return Padding(
                      padding: EdgeInsets.only(
                          left: 4,
                          right: 4,
                          bottom: (tumBloglar.length - 1 == index) ? 30 : 4),
                      child: BuildBlog(
                        blog: sonuc.data![index],
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

/*return Padding(
                padding: EdgeInsets.only(
                    left: 4,
                    right: 4,
                    bottom: (tumBloglar.length - 1 == index) ? 30 : 4),
                child: BuildBlog(
                  blog: sonuc.data![index],
                ),
              );*/