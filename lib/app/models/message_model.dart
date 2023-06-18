class MessageModel {
  String? id;
  String? message;
  String? authorAvatar;
  String? authorUsername;
  String? createdAt;

  MessageModel({
    this.id,
    this.message,
    this.authorAvatar,
    this.authorUsername,
    this.createdAt,
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
    authorAvatar = json['author_avatar'];
    authorUsername = json['author_username'];
    createdAt = json['created_at'];
  }
}
