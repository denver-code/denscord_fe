class InviteRequestModel {
  String? id;
  RequestMemberModel? sender;
  RequestMemberModel? recipient;
  GuildInviteModel? guild;
  String? createdAt;

  InviteRequestModel({
    this.id,
    this.sender,
    this.recipient,
    this.guild,
    this.createdAt,
  });

  InviteRequestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sender = RequestMemberModel.fromJson(json['sender']);
    recipient = RequestMemberModel.fromJson(json['recipient']);
    guild = GuildInviteModel.fromJson(json['guild']);
    createdAt = json['created_at'];
  }
}

class RequestMemberModel {
  String? id;
  String? username;
  String? avatar;

  RequestMemberModel({
    this.id,
    this.username,
    this.avatar,
  });

  RequestMemberModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    avatar = json['avatar'];
  }
}

class GuildInviteModel {
  String? id;
  String? name;
  String? description;
  String? avatar;

  GuildInviteModel({
    this.id,
    this.name,
    this.description,
    this.avatar,
  });

  GuildInviteModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    avatar = json['avatar'];
  }
}
