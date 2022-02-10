// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:myblogapp/model/blog.dart';
import 'package:myblogapp/widget/build_blog.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildBlog();
  }

  ListView buildBlog() {
    return ListView.builder(
      itemCount: allBlogs.length,
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.only(
            left: 4, right: 4, bottom: (allBlogs.length - 1 == index) ? 30 : 4),
        child: BuildBlog(
          blog: allBlogs[index],
        ),
      ),
    );
  }
}
