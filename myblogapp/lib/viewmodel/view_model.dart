// ignore_for_file: constant_identifier_names, prefer_final_fields, unused_field, unnecessary_getters_setters, unused_local_variable, unnecessary_null_comparison, unused_element, annotate_overrides

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:myblogapp/locator.dart';
import 'package:myblogapp/model/blog.dart';
import 'package:myblogapp/model/user.dart';
import 'package:myblogapp/repository/user_repository.dart';
import 'package:myblogapp/services/auth_base.dart';
import 'package:myblogapp/services/database_base.dart';

enum ViewState { Idle, Busy }

class UserModel with ChangeNotifier implements AuthBase, DatabaseBase {
  ViewState _state = ViewState.Idle;
  UserRepository _userRepository = locator<UserRepository>();
  MyUser? _user;
  Blog? _blog;
  String? emailHataMesaji;
  String? email2HataMesaji;
  String? sifreHataMesaji;

  MyUser? get user => _user;

  Blog? get blog => _blog;

  ViewState get state => _state;

  set state(ViewState value) {
    _state = value;
    notifyListeners();
  }

  UserModel() {
    currentUser();
  }

  @override
  Future<MyUser?> currentUser() async {
    try {
      state = ViewState.Busy;
      _user = await _userRepository.currentUser();
      return _user;
    } catch (e) {
      debugPrint("viewmodel current user hata : " + e.toString());
      return null;
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<MyUser?> signInAnonymously() async {
    try {
      state = ViewState.Busy;
      _user = await _userRepository.signInAnonymously();
      return _user;
    } catch (e) {
      debugPrint("viewmodel current user hata : " + e.toString());
      return null;
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<MyUser?> signInWithGoogle() async {
    try {
      state = ViewState.Busy;
      _user = await _userRepository.signInWithGoogle();
      return _user;
    } catch (e) {
      debugPrint("viewmodel sign in user hata : " + e.toString());
      return null;
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      state = ViewState.Busy;
      bool sonuc = await _userRepository.signOut();
      _user = null;
      return sonuc;
    } catch (e) {
      debugPrint("viewmodel current user hata : " + e.toString());
      return false;
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<MyUser?> signInWithEmailandPassword(
      String email, String password) async {
    if (_emailSifreKontrol(email, password)) {
      try {
        state = ViewState.Busy;
        _user =
            await _userRepository.signInWithEmailandPassword(email, password);
        state = ViewState.Idle;
        return _user;
      } finally {
        state = ViewState.Idle;
      }
    } else {
      return null;
    }
  }

  @override
  Future<MyUser?> createUserWithEmailandPassword(
      String email, String password) async {
    if (_emailSifreKontrol(email, password)) {
      try {
        state = ViewState.Busy;
        _user = await _userRepository.createUserWithEmailandPassword(
            email, password);
        state = ViewState.Idle;
        return _user;
      } finally {
        state = ViewState.Idle;
      }
    } else {
      return null;
    }
  }

  bool _emailSifreKontrol(String email, String sifre) {
    var sonuc = true;

    if (sifre.length < 6) {
      sifreHataMesaji = "En az 6 karakter olmalı.";
      sonuc = false;
    } else {
      sifreHataMesaji = null;
    }
    if (!email.contains('@')) {
      emailHataMesaji = "Geçersiz email adresi.";
      sonuc = false;
    } else {
      emailHataMesaji = null;
    }

    return sonuc;
  }

  bool _emailKontrol(String email) {
    var sonuc = true;

    if (!email.contains('@')) {
      email2HataMesaji = "Geçersiz email adresi.";
      sonuc = false;
    } else {
      email2HataMesaji = null;
    }

    return sonuc;
  }

  @override
  Future<bool> updatePasswordWithEmail(String email) async {
    try {
      if (_emailKontrol(email)) {
        state = ViewState.Busy;
        var sonuc = await _userRepository.updatePasswordWithEmail(email);
        return sonuc;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint("user model hata : " + e.toString());
      return false;
    } finally {
      state = ViewState.Idle;
    }
  }

  Future<bool> updateUserName(String userID, String yeniUserName) async {
    //state = ViewState.Busy;
    var sonuc = await _userRepository.updateUserName(userID, yeniUserName);
    if (sonuc) {
      _user!.userName = yeniUserName;
    }
    //state = ViewState.Idle;
    return sonuc;
  }

  Future<bool> updateProfil(
      String userID, String yeniUserName, String yeniNameSurname) async {
    //state = ViewState.Busy;
    var sonuc = await _userRepository.updateProfil(
      userID,
      yeniUserName,
      yeniNameSurname,
    );
    if (sonuc) {
      _user!.userName = yeniUserName;
      _user!.nameSurname = yeniNameSurname;
      state = ViewState.Idle;
    }
    //state = ViewState.Idle;
    return sonuc;
  }

  Future<String> updateProfilPhoto(File image, String fileType) async {
    var sonuc =
        await _userRepository.uploadFile(_user!.userID, fileType, image);
    if (sonuc != null) {
      state = ViewState.Idle;
    }
    return sonuc;
  }

  Future<bool> updateNameSurname(String userID, String yeniNameSurname) async {
    //state = ViewState.Busy;
    var sonuc =
        await _userRepository.updateNameSurname(userID, yeniNameSurname);
    if (sonuc) {
      _user!.userName = yeniNameSurname;
    }
    //state = ViewState.Idle;
    return sonuc;
  }

  Future<String> uploadFile(
      String userID, String fileType, File? profilFoto) async {
    var indirmeLinki =
        await _userRepository.uploadFile(userID, fileType, profilFoto);
    return indirmeLinki;
  }

  Future<String> uploadFileBlog(String blogID, File? profilFoto) async {
    var indirmeLinki = await _userRepository.uploadFileBlog(blogID, profilFoto);
    return indirmeLinki;
  }

  @override
  Future<List<Blog>?> getAllBlog() async {
    var tumBlogListesi = await _userRepository.getAllBlog();
    return tumBlogListesi;
  }

  @override
  Future<List<Blog>?> getAllBlogLike() async {
    var tumBlogListesi = await _userRepository.getAllBlogLike();
    return tumBlogListesi;
  }

  @override
  Future<MyUser> readUser(String userID) {
    throw UnimplementedError();
  }

  @override
  Future<bool> saveBlog(Blog eklenecekBlog) {
    var sonuc = _userRepository.saveBlog(eklenecekBlog);
    if (sonuc != null) {
      state = ViewState.Idle;
    }
    return sonuc;
  }

  @override
  Future<bool> saveUser(MyUser? user) {
    throw UnimplementedError();
  }

  @override
  Future<bool> updateProfilFoto(String userID, String profilFotoUrl) {
    throw UnimplementedError();
  }

  @override
  Future<List<MyUser>?> getAllUser() async {
    var tumKullaniciListesi = await _userRepository.getAllUser();
    return tumKullaniciListesi;
  }

  @override
  Future<MyUser?> getUserID(String writedID) async {
    var userID = await _userRepository.getUserID(writedID);
    return userID;
  }
}
