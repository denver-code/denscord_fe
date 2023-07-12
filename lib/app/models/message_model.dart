class MessageModel {
  MessageComponent? message;
  String? createdAt;

  MessageModel({
    this.message,
    this.createdAt,
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    message = MessageComponent.fromJson(json['message']);
    createdAt = json['created_at'];
  }
}

class MessageComponent {
  String? id;
  ChatFrom? chat;
  FromUser? from;
  String? text;

  MessageComponent({
    this.id,
    this.chat,
    this.from,
    this.text,
  });

  MessageComponent.fromJson(Map<String, dynamic> json) {
    id = json['message_id'];
    chat = ChatFrom.fromJson(json['chat']);
    from = FromUser.fromJson(json['from_user']);
    text = json['text'];
  }
}

class ChatFrom {
  String? channelId;
  String? guildId;

  ChatFrom({
    this.channelId,
    this.guildId,
  });

  ChatFrom.fromJson(Map<String, dynamic> json) {
    channelId = json['channel_id'];
    guildId = json['guild_id'];
  }
}

class FromUser {
  String? id;
  bool? isBot;
  String? username;
  String? avatar;

  FromUser({
    this.id,
    this.isBot = false,
    this.username,
    this.avatar,
  });

  FromUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isBot = json['is_bot'];
    username = json['username'];
    avatar = json['avatar'];
  }
}
