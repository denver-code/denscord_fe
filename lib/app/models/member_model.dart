class MemberModel {
  String? id;
  String? username;
  String? avatar;

  MemberModel({
    this.id,
    this.username,
    this.avatar,
  });

  MemberModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    avatar = json['avatar'];
  }
}
