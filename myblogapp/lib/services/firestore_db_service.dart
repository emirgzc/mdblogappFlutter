// ignore_for_file: unused_field, unused_local_variable, avoid_print, prefer_is_empty, override_on_non_overriding_member

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myblogapp/model/user.dart';
import 'package:myblogapp/services/database_base.dart';

class FirestoreDBService implements DatabaseBase {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  @override
  Future<MyUser> readUser(String userID) async {
    //verilen id değerine göre veri okuma
    DocumentSnapshot<Map<String, dynamic>> _okunanUser =
        await _firebaseFirestore.collection("users").doc(userID).get();
    Map<String, dynamic>? _okunanUserBilgileriMap = _okunanUser.data();
    MyUser _okunanUserBilgilerNesne = MyUser.fromMap(_okunanUserBilgileriMap!);
    print("okunan user bilgileri nesnesi : " +
        _okunanUserBilgilerNesne.toString());
    return _okunanUserBilgilerNesne;
  }

  @override
  Future<bool> saveUser(MyUser? user) async {
    //alınan user bilgilerini database içine kaydetme
    try {
      DocumentSnapshot<Map<String, dynamic>> _okunanUser =
          await _firebaseFirestore.doc("users/${user!.userID}").get();
      if (_okunanUser.data() == null) {
        await _firebaseFirestore
            .collection("users")
            .doc(user.userID)
            .set(user.toMap());
        return true;
      }
      Map<String, dynamic>? _okunanUserBilgileriMap = _okunanUser.data();
      MyUser _okunanUserBilgileriNesne =
          MyUser.fromMap(_okunanUserBilgileriMap!);
      print("okunan user nesnesi : " + _okunanUserBilgileriNesne.toString());
      return true;
    } catch (e) {
      debugPrint("Save User Hata : " + e.toString());
      return false;
    }
  }

  @override
  Future<bool> updateUserName(String userID, String yeniUserName) async {
    var users = await _firebaseFirestore
        .collection("users")
        .where("username", isEqualTo: yeniUserName)
        .get();
    if (users.docs.length >= 1) {
      return false;
    } else {
      await _firebaseFirestore.collection("users").doc(userID).update(
        {"userName": yeniUserName},
      );
      return true;
    }
  }

  @override
  Future<bool> updateProfil(
      String userID, String yeniUserName, String yeniNameSurname) async {
    var users = await _firebaseFirestore
        .collection("users")
        .where("username", isEqualTo: yeniUserName)
        .where("nameSurname", isEqualTo: yeniNameSurname)
        .get();
    if (users.docs.length >= 1) {
      return false;
    } else {
      await _firebaseFirestore.collection("users").doc(userID).update(
        {"userName": yeniUserName, "nameSurname": yeniNameSurname},
      );
      return true;
    }
  }

  Future<bool> updateNameSurname(String userID, String yeniNameSurname) async {
    var users = await _firebaseFirestore
        .collection("users")
        .where("nameSurname", isEqualTo: yeniNameSurname)
        .get();
    if (users.docs.length >= 1) {
      return false;
    } else {
      await _firebaseFirestore.collection("users").doc(userID).update(
        {"nameSurname": yeniNameSurname},
      );
      return true;
    }
  }

  Future<bool> updateProfilFoto(String userID, String profilFotoUrl) async {
    await _firebaseFirestore.collection("users").doc(userID).update(
      {"profilUrl": profilFotoUrl},
    );
    return true;
  }
}
