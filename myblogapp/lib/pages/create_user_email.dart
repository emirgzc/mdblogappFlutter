// ignore_for_file: use_key_in_widget_constructors, unused_local_variable, prefer_const_constructors, constant_identifier_names, unused_field, prefer_if_null_operators, unused_element, curly_braces_in_flow_control_structures, unnecessary_null_comparison, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myblogapp/app/hata_exception.dart';
import 'package:myblogapp/model/user.dart';
import 'package:myblogapp/theme/color.dart';
import 'package:myblogapp/viewmodel/view_model.dart';
import 'package:myblogapp/widget/pd_alert_dialog.dart';
import 'package:provider/provider.dart';

class CreateUserEmailPassword extends StatefulWidget {
  @override
  State<CreateUserEmailPassword> createState() =>
      _CreateUserEmailPasswordState();
}

class _CreateUserEmailPasswordState extends State<CreateUserEmailPassword> {
  String? _email, _sifre;
  final _formKey = GlobalKey<FormState>();

  void _formCreate() async {
    try {
      _formKey.currentState!.save();
      debugPrint("email: " + _email! + " şifre: " + _sifre!);
      final UserModel _userModel =
          Provider.of<UserModel>(context, listen: false);
      try {
        MyUser? _olusturulanYapanUser =
            await _userModel.createUserWithEmailandPassword(_email!, _sifre!);
        if (_olusturulanYapanUser! != null)
          print(
            "giriş yapan user id : " + _olusturulanYapanUser.userID.toString(),
          );
      } on FirebaseAuthException catch (e) {
        PDAlertDialog(
          icerik: Hatalar.goster(e.code),
          baslik: "Kullanıcı Oluşturma Hata",
          anaButonYazisi: "Tamam",
          color: Colors.redAccent,
          icon: "assets/icons/complete.svg",
        ).goster(context);
      }
    } catch (e) {
      debugPrint("hata oluştu : " + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final UserModel _userModel = Provider.of<UserModel>(context);

    if (_userModel.user != null) {
      Future.delayed(Duration(milliseconds: 100), () {
        Navigator.of(context).pop();
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: grey2,
        title: Text(
          "Kullanıcı Kayıt",
          style: TextStyle(color: black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
          color: black,
        ),
      ),
      body: _userModel.state == ViewState.Idle
          ? SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(height: size.height / 8),
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
                        SizedBox(height: 30),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
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
                                errorText: _userModel.emailHataMesaji != null
                                    ? _userModel.emailHataMesaji
                                    : null,
                                prefixIcon: Icon(Icons.mail),
                                hintText: "Email Adresi",
                              ),
                              onSaved: (String? girilenEmail) {
                                _email = girilenEmail;
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
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
                                errorText: _userModel.sifreHataMesaji != null
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
                        SizedBox(height: 15),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: SizedBox(
                            height: 50,
                            width: size.width,
                            child: ElevatedButton(
                              onPressed: () => _formCreate(),
                              child: Text("Kayıt Ol"),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white70),
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.all(15)),
                                foregroundColor:
                                    MaterialStateProperty.all(Colors.black),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                textStyle: MaterialStateProperty.all(
                                  TextStyle(fontSize: 15),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 50),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // ignore: prefer_const_literals_to_create_immutables
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
                        SizedBox(height: size.height / 6),
                      ],
                    ),
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
}
