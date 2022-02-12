import 'package:get_it/get_it.dart';
import 'package:myblogapp/repository/user_repository.dart';
import 'package:myblogapp/services/fake_auth_service.dart';
import 'package:myblogapp/services/firebase_auth_service.dart';
import 'package:myblogapp/services/firebase_storage_service.dart';
import 'package:myblogapp/services/firestore_db_service.dart';

GetIt locator = GetIt.I;

void setupLocator() {
  locator.registerLazySingleton(() => FirebaseAuthService());
  locator.registerLazySingleton(() => FakeAuthenticationService());
  locator.registerLazySingleton(() => UserRepository());
  locator.registerLazySingleton(() => FirestoreDBService());
  locator.registerLazySingleton(() => FirebaseStorageService());
}
