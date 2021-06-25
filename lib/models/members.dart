class Members {
  String _username;
  String _password;
  String _email;
  String _city;

  Members.withZero() {}

  Members.withFour(
      String username, String password, String email, String city) {
    _username = username;
    _password = password;
    _email = email;
    _city = city;
  }

  String get getUserName {
    return _username;
  }

  void set setUserName(String value) {
    _username = value;
  }

  String get getPassword {
    return _password;
  }

  void set setPassword(String value) {
    _password = value;
  }

  String get getEmail {
    return _email;
  }

  void set setEmail(String value) {
    _email = value;
  }

  String get getCity {
    return _city;
  }

  void set setCity(String value) {
    _city = value;
  }
}
