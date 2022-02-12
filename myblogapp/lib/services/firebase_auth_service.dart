// ignore_for_file: unused_field, unnecessary_null_comparison, unused_element, await_only_futures, avoid_print, unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:myblogapp/model/user.dart';
import 'package:myblogapp/services/auth_base.dart';

class FirebaseAuthService implements AuthBase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  Future<MyUser?> createUserWithEmailandPassword(
      //email ve şifre ile kayıt yapmak için
      String email,
      String password) async {
    UserCredential sonuc = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebase(sonuc.user);
  }

  @override
  Future<MyUser?> currentUser() async {
    //var olan userı firebaseden getirme metodu
    try {
      User? user = await _firebaseAuth.currentUser!; //userı aldık
      return _userFromFirebase(user); //kendi userimize çevirdik ve döndürdük
    } catch (e) {
      print("FBS Current User Hata : " + e.toString());
      return null;
    }
  }

  MyUser? _userFromFirebase(User? user) {
    //firebaseden gelen veriyi kendi userimize çevirme işlemi
    if (user == null) {
      return null;
    } else {
      return MyUser(userID: user.uid, email: user.email);
    }
  }

  @override
  Future<MyUser?> signInAnonymously() async {
    try {
      UserCredential sonuc = await _firebaseAuth.signInAnonymously();
      return _userFromFirebase(sonuc.user);
    } catch (e) {
      print("FBS Sign In Anonymously Hata : " + e.toString());
    }
  }

  @override
  Future<MyUser?> signInWithEmailandPassword(
      //email ve şifre ile giriş yapmak için
      String email,
      String password) async {
    UserCredential sonuc = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebase(sonuc.user);
  }

  @override
  Future<MyUser?> signInWithGoogle() async {
    //google ile giriş yapmak için
    GoogleSignIn _googleSignIn = GoogleSignIn();
    GoogleSignInAccount? _googleUser = await _googleSignIn.signIn();

    if (_googleUser != null) {
      GoogleSignInAuthentication _googleAuth = await _googleUser.authentication;
      if (_googleAuth.idToken != null && _googleAuth.accessToken != null) {
        UserCredential sonuc = await _firebaseAuth.signInWithCredential(
          GoogleAuthProvider.credential(
            idToken: _googleAuth.idToken,
            accessToken: _googleAuth.accessToken,
          ),
        );
        User? user = sonuc.user;
        return _userFromFirebase(user);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      final GoogleSignIn _googleSignIn = GoogleSignIn();
      await _googleSignIn.signOut();
      await _firebaseAuth.signOut();
      return true;
    } catch (e) {
      print("FBS Sign Out Hata : " + e.toString());
      return false;
    }
  }

  @override
  Future<bool> updatePasswordWithEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      debugPrint("Şifre resetlenirken hata oluştu" + e.toString());
      return false;
    }
  }
}
