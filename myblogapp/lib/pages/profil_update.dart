// ignore_for_file: use_key_in_widget_constructors, unused_field, must_call_super, unused_local_variable, prefer_const_constructors, unnecessary_null_comparison, unused_element

import 'package:flutter/material.dart';
import 'package:myblogapp/theme/color.dart';
import 'package:myblogapp/viewmodel/view_model.dart';
import 'package:myblogapp/widget/pd_alert_dialog.dart';
import 'package:provider/provider.dart';

class ProfilUpdate extends StatefulWidget {
  @override
  State<ProfilUpdate> createState() => _ProfilUpdateState();
}

class _ProfilUpdateState extends State<ProfilUpdate> {
  TextEditingController? _controllerUserName;
  TextEditingController? _controllerNameSurname;

  @override
  void initState() {
    _controllerUserName = TextEditingController();
    _controllerNameSurname = TextEditingController();
  }

  @override
  void dispose() {
    _controllerUserName!.dispose();
    _controllerNameSurname!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserModel _userModel = Provider.of<UserModel>(context);
    _controllerUserName!.text = _userModel.user!.userName!;
    _controllerNameSurname!.text = _userModel.user!.nameSurname!;
    debugPrint("profildeki user değerleri : " + _userModel.user.toString());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: grey2,
        title: Text(
          "Update Profil",
          style: TextStyle(color: grey),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: grey,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 20),
              CircleAvatar(
                radius: 80,
                backgroundImage: NetworkImage(
                  _userModel.user!.profilUrl.toString(),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: TextFormField(
                  controller: _controllerNameSurname,
                  decoration: InputDecoration(
                    labelText: "Name Surname",
                    hintText: "Name Surname",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: TextFormField(
                  initialValue: _userModel.user!.email,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: "Email",
                    hintText: "Email",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: TextFormField(
                  controller: _controllerUserName,
                  decoration: InputDecoration(
                    labelText: "Username",
                    hintText: "Username",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                child: ElevatedButton(
                  onPressed: () {
                    _userGuncelle(context);
                    debugPrint(DateTime.now().toString());
                  },
                  child: Text("Güncelle"),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white70),
                    padding: MaterialStateProperty.all(EdgeInsets.all(15)),
                    foregroundColor: MaterialStateProperty.all(Colors.black),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
            ],
          ),
        ),
      ),
    );
  }

  void _userNameGuncelle(BuildContext context) async {
    final UserModel _userModel = Provider.of<UserModel>(context, listen: false);
    if (_userModel.user!.userName != _controllerUserName!.text) {
      var updateResult = await _userModel.updateUserName(
          _userModel.user!.userID, _controllerUserName!.text);

      if (updateResult == true) {
        PDAlertDialog(
          baslik: "Başarılı",
          icerik: "Username Güncellendi.",
          anaButonYazisi: "Tamam",
          icon: "assets/icons/complete.svg",
          color: Colors.greenAccent,
        ).goster(context);
      } else {
        _controllerUserName!.text = _userModel.user!.userName!;
        PDAlertDialog(
          baslik: "Hata",
          icerik: "Username zaten kullanımda. Farklı değer giriniz",
          anaButonYazisi: "Tamam",
          color: Colors.redAccent,
          icon: "assets/icons/errors.svg",
        ).goster(context);
      }
    }
  }

  void _userGuncelle(BuildContext context) async {
    final UserModel _userModel = Provider.of<UserModel>(context, listen: false);

    if (_userModel.user!.userName != _controllerUserName!.text ||
        _userModel.user!.nameSurname != _controllerNameSurname!.text) {
      var updateResult = await _userModel.updateProfil(
        _userModel.user!.userID,
        _controllerUserName!.text,
        _controllerNameSurname!.text,
      );

      if (updateResult == true) {
        Navigator.pop(context);
        PDAlertDialog(
          baslik: "Başarılı",
          icerik: "Güncelleme Başarılı.",
          anaButonYazisi: "Tamam",
          icon: "assets/icons/complete.svg",
          color: Colors.greenAccent,
        ).goster(context);
      } else {
        _controllerUserName!.text = _userModel.user!.userName!;
        PDAlertDialog(
          baslik: "Hata",
          icerik: "Bir Hata Oluştu",
          anaButonYazisi: "Tamam",
          color: Colors.redAccent,
          icon: "assets/icons/errors.svg",
        ).goster(context);
      }
    }
  }

  void _nameSurnameGuncelle(BuildContext context) async {
    final UserModel _userModel = Provider.of<UserModel>(context, listen: false);
    if (_userModel.user!.nameSurname != _controllerNameSurname!.text) {
      var updateResult = await _userModel.updateNameSurname(
          _userModel.user!.userID, _controllerNameSurname!.text);

      if (updateResult == true) {
        PDAlertDialog(
          baslik: "Başarılı",
          icerik: "Name Surname Güncellendi.",
          anaButonYazisi: "Tamam",
          icon: "assets/icons/complete.svg",
          color: Colors.greenAccent,
        ).goster(context);
      } else {
        _controllerNameSurname!.text = _userModel.user!.nameSurname!;
        PDAlertDialog(
          baslik: "Hata",
          icerik: "Name Surname zaten kullanımda. Farklı değer giriniz",
          anaButonYazisi: "Tamam",
          color: Colors.redAccent,
          icon: "assets/icons/errors.svg",
        ).goster(context);
      }
    }
  }
}
