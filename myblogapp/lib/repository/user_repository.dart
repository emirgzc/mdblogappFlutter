// ignore_for_file: constant_identifier_names, prefer_final_fields, unused_field, unused_local_variable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:myblogapp/locator.dart';
import 'package:myblogapp/model/user.dart';
import 'package:myblogapp/services/auth_base.dart';
import 'package:myblogapp/services/fake_auth_service.dart';
import 'package:myblogapp/services/firebase_auth_service.dart';
import 'package:myblogapp/services/firebase_storage_service.dart';
import 'package:myblogapp/services/firestore_db_service.dart';

enum AppMode { DEBUG, RELEASE }

class UserRepository implements AuthBase {
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

  @override
  Future<bool> updatePasswordWithEmail(String email) async {
    if (appMode == AppMode.DEBUG) {
      return false;
    } else {
      return await _firebaseAuthService.updatePasswordWithEmail(email);
    }
  }
}
