import 'package:myblogapp/model/blog.dart';
import 'package:myblogapp/model/user.dart';

abstract class DatabaseBase {
  Future<bool> saveUser(MyUser? user); //useri kaydetmek için
  Future<MyUser> readUser(String userID); //useri okumak için
  Future<bool> updateUserName(String userID, String yeniUserName);
  Future<bool> updateProfilFoto(String userID, String profilFotoUrl);
  Future<List<Blog>?> getAllBlog();
  Future<List<Blog>?> getAllBlogLike();
  Future<List<MyUser>?> getAllUser();
  Future<MyUser?> getUserID(String writedID);
  Future<bool> saveBlog(Blog eklenecekBlog);
}
