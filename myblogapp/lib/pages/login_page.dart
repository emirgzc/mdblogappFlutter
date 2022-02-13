// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unused_local_variable, must_be_immutable, avoid_print, unused_element, unnecessary_null_comparison, unused_field, curly_braces_in_flow_control_structures, prefer_if_null_operators, unnecessary_brace_in_string_interps, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myblogapp/app/hata_exception.dart';
import 'package:myblogapp/model/user.dart';
import 'package:myblogapp/pages/create_user_email.dart';
import 'package:myblogapp/pages/sifremi_unuttum.dart';
import 'package:myblogapp/theme/color.dart';
import 'package:myblogapp/viewmodel/view_model.dart';
import 'package:myblogapp/widget/pd_alert_dialog.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? _email, _sifre;
  final _formKey = GlobalKey<FormState>();

  void _formLogin() async {
    try {
      _formKey.currentState!.save();
      debugPrint("email: " + _email! + " şifre: " + _sifre!);
      final UserModel _userModel =
          Provider.of<UserModel>(context, listen: false);

      try {
        MyUser? _girisYapanUser =
            await _userModel.signInWithEmailandPassword(_email!, _sifre!);
        if (_girisYapanUser! != null)
          debugPrint(
            "giriş yapan user id : " + _girisYapanUser.userID.toString(),
          );
      } on FirebaseAuthException catch (e) {
        PDAlertDialog(
          icerik: Hatalar.goster(e.code),
          baslik: "Kullanıcı Giriş Hata",
          anaButonYazisi: "Tamam",
          color: Colors.redAccent,
          icon: "assets/icons/errors.svg",
        ).goster(context);
      }
    } catch (e) {
      debugPrint("hata oluştu : " + e.toString());
    }
  }

  Future<void> _misafirGiris(BuildContext context) async {
    final UserModel _userModel = Provider.of<UserModel>(context, listen: false);
    try {
      MyUser? _user = await _userModel.signInAnonymously();
      print("Anonim Giriş Başarılı id : " + _user!.userID.toString());
    } catch (err) {
      print(err);
    }
  }

  Future<void> _googleIleGiris(BuildContext context) async {
    final UserModel _userModel = Provider.of<UserModel>(context, listen: false);
    try {
      MyUser? _user = await _userModel.signInWithGoogle();
      if (_user! != null) {
        print("google ile Giriş Başarılı id : " + _user.userID.toString());
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final UserModel _userModel = Provider.of<UserModel>(context);
    if (_userModel.user != null) {
      Future.delayed(Duration(milliseconds: 100), () {
        Navigator.of(context).pop();
      });
    }
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
      ),
      body: _userModel.state == ViewState.Idle
          ? SafeArea(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(height: 15),
                      Container(
                        height: 165,
                        width: 165,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/logo.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 60),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 25,
                                vertical: 5,
                              ),
                              child: Container(
                                height: 55,
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: white,
                                  border: Border.all(
                                    color: grey,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: grey.withOpacity(0.5),
                                      blurRadius: 10,
                                      offset: Offset(5, 5),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    errorText:
                                        _userModel.emailHataMesaji != null
                                            ? _userModel.emailHataMesaji
                                            : null,
                                    prefixIcon: Icon(Icons.mail),
                                    hintText: "Mail Adresi",
                                  ),
                                  onSaved: (String? girilenEmail) {
                                    _email = girilenEmail;
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 5),
                              child: Container(
                                height: 55,
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: white,
                                  border: Border.all(
                                    color: grey,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: grey.withOpacity(0.5),
                                      blurRadius: 10,
                                      offset: Offset(5, 5),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: TextFormField(
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    errorText:
                                        _userModel.sifreHataMesaji != null
                                            ? _userModel.sifreHataMesaji
                                            : null,
                                    prefixIcon: Icon(Icons.vpn_key),
                                    hintText: "Şifre",
                                  ),
                                  onSaved: (String? girilenSifre) {
                                    _sifre = girilenSifre;
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 10),
                              child: GestureDetector(
                                onTap: () => _formLogin(),
                                child: Container(
                                  height: 55,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF6c757d),
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 10,
                                        color: grey.withOpacity(0.3),
                                        offset: Offset(10, 5),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Giriş",
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 27),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context, rootNavigator: true).push(
                                  MaterialPageRoute(
                                    fullscreenDialog: true,
                                    builder: (context) => SifremiUnuttum(),
                                  ),
                                );
                              },
                              child: Text(
                                "Şifremi Unuttum?",
                                style: TextStyle(
                                  color: grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context, rootNavigator: true).push(
                                  MaterialPageRoute(
                                    fullscreenDialog: true,
                                    builder: (context) =>
                                        CreateUserEmailPassword(),
                                  ),
                                );
                              },
                              child: Text(
                                "Kayıt Ol",
                                style: TextStyle(
                                  color: grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          buildSocialLoginButoon(
                              image: "assets/images/google-logo.png",
                              onPressed: () => _googleIleGiris(context),
                              text: "Google"),
                          buildSocialLoginButoon(
                            icon: Icons.facebook,
                            isFull: false,
                            isColor: Colors.blueAccent,
                            text: "Facebook",
                          ),
                        ],
                      ),
                      SizedBox(height: 50),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Created by",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              " Emir Gözcü ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            Icon(
                              Icons.copyright,
                              size: 17,
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
            )
          : Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 5),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/logo.png"),
                            fit: BoxFit.cover,
                          ),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    CircularProgressIndicator(
                      backgroundColor: grey,
                    ),
                    SizedBox(height: 5),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        "Loading",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget buildSocialLoginButoon({
    String? image,
    bool isFull = true,
    IconData? icon,
    Color isColor = Colors.green,
    VoidCallback? onPressed,
    String? text,
  }) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          height: 50,
          width: size.width / 2.5,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(7),
            boxShadow: [
              BoxShadow(
                color: grey.withOpacity(0.5),
                blurRadius: 10,
                offset: Offset(5, 5),
              ),
            ],
          ),
          child: SizedBox(
            height: 30,
            width: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                (isFull == true)
                    ? Image.asset(
                        image!,
                      )
                    : Icon(
                        icon,
                        size: 36,
                        color: isColor,
                      ),
                Text(
                  "${text}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
