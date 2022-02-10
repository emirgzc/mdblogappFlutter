// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:myblogapp/theme/color.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 5,
              ),
              Flexible(
                flex: 3,
                child: Container(
                  margin: EdgeInsets.only(top: 20, left: 10),
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    color: grey,
                    shape: BoxShape.circle,
                    border: Border.all(color: black.withOpacity(0.7), width: 1),
                    image: DecorationImage(
                      image: AssetImage(
                        "assets/images/w8.jpg",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Flexible(
                flex: 3,
                child: Column(
                  children: [
                    buildUsersText(label: "İsim : ", text: "Muhammed Emir"),
                    buildUsersText(label: "Soyisim : ", text: "Gözcü"),
                    buildUsersText(
                        label: "Email : ", text: "emirgzc4@gmail.com"),
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
          SizedBox(height: 20),
          Column(
            children: [
              buildProfilList(
                text: "Hesap Bilgileri",
                icon: Icon(Icons.verified_user_outlined),
              ),
              buildProfilList(
                text: "Mail Bilgileri",
                icon: Icon(Icons.email_outlined),
              ),
              buildProfilList(
                text: "Blog Bilgileri",
                icon: Icon(Icons.list_outlined),
              ),
              buildProfilList(
                text: "Kullanıcı Bilgileri",
                icon: Icon(Icons.people_alt_outlined),
              ),
              buildProfilList(
                text: "Hesap Hareketleri",
                icon: Icon(Icons.kitchen_outlined),
              ),
              buildProfilList(
                text: "Ayarlar",
                icon: Icon(Icons.settings_outlined),
              ),
              buildProfilList(
                text: "Çıkış",
                icon: Icon(Icons.logout_outlined),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildUsersText({required String label, required String text}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
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

  Widget buildProfilList({required String text, required Icon icon}) {
    return ExpansionTile(
      title: Text(text),
      leading: icon,
      tilePadding: EdgeInsets.symmetric(horizontal: 25),
      subtitle: Text("Detay için tıkla"),
      backgroundColor: Colors.grey.shade300,
      iconColor: Colors.red,
      textColor: Colors.red,
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        ListTile(title: Text(text)),
      ],
    );
  }
}
