import 'package:myblogapp/model/user.dart';

abstract class AuthBase {
  Future<MyUser?> currentUser(); //var olan useri getirme
  Future<MyUser?> signInAnonymously(); //anonim giriş yapmak için deneme amaçlı
  Future<bool> signOut(); //çıkış yapma işlemi için
  Future<MyUser?> signInWithGoogle(); //Google ile giriş yapmak için
  Future<MyUser?>
      signInWithEmailandPassword(); //Email ve şifre ile giriş yapmak için
  Future<MyUser?>
      createUserWithEmailandPassword(); //email ve şifre ile kayıt olmak için
}
