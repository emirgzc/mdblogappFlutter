class MyUser {
  final String userID;
  String? nameSurname;
  String? email;
  String? userName;
  String? profilUrl;
  DateTime? createdAt;
  DateTime? updatedAt;

  MyUser({
    required this.userID,
    required this.email,
  });
}
