// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unused_local_variable, unused_field, must_call_super, unused_element

import 'package:flutter/material.dart';
import 'package:myblogapp/theme/color.dart';
import 'package:myblogapp/viewmodel/view_model.dart';
import 'package:myblogapp/widget/pd_alert_dialog.dart';
import 'package:provider/provider.dart';

class SifremiUnuttum extends StatefulWidget {
  @override
  State<SifremiUnuttum> createState() => _SifremiUnuttumState();
}

class _SifremiUnuttumState extends State<SifremiUnuttum> {
  TextEditingController? _controllerEmail;

  @override
  void initState() {
    _controllerEmail = TextEditingController();
  }

  @override
  void dispose() {
    _controllerEmail!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    String _email;
    final UserModel _userModel = Provider.of<UserModel>(context);
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: grey,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Column(
              children: [
                SizedBox(height: size.height / 5),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  child: Text(
                    "Aşağıdaki alana sistemde kayıtlı olan mail adresinizi giriniz. Ardından mail adresinizi kontrol ediniz." +
                        "Mail adresinize gönderilmiş olan şifre yenileme linkine tıklayarak şifrenizi güncelleyebilirsiniz.",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.6,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  child: Container(
                    height: 55,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: white,
                      border: Border.all(
                        color: grey,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: grey.withOpacity(0.5),
                          blurRadius: 10,
                          offset: Offset(6, 5),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextFormField(
                      controller: _controllerEmail,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        // ignore: prefer_if_null_operators
                        errorText: _userModel.email2HataMesaji != null
                            ? _userModel.email2HataMesaji
                            : null,
                        prefixIcon: Icon(Icons.mail),
                        hintText: "Mail Adresi",
                      ),
                      onSaved: (String? girilenEmail) {
                        _email = girilenEmail!;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: GestureDetector(
                    onTap: () {
                      _userPassGuncelle(context);
                    },
                    child: Container(
                      height: 52,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xFF6c757d),
                        borderRadius: BorderRadius.circular(8),
                        // ignore: prefer_const_literals_to_create_immutables
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10,
                            color: grey.withOpacity(0.5),
                            offset: Offset(8, 5),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          "Şifremi Sıfırla",
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
                SizedBox(height: size.height / 5),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _userPassGuncelle(BuildContext context) async {
    final UserModel _userModel = Provider.of<UserModel>(context, listen: false);

    var updateResult =
        await _userModel.updatePasswordWithEmail(_controllerEmail!.text);

    if (updateResult == true) {
      Navigator.pop(context);
      PDAlertDialog(
        baslik: "Başarılı",
        icerik: "Şifre Resetleme Maili Gönderme Başarılı.",
        anaButonYazisi: "Tamam",
        icon: Icons.how_to_reg,
        color: Colors.greenAccent,
      ).goster(context);
    } else {
      PDAlertDialog(
        baslik: "Hata",
        icerik: "Bir Hata Oluştu",
        anaButonYazisi: "Tamam",
        color: Colors.redAccent,
        icon: Icons.error,
      ).goster(context);
    }
  }
}
