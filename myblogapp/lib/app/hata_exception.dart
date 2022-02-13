class Hatalar {
  static String goster(String hataKodu) {
    switch (hataKodu) {
      case "email-already-in-use":
        return "Bu mail adresi zaten kullanımda. Lütfen farklı bir mail kullanınız";
      case "user-not-found":
        return "Bu kullanıcı sistemde kayıtlı değil. Lütfen önce kayıt olunuz.";
      case "wrong-password":
        return "Hatalı Şifre.";
      default:
        return "Bir hata oluştu";
    }
  }
}
