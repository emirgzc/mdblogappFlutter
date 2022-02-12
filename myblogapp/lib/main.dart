// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myblogapp/locator.dart';
import 'package:myblogapp/pages/landing_page.dart';
import 'package:myblogapp/theme/color.dart';
import 'package:myblogapp/viewmodel/view_model.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  try {
    setupLocator();
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    runApp(MyApp());
  } catch (e) {
    debugPrint("Main hata : " + e.toString());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserModel(),
      child: MaterialApp(
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
        home: LandingPageUser(),
      ),
    );
  }
}
