class ChannelModel {
  String? id;
  String? name;
  String? description;
  String? guildId;

  ChannelModel({
    this.id,
    this.name,
    this.description,
    this.guildId,
  });

  ChannelModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    guildId = json['guild_id'];
  }
}
