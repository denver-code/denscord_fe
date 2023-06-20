import 'package:denscord_fe/app/models/channel_response_model.dart';
import 'package:denscord_fe/app/models/guild_response_model.dart';
import 'package:denscord_fe/app/models/member_model.dart';
import 'package:get/get.dart';

mixin StateController {
  Rx<GuildModel> activeGuild = GuildModel().obs;
  Rx<ChannelModel> activeChannel = ChannelModel().obs;
  RxList<GuildModel> guilds = <GuildModel>[].obs;
  RxList<ChannelModel> channels = <ChannelModel>[].obs;
  RxList<MemberModel> members = <MemberModel>[].obs;
}
