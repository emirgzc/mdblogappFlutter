// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myblogapp/widget/platform_duyarli_widget.dart';

class PDAlertDialog extends PlatformDuyarliWidget {
  final String baslik;
  final String icerik;
  final String anaButonYazisi;
  final String? iptalButonText;
  final IconData icon;
  final Color color;

  PDAlertDialog({
    required this.baslik,
    required this.icerik,
    required this.anaButonYazisi,
    required this.icon,
    required this.color,
    this.iptalButonText,
  });

  Future<bool?> goster(BuildContext context) async {
    return Platform.isIOS
        ? await showCupertinoDialog<bool>(
            context: context,
            builder: (context) => this,
          )
        : await showDialog<bool>(
            context: context,
            builder: (context) => this,
            barrierDismissible: false,
          );
  }

  @override
  Widget buildAndroidWidget(BuildContext context) {
    return AlertDialog(
      title: Text(baslik),
      content: Text(icerik),
      actions: _dialogButonAyarla(context),
    );
  }

  @override
  Widget buildIosWidget(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(baslik),
      content: Text(icerik),
      actions: _dialogButonAyarla(context),
    );
  }

  List<Widget> _dialogButonAyarla(BuildContext context) {
    final tumButonlar = <Widget>[];

    if (Platform.isIOS) {
      if (iptalButonText != null) {
        tumButonlar.add(
          CupertinoDialogAction(
            child: Text(iptalButonText!),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
        );
      }
      tumButonlar.add(
        CupertinoDialogAction(
          child: Text(anaButonYazisi),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      );
    } else {
      if (iptalButonText != null) {
        tumButonlar.add(
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text(iptalButonText!),
          ),
        );
      }
      tumButonlar.add(
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: Text(anaButonYazisi),
        ),
      );
    }

    return tumButonlar;
  }
}
