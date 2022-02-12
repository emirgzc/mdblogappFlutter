import 'package:myblogapp/model/user.dart';

abstract class DatabaseBase {
  Future<bool> saveUser(MyUser? user); //useri kaydetmek için
  Future<MyUser> readUser(String userID); //useri okumak için
  Future<bool> updateUserName(String userID, String yeniUserName);
}
