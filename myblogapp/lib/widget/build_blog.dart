// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myblogapp/model/blog.dart';
import 'package:myblogapp/pages/author_page.dart';
import 'package:myblogapp/pages/detail_page.dart';
import 'package:myblogapp/theme/color.dart';

class BuildBlog extends StatelessWidget {
  final Blog blog;

  const BuildBlog({
    Key? key,
    required this.blog,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 65,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).push(
                          MaterialPageRoute(
                            fullscreenDialog: true,
                            builder: (context) => AuthorPage(
                              writers: blog.blogWriter,
                            ),
                          ),
                        );
                      },
                      child: CircleAvatar(
                        radius: 20,
                        child: Image.asset(
                          blog.blogWriter.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 12,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            blog.blogWriter.name +
                                " " +
                                blog.blogWriter.surname,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            blog.blogDate,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                PopupMenuButton(
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
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context, rootNavigator: true).push(
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: (context) => Detailpage(
                  blog: blog,
                  likeCount: blog.blogLikes,
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
                  image: AssetImage(
                    blog.blogImageUrl,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
            top: 5,
          ),
          height: 129,
          width: double.infinity,
          decoration: BoxDecoration(
            color: grey.withOpacity(0.2),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  blog.blogTitle,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 7),
                Text(
                  blog.blogDesc.substring(0, 150) + "...",
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
                      value: blog.blogComment,
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
