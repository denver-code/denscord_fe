class GuildModel {
  String? id;
  String? name;
  String? description;
  String? avatar;
  String? owner;
  int? membersCount;

  GuildModel({
    this.id,
    this.name,
    this.description,
    this.avatar,
    this.owner,
    this.membersCount,
  });

  GuildModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    avatar = json['avatar'];
    owner = json['owner'];
    membersCount = json['members_count'];
  }
}
