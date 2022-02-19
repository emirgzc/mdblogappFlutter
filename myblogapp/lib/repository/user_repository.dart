// ignore_for_file: constant_identifier_names, prefer_final_fields, unused_field, unused_local_variable, annotate_overrides, override_on_non_overriding_member

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:myblogapp/locator.dart';
import 'package:myblogapp/model/blog.dart';
import 'package:myblogapp/model/user.dart';
import 'package:myblogapp/services/auth_base.dart';
import 'package:myblogapp/services/database_base.dart';
import 'package:myblogapp/services/fake_auth_service.dart';
import 'package:myblogapp/services/firebase_auth_service.dart';
import 'package:myblogapp/services/firebase_storage_service.dart';
import 'package:myblogapp/services/firestore_db_service.dart';

enum AppMode { DEBUG, RELEASE }

class UserRepository implements AuthBase, DatabaseBase {
  FirebaseAuthService _firebaseAuthService = locator<FirebaseAuthService>();
  FakeAuthenticationService _fakeAuthenticationService =
      locator<FakeAuthenticationService>();
  FirestoreDBService _firestoreService = locator<FirestoreDBService>();
  FirebaseStorageService _firebaseStorageService =
      locator<FirebaseStorageService>();

  AppMode appMode = AppMode.RELEASE;

  @override
  Future<MyUser?> currentUser() async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthenticationService.currentUser();
    } else {
      MyUser? _user = await _firebaseAuthService.currentUser();
      return await _firestoreService.readUser(_user!.userID);
    }
  }

  @override
  Future<MyUser?> signInAnonymously() async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthenticationService.signInAnonymously();
    } else {
      return await _firebaseAuthService.signInAnonymously();
    }
  }

  @override
  Future<MyUser?> signInWithEmailandPassword(
      String email, String password) async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthenticationService.signInWithEmailandPassword(
          email, password);
    } else {
      MyUser? _user = await _firebaseAuthService.signInWithEmailandPassword(
          email, password);
      return await _firestoreService.readUser(_user!.userID);
    }
  }

  @override
  Future<MyUser?> createUserWithEmailandPassword(
      String email, String password) async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthenticationService.createUserWithEmailandPassword(
          email, password);
    } else {
      MyUser? _user = await _firebaseAuthService.createUserWithEmailandPassword(
          email, password);
      bool _sonuc = await _firestoreService.saveUser(_user);
      if (_sonuc) {
        return await _firestoreService.readUser(_user!.userID);
      } else {
        return null;
      }
    }
  }

  @override
  Future<MyUser?> signInWithGoogle() async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthenticationService.signInWithGoogle();
    } else {
      MyUser? _user = await _firebaseAuthService.signInWithGoogle();
      bool _sonuc = await _firestoreService.saveUser(_user);
      debugPrint("sonuc : " + _sonuc.toString());
      if (_sonuc) {
        return await _firestoreService.readUser(_user!.userID);
      } else {
        return null;
      }
    }
  }

  @override
  Future<bool> signOut() async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthenticationService.signOut();
    } else {
      return await _firebaseAuthService.signOut();
    }
  }

  Future<bool> updateUserName(String userID, String yeniUserName) async {
    if (appMode == AppMode.DEBUG) {
      return false;
    } else {
      return await _firestoreService.updateUserName(userID, yeniUserName);
    }
  }

  Future<bool> updateProfil(
      String userID, String yeniUserName, String yeniNameSurname) async {
    if (appMode == AppMode.DEBUG) {
      return false;
    } else {
      return await _firestoreService.updateProfil(
        userID,
        yeniUserName,
        yeniNameSurname,
      );
    }
  }

  Future<bool> updateNameSurname(String userID, String yeniNameSurname) async {
    if (appMode == AppMode.DEBUG) {
      return false;
    } else {
      return await _firestoreService.updateNameSurname(userID, yeniNameSurname);
    }
  }

  Future<String> uploadFile(
      String userID, String fileType, File? profilFoto) async {
    if (appMode == AppMode.DEBUG) {
      return "dosya indirme linki";
    } else {
      var profilFotoUrl = await _firebaseStorageService.uploadFile(
          userID, fileType, profilFoto!);

      await _firestoreService.updateProfilFoto(userID, profilFotoUrl);

      return profilFotoUrl;
    }
  }

  Future<String> uploadFileBlog(String blogID, File? profilFoto) async {
    if (appMode == AppMode.DEBUG) {
      return "dosya indirme linki";
    } else {
      var profilFotoUrl =
          await _firebaseStorageService.uploadFile2(blogID, profilFoto!);

      return profilFotoUrl;
    }
  }

  @override
  Future<bool> updatePasswordWithEmail(String email) async {
    if (appMode == AppMode.DEBUG) {
      return false;
    } else {
      return await _firebaseAuthService.updatePasswordWithEmail(email);
    }
  }

  @override
  Future<List<Blog>?> getAllBlog() async {
    if (appMode == AppMode.DEBUG) {
      return [];
    } else {
      var tumKullaniciListesi = await _firestoreService.getAllBlog();
      return tumKullaniciListesi;
    }
  }

  @override
  Future<MyUser> readUser(String userID) async {
    throw UnimplementedError();
  }

  @override
  Future<bool> saveBlog(Blog eklenecekBlog) async {
    if (appMode == AppMode.DEBUG) {
      return true;
    } else {
      return _firestoreService.saveBlog(eklenecekBlog);
    }
  }

  @override
  Future<bool> saveUser(MyUser? user) async {
    throw UnimplementedError();
  }

  @override
  Future<bool> updateProfilFoto(String userID, String profilFotoUrl) async {
    throw UnimplementedError();
  }

  @override
  Future<List<MyUser>?> getAllUser() {
    if (appMode == AppMode.DEBUG) {
      return _firestoreService.getAllUser();
    } else {
      return _firestoreService.getAllUser();
    }
  }

  @override
  Future<List<Blog>?> getAllBlogLike() {
    if (appMode == AppMode.DEBUG) {
      return _firestoreService.getAllBlogLike();
    } else {
      return _firestoreService.getAllBlogLike();
    }
  }

  @override
  Future<MyUser?> getUserID(String writedID) {
    if (appMode == AppMode.DEBUG) {
      return _firestoreService.getUserID(writedID);
    } else {
      return _firestoreService.getUserID(writedID);
    }
  }
}
