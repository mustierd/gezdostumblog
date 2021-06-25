import 'package:email_validator/email_validator.dart';

class ValidationMixin {
  String validateUserName(String value) {
    if (value.isEmpty) {
      return "Zorunlu alanı doldurunuz.";
    } else if (value.length < 3) {
      return "Kullanıcı adı en az 3 karakter olmalıdır.";
    }
  }

  String validatePassword(String value) {
    if (value.isEmpty) {
      return "Zorunlu alanı doldurunuz.";
    } else if (value.length < 6) {
      return "Şifre en az 6 karakter olmalıdır.";
    }
  }

  String validateEmail(String value) {
    if (!(EmailValidator.validate(value))) {
      return "Geçerli mail adresi giriniz.";
    }
  }

  String validateCity(String value) {
    if (value.isEmpty) {
      return "Zorunlu alanı doldurunuz.";
    } else if (value.length < 3) {
      return "Şehrinizi giriniz.";
    }
  }
}
