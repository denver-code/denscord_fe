import 'package:denscord_fe/app/models/channel_response_model.dart';
import 'package:denscord_fe/app/models/guild_response_model.dart';
import 'package:denscord_fe/app/models/member_model.dart';
import 'package:denscord_fe/app/models/message_model.dart';
import 'package:denscord_fe/app/models/user_model.dart';
import 'package:denscord_fe/app/utils/api.dart';
import 'package:denscord_fe/app/utils/authentication_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin StateController {
  Rx<GuildModel> activeGuild = GuildModel().obs;
  Rx<ChannelModel> activeChannel = ChannelModel().obs;
  RxList<GuildModel> guilds = <GuildModel>[].obs;
  RxList<ChannelModel> channels = <ChannelModel>[].obs;
  RxList<MemberModel> members = <MemberModel>[].obs;
  var channel;
  TextEditingController messageController = TextEditingController();
  TextEditingController channelNameController = TextEditingController();
  TextEditingController channelDescriptionController = TextEditingController();
  TextEditingController guildNameController = TextEditingController();
  TextEditingController guildDescriptionController = TextEditingController();
  RxBool isPrivate = false.obs;
  RxList<MessageModel> messages = <MessageModel>[].obs;
  ScrollController messagerListController = ScrollController();
  var tabIndex = 0.obs;
  final APIService apiService = APIService();
  final AuthenticationManager authManager = Get.put(AuthenticationManager());
  late String token;
  Rx<UserModel> me = UserModel().obs;
}
