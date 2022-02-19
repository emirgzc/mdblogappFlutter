// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myblogapp/model/user.dart';
import 'package:myblogapp/pages/author_page.dart';
import 'package:myblogapp/theme/color.dart';
import 'package:myblogapp/viewmodel/view_model.dart';
import 'package:provider/provider.dart';

class AllWriters extends StatelessWidget {
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
          "All Writers",
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
            FutureBuilder<List<MyUser>?>(
              future: _userModel.getAllUser(),
              builder: (context, sonuc) {
                if (sonuc.hasData) {
                  var tumUsers = sonuc.data;
                  if (tumUsers!.length - 1 > 0) {
                    return SizedBox(
                      child: Center(
                        child: Wrap(
                          children: List.generate(
                            tumUsers.length,
                            (index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: 145,
                                            width: 145,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  tumUsers[index]
                                                      .profilUrl
                                                      .toString(),
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(15),
                                                bottomRight:
                                                    Radius.circular(15),
                                              ),
                                              border: Border.all(
                                                color: black.withOpacity(0.1),
                                                width: 1,
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: grey.withOpacity(0.5),
                                                  blurRadius: 10,
                                                  offset: Offset(10, 5),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 3),
                                              width: 145,
                                              decoration: BoxDecoration(
                                                color: grey2.withOpacity(0.7),
                                                borderRadius: BorderRadius.only(
                                                  bottomRight:
                                                      Radius.circular(15),
                                                ),
                                              ),
                                              child: Text(
                                                tumUsers[index]
                                                    .email
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize: 10.5,
                                                  fontWeight: FontWeight.w600,
                                                  letterSpacing: 0.5,
                                                ),
                                                textAlign: TextAlign.center,
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
                                        tumUsers[index].nameSurname.toString(),
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w800,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
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
