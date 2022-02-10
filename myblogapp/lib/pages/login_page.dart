// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unused_local_variable, must_be_immutable

import 'package:flutter/material.dart';
import 'package:myblogapp/theme/color.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
  bool isChecked = false;
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 50),
              Container(
                height: size.width / 2,
                width: size.height / 3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/logo.png"),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Mail Adresi",
                    hintText: "Lütfen email adresinizi giriniz",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Şifre",
                    hintText: "Lütfen şifrenizi giriniz",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 2),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Text(
                      "Beni Hatırla",
                      style: TextStyle(
                        color: grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Checkbox(
                      checkColor: Colors.white,
                      value: widget.isChecked,
                      fillColor: MaterialStateProperty.resolveWith(getColor),
                      onChanged: (bool? value) {
                        setState(() {
                          widget.isChecked = value!;
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Text(
                      "Şifremi Unuttum?",
                      style: TextStyle(
                        color: grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Kayıt Ol",
                      style: TextStyle(
                        color: grey,
                        fontWeight: FontWeight.bold,
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
                  ),
                  SizedBox(width: 15),
                  buildSocialLoginButoon(
                      icon: Icons.facebook,
                      isFull: false,
                      isColor: Colors.blueAccent),
                  SizedBox(width: 15),
                  buildSocialLoginButoon(
                    icon: Icons.verified_user,
                    isFull: false,
                  ),
                ],
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  Color getColor(Set<MaterialState> states) {
    Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.red;
    }
    return Colors.blue;
  }

  Widget buildSocialLoginButoon({
    String? image,
    bool isFull = true,
    IconData? icon,
    Color isColor = Colors.green,
  }) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 50,
        width: 60,
        decoration: BoxDecoration(
          color: grey.withOpacity(0.16),
          borderRadius: BorderRadius.circular(16),
        ),
        child: SizedBox(
          height: 30,
          width: 30,
          child: (isFull == true)
              ? Image.asset(
                  image!,
                )
              : Icon(
                  icon,
                  size: 36,
                  color: isColor,
                ),
        ),
      ),
    );
  }
}
