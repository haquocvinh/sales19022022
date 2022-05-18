class SignUpRequest {
  String? email;
  String? name;
  String? password;
  String? phone;
  String? address;

  SignUpRequest(
      {this.email, this.name, this.password, this.phone, this.address});

  SignUpRequest.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    password = json['password'];
    phone = json['phone'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['name'] = name;
    data['password'] = password;
    data['phone'] = phone;
    data['address'] = address;
    return data;
  }
}
