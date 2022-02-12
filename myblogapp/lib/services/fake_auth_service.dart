// ignore_for_file: prefer_const_constructors

import 'package:myblogapp/model/user.dart';
import 'package:myblogapp/services/auth_base.dart';

class FakeAuthenticationService implements AuthBase {
  String userID = "123132313213";

  @override
  Future<MyUser> currentUser() async {
    return await Future.value(MyUser(
      userID: userID,
      email: "fakeuser@fake.com",
    ));
  }

  @override
  Future<MyUser> signInAnonymously() async {
    return await Future.delayed(
        Duration(seconds: 2),
        () => MyUser(
              userID: userID,
              email: "fakeuser@fake.com",
            ));
  }

  @override
  Future<bool> signOut() {
    return Future.value(true);
  }

  @override
  Future<MyUser?> signInWithGoogle() async {
    return await Future.delayed(
        Duration(seconds: 2),
        () => MyUser(
              userID: "google_user_id_12312331",
              email: "fakeuser@fake.com",
            ));
  }

  @override
  Future<MyUser?> createUserWithEmailandPassword(
      String email, String password) async {
    return await Future.delayed(
        Duration(seconds: 2),
        () => MyUser(
              userID: "created_user_id_12312331",
              email: "fakeuser@fake.com",
            ));
  }

  @override
  Future<MyUser?> signInWithEmailandPassword(
      String email, String password) async {
    return await Future.delayed(
        Duration(seconds: 2),
        () => MyUser(
              userID: "sign_in_user_id_12312331",
              email: "fakeuser@fake.com",
            ));
  }

  @override
  Future<bool> updatePasswordWithEmail(String email) async {
    return await Future.value(true);
  }
}
