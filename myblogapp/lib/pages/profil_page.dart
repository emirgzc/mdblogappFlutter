// ignore_for_file: prefer_const_constructors, unused_element, unused_local_variable, unused_field, unnecessary_null_comparison

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myblogapp/pages/profil_update.dart';
import 'package:myblogapp/theme/color.dart';
import 'package:myblogapp/viewmodel/view_model.dart';
import 'package:myblogapp/widget/pd_alert_dialog.dart';
import 'package:provider/provider.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  File? _yeniImage;
  final ImagePicker _picker = ImagePicker();

  _yeniFotoEkle(ImageSource source) async {
    var _pickedFoto = await _picker.pickImage(source: source);

    setState(() {
      _yeniImage = File(_pickedFoto!.path);
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    UserModel _userModel = Provider.of<UserModel>(context);
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
                child: Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return SizedBox(
                              height: 170,
                              child: Column(
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  ListTile(
                                    leading: Icon(Icons.camera),
                                    title: Text("Kameradan Çek"),
                                    onTap: () {
                                      _yeniFotoEkle(ImageSource.camera);
                                    },
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.image),
                                    title: Text("Galeriden Seç"),
                                    onTap: () {
                                      _yeniFotoEkle(ImageSource.gallery);
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: CircleAvatar(
                        radius: 80,
                        backgroundColor: Colors.white,
                        backgroundImage: _yeniImage == null
                            ? NetworkImage(
                                _userModel.user!.profilUrl.toString())
                            : FileImage(_yeniImage!) as ImageProvider,
                      ),
                    ),
                    Positioned(
                      left: 110,
                      top: 110,
                      child: GestureDetector(
                        onTap: () {
                          _profilFotoGuncelle(context);
                        },
                        child: Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: grey2,
                          ),
                          child: Icon(Icons.save),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10),
              Flexible(
                flex: 3,
                child: Column(
                  children: [
                    buildUsersText(
                      label: "İsim : ",
                      text: "${_userModel.user!.nameSurname}",
                    ),
                    buildUsersText(
                      label: "Kullanıcı Adı : ",
                      text: "${_userModel.user!.userName}",
                    ),
                    buildUsersText(
                      label: "Email : ",
                      text: "${_userModel.user!.email}",
                    ),
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
              SizedBox(height: 10),
              buildProfilList(
                text: "Hesap Bilgileri",
                icon: Icons.verified_user_outlined,
                icon2: Icons.arrow_back,
                press: () => Navigator.of(context, rootNavigator: true).push(
                  MaterialPageRoute(
                    builder: (context) => ProfilUpdate(),
                  ),
                ),
              ),
              SizedBox(height: 10),
              buildProfilList(
                text: "Mail Bilgileri",
                icon: Icons.email_outlined,
                icon2: Icons.arrow_back,
              ),
              SizedBox(height: 10),
              buildProfilList(
                text: "Blog Bilgileri",
                icon: Icons.list_outlined,
                icon2: Icons.arrow_back,
              ),
              SizedBox(height: 10),
              buildProfilList(
                text: "Kullanıcı Bilgileri",
                icon: Icons.people_alt_outlined,
                icon2: Icons.arrow_back,
              ),
              SizedBox(height: 10),
              buildProfilList(
                text: "Hesap Hareketleri",
                icon: Icons.kitchen_outlined,
                icon2: Icons.arrow_back,
              ),
              SizedBox(height: 10),
              buildProfilList(
                text: "Ayarlar",
                icon: Icons.settings_outlined,
                icon2: Icons.arrow_back,
              ),
              SizedBox(height: 10),
              buildProfilList(
                  text: "Çıkış",
                  icon: Icons.logout_outlined,
                  icon2: Icons.arrow_back,
                  press: () => _cikisIcinOnayIste(context)),
              SizedBox(height: 10),
            ],
          ),
          SizedBox(height: 50),
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

  Widget buildProfilList(
      {required String text,
      required IconData icon,
      required IconData icon2,
      VoidCallback? press}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: GestureDetector(
        onTap: press,
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: grey2.withOpacity(0.7),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              SizedBox(width: 2),
              Icon(icon),
              SizedBox(width: 2),
              Text(text),
              SizedBox(width: 2),
              Icon(icon2),
              SizedBox(width: 2),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _cikisYap(BuildContext context) async {
    final UserModel _userModel = Provider.of<UserModel>(context, listen: false);
    bool sonuc = await _userModel.signOut();
    return sonuc;
  }

  Future _cikisIcinOnayIste(BuildContext context) async {
    final sonuc = await PDAlertDialog(
      baslik: "Emin Misiniz?",
      icerik: "Çıkmak istediğinizden emin misiniz",
      anaButonYazisi: "Evet",
      iptalButonText: "Vazgeç",
      color: Colors.redAccent,
      icon: Icons.arrow_back_ios,
    ).goster(context);
    if (sonuc == true) {
      _cikisYap(context);
    }
  }

  Future<void> _profilFotoGuncelle(BuildContext context) async {
    final UserModel _userModel = Provider.of<UserModel>(context, listen: false);

    if (_yeniImage != null) {
      var url = await _userModel.uploadFile(
          _userModel.user!.userID, "profil_foto", _yeniImage);

      debugPrint("gelen url : " + url);
      if (url != null) {
        PDAlertDialog(
          baslik: "Başarılı",
          icerik: "Profil fotoğrafınız güncellendi",
          anaButonYazisi: 'Tamam',
          icon: Icons.how_to_reg,
          color: Colors.greenAccent,
        ).goster(context);
        _userModel.user!.profilUrl = url;
      }
    }
  }
}
