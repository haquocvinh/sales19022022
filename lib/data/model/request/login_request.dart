class LoginRequest {
  late String phone;
  late String password;

  LoginRequest({required String phone, required String password}) {
    if (phone.isValidPhone() && password.isValidPassword()) {
      this.phone = phone;
      this.password = password;
    } else {
      throw Exception("Sai số điện thoại hoặc mật khẩu");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone'] = phone;
    data['password'] = password;
    return data;
  }
}

/*extension PhoneValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }

  bool isMatch(String email2) {
    if (this == email2) {
      return true;
    }
    return false;
  }
}*/

extension PhoneValidator on String {
  bool isValidPhone() {
    if (length == 10) {
      return true;
    }
    return false;
  }
}

extension Password on String {
  bool isValidPassword() {
    return length >= 6;
  }
}
