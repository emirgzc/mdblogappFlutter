// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myblogapp/model/blog.dart';
import 'package:myblogapp/model/user.dart';
import 'package:myblogapp/pages/detail_page.dart';
import 'package:myblogapp/theme/color.dart';
import 'package:myblogapp/viewmodel/view_model.dart';
import 'package:provider/provider.dart';

class AuthorPage extends StatelessWidget {
  const AuthorPage({Key? key, required this.writers}) : super(key: key);

  final MyUser? writers;

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
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(height: 15),
            Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                color: grey,
                shape: BoxShape.circle,
                border: Border.all(color: grey.withOpacity(0.5), width: 1),
                image: DecorationImage(
                  image: NetworkImage(
                    writers!.profilUrl.toString(),
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 10),
            buildUsersText(
              label: "İsim : ",
              text: writers!.nameSurname.toString(),
            ),
            SizedBox(height: 3),
            buildUsersText(
              label: "Email : ",
              text: writers!.email.toString(),
            ),
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
            SizedBox(
              width: double.infinity,
              child: FutureBuilder<List<Blog>?>(
                future: _userModel.getAllBlog(),
                builder: (context, sonuc) {
                  if (sonuc.hasData) {
                    var tumBloglar = sonuc.data;
                    return Wrap(
                      children: [
                        ...List.generate(
                          tumBloglar!.length,
                          (index) {
                            var oankiBlogId = sonuc.data![index];
                            if (oankiBlogId.writerID == writers!.userID) {
                              return Padding(
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
                                          blog: tumBloglar[index],
                                          likeCount:
                                              tumBloglar[index].blogLikes,
                                          writers: writers,
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
                                              tumBloglar[index]
                                                  .blogImageUrl
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
                                        padding:
                                            EdgeInsets.symmetric(vertical: 8),
                                        decoration: BoxDecoration(
                                          color: white.withOpacity(0.8),
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
                                              tumBloglar[index]
                                                  .blogTitle
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            Text(
                                              tumBloglar[index]
                                                  .blogDate!
                                                  .toDate()
                                                  .toString()
                                                  .substring(0, 16),
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              textAlign: TextAlign.center,
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
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
            SizedBox(height: 15),
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
        Flexible(
          flex: 1,
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Flexible(
          flex: 2,
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
