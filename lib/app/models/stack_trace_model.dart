class StackTraceMessageModel {
  String messageId;
  String guildId;
  String channelId;

  StackTraceMessageModel({
    required this.messageId,
    required this.guildId,
    required this.channelId,
  });

  Map<String, dynamic> toJson() {
    return {
      "message_id": messageId,
      "guild_id": guildId,
      "channel_id": channelId,
    };
  }
}
