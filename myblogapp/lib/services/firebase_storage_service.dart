// ignore_for_file: override_on_non_overriding_member

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:myblogapp/services/storage_base.dart';

class FirebaseStorageService implements StorageBase {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  Reference? _reference;
  @override
  Future<String> uploadFile(
      String userID, String fileType, File yuklenecekDosya) async {
    _reference = _firebaseStorage
        .ref()
        .child(userID)
        .child(fileType)
        .child("profil_foto.png");
    UploadTask uploadTask = _reference!.putFile(yuklenecekDosya);

    var url = await (await uploadTask).ref.getDownloadURL();

    return url;
  }

  @override
  Future<String> uploadFile2(String blogID, File yuklenecekDosya) async {
    _reference = _firebaseStorage.ref().child(blogID).child("blog_image.png");
    UploadTask uploadTask = _reference!.putFile(yuklenecekDosya);

    var url = await (await uploadTask).ref.getDownloadURL();

    return url;
  }
}
