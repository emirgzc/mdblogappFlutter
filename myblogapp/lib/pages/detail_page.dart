// ignore_for_file: prefer_const_constructors, unused_local_variable, must_be_immutable, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myblogapp/model/blog.dart';
import 'package:myblogapp/model/user.dart';
import 'package:myblogapp/pages/author_page.dart';
import 'package:myblogapp/theme/color.dart';

class Detailpage extends StatefulWidget {
  Detailpage(
      {Key? key,
      required this.blog,
      required this.likeCount,
      required this.writers})
      : super(key: key);

  final Blog blog;
  int? likeCount;
  final MyUser? writers;

  @override
  State<Detailpage> createState() => _DetailpageState();
}

class _DetailpageState extends State<Detailpage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: height / 2.2,
            width: double.infinity,
            child: Hero(
              tag: "${widget.blog.blogID}",
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      widget.blog.blogImageUrl.toString(),
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 65,
            left: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: white,
                ),
                child: Icon(Icons.arrow_back),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: height / 2.4),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              color: white,
            ),
            child: ListView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.only(top: 20),
              children: [
                Text(
                  widget.blog.blogTitle.toString(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "Yayın Tarihi : " +
                      widget.blog.blogDate!
                          .toDate()
                          .toString()
                          .substring(0, 16),
                  style: TextStyle(
                    color: grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  widget.blog.blogDesc.toString(),
                  style: TextStyle(
                    color: grey,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Divider(
                  thickness: 1,
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 1),
                    tagButton(
                      image: "like.svg",
                      text: "Likes",
                      value: widget.likeCount.toString(),
                    ),
                    SizedBox(width: 10),
                    tagButton(
                      image: "comment.svg",
                      text: "Comments",
                      value: widget.blog.blogComment.toString(),
                    ),
                    SizedBox(width: 10),
                    tagButton(
                      image: "share.svg",
                      text: "Shares",
                      value: widget.blog.blogShare.toString(),
                    ),
                    SizedBox(width: 10),
                  ],
                ),
                Divider(
                  thickness: 1,
                  height: 40,
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
          Positioned(
            top: 65,
            right: 20,
            child: GestureDetector(
              onTap: () {
                setState(() {});
              },
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 20,
                      offset: Offset(0, 10),
                      color: Colors.black.withOpacity(0.15),
                    ),
                  ],
                  color: white,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: PopupMenuButton(
                  color: Colors.grey.shade100,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                  ),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 20,
                              offset: Offset(0, 10),
                              color: Colors.black.withOpacity(0.15),
                            ),
                          ],
                          color: white,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Icon(
                          Icons.share,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        setState(() {});
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 20,
                              offset: Offset(0, 10),
                              color: Colors.black.withOpacity(0.15),
                            ),
                          ],
                          color: white,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                  child: Icon(
                    Icons.more_horiz_outlined,
                    size: 27,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 70,
          padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                offset: Offset(0, 10),
                color: Colors.black.withOpacity(0.3),
              ),
            ],
            color: white,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AuthorPage(
                            writers: widget.writers,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        image: DecorationImage(
                          image: NetworkImage(
                            widget.writers!.profilUrl.toString(),
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.writers!.nameSurname.toString(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        widget.writers!.email.toString(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget tagButton(
      {required String image, required String text, required String value}) {
    return Column(
      children: [
        CircleAvatar(
          child: SvgPicture.asset(
            "assets/icons/$image",
            color: Colors.green,
            height: 20,
          ),
          backgroundColor: green.withOpacity(0.2),
        ),
        Text(
          text,
          style: TextStyle(
            color: Colors.green.withOpacity(0.6),
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}
