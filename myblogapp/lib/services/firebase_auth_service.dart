// ignore_for_file: unused_field, unnecessary_null_comparison, unused_element, await_only_futures, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:myblogapp/model/user.dart';
import 'package:myblogapp/services/auth_base.dart';

class FirebaseAuthService implements AuthBase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  Future<MyUser> createUserWithEmailandPassword() {
    throw UnimplementedError();
  }

  @override
  Future<MyUser?> currentUser() async {
    //var olan userı firebaseden getirme metodu
    try {
      User? user = await _firebaseAuth.currentUser!; //userı aldık
      return _userFromFirebase(user); //kendi userimize çevirdik ve döndürdük
    } catch (e) {
      print("FBS Current User Hata");
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
  Future<MyUser> signInAnonymously() {
    throw UnimplementedError();
  }

  @override
  Future<MyUser> signInWithEmailandPassword() {
    throw UnimplementedError();
  }

  @override
  Future<MyUser> signInWithGoogle() {
    throw UnimplementedError();
  }

  @override
  Future<bool> signOut() {
    throw UnimplementedError();
  }
}
