// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:myblogapp/pages/login_page.dart';
import 'package:myblogapp/pages/root_page.dart';
import 'package:myblogapp/theme/color.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MD Blog App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //backgroundColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        bottomAppBarColor: grey2.withOpacity(0.5),
        appBarTheme: AppBarTheme(
          color: Colors.white,
          elevation: 0,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
    );
  }
}
