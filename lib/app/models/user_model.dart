class UserModel {
  String? id;
  String? username;
  String? avatar;
  String? email;
  bool isNitro = true;

  UserModel({
    this.id,
    this.username,
    this.avatar,
    this.email,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    avatar = json['avatar'];
    email = json['email'];
  }
}
