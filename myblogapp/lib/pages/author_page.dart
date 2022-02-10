// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myblogapp/model/blog.dart';
import 'package:myblogapp/model/writers.dart';
import 'package:myblogapp/pages/detail_page.dart';
import 'package:myblogapp/theme/color.dart';

class AuthorPage extends StatelessWidget {
  const AuthorPage({Key? key, required this.writers}) : super(key: key);

  final Writers writers;

  @override
  Widget build(BuildContext context) {
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
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                color: grey,
                shape: BoxShape.circle,
                border: Border.all(color: grey.withOpacity(0.5), width: 1),
                image: DecorationImage(
                  image: AssetImage(
                    writers.image,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 10),
            buildUsersText(label: "İsim : ", text: writers.name),
            SizedBox(height: 3),
            buildUsersText(label: "Soyisim : ", text: writers.surname),
            SizedBox(height: 3),
            buildUsersText(label: "Email : ", text: writers.email),
            SizedBox(height: 20),
            Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    "Yayınlanan Blogları",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            Wrap(
              alignment: WrapAlignment.spaceAround,
              children: [
                ...List.generate(
                  popularBlogs.length,
                  (index) => Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (builder) => Detailpage(
                              blog: popularBlogs[index],
                              likeCount: popularBlogs[index].blogLikes,
                            ),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Container(
                            height: 150,
                            width: 170,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                              image: DecorationImage(
                                image: AssetImage(
                                    popularBlogs[index].blogImageUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 170,
                            decoration: BoxDecoration(
                              color: grey.withOpacity(0.2),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                Text(
                                  popularBlogs[index].blogTitle,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  popularBlogs[index].blogDate,
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
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildUsersText({required String label, required String text}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
