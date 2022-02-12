import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class MyUser {
  final String userID;
  String? nameSurname;
  String? email;
  String? userName;
  String? profilUrl;
  DateTime? createdAt;
  DateTime? updatedAt;

  MyUser({
    required this.userID,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      "userID": userID,
      "nameSurname": userName ??
          email!.substring(0, email!.indexOf("@")) + randomSayiUret2(),
      "email": email,
      "userName": userName ??
          email!.substring(0, email!.indexOf("@")) + randomSayiUret1(),
      "profilUrl": profilUrl ??
          "https://www.kindpng.com/picc/m/24-248253_user-profile-default-image-png-clipart-png-download.png",
      "createdAt": createdAt ?? FieldValue.serverTimestamp(),
      "updatedAt": updatedAt ?? FieldValue.serverTimestamp(),
    };
  }

  MyUser.fromMap(Map<String, dynamic> map)
      : userID = map["userID"],
        nameSurname = map["nameSurname"],
        email = map["email"],
        userName = map["userName"],
        profilUrl = map["profilUrl"],
        createdAt = (map["createdAt"] as Timestamp).toDate(),
        updatedAt = (map["updatedAt"] as Timestamp).toDate();

  @override
  String toString() {
    return "User{userID}: $userID,nameSurname: $nameSurname, email: $email, userName:$userName, profilUrl: $profilUrl, createdAt: $createdAt, updatedAt: $updatedAt";
  }

  String randomSayiUret1() {
    int rastgeleSayi = Random().nextInt(999999);
    return rastgeleSayi.toString();
  }

  String randomSayiUret2() {
    int rastgeleSayi = Random().nextInt(99);
    return rastgeleSayi.toString();
  }
}
