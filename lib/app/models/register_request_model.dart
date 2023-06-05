import 'dart:convert';

class RegisterRequestModel {
  String? email;
  String? password;
  String? username;

  RegisterRequestModel({this.email, this.password, this.username});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data["username"] = username;
    data['password'] = password;
    return data;
  }

  String export() {
    return json.encode(toJson());
  }
}
