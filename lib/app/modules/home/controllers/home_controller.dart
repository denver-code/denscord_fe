import 'dart:convert';

import 'package:denscord_fe/app/components/profile_button.dart';
import 'package:denscord_fe/app/models/channel_response_model.dart';
import 'package:denscord_fe/app/models/guild_response_model.dart';
import 'package:denscord_fe/app/utils/api_endpoints.dart';
import 'package:denscord_fe/app/utils/authentication_manager.dart';
import 'package:denscord_fe/app/utils/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController with CacheManager {
  var tabIndex = 0.obs;
  final AuthenticationManager _authManager = Get.put(AuthenticationManager());
  RxList<GuildModel> guilds = <GuildModel>[].obs;
  RxList<ChannelModel> channels = <ChannelModel>[].obs;

  late String token;

  Rx<GuildModel> activeGuild = GuildModel().obs;
  Rx<ChannelModel> activeChannel = ChannelModel().obs;

  void setActiveGuild(String guildId) {
    if (activeGuild.value.id == guildId) {
      return;
    }
    activeGuild.value = guilds.firstWhere((guild) => guild.id == guildId);
    activeGuild.refresh();
    fetchChannels();
  }

  void setActiveChannel(String channelId) {
    if (activeChannel.value.id == channelId) {
      return;
    }
    activeChannel.value =
        channels.firstWhere((channel) => channel.id == channelId);
    activeChannel.refresh();
  }

  fetchChannels() async {
    var response = await http.get(
      Endpoints.getChannels(activeGuild.value.id.toString()),
      headers: {"Authorisation": token},
    );
    channels.clear();
    if (response.statusCode == 200) {
      for (var channel in json.decode(response.body)) {
        channels.add(ChannelModel.fromJson(channel));
      }
      return;
    }
    return null;
  }

  void fetchGuilds() async {
    var response = await http.get(
      Endpoints.getGuilds,
      headers: {"Authorisation": token},
    );
    if (response.statusCode == 200) {
      // print(json.decode(response.body));
      // List<GuildModel> guildsList = [];
      for (var guild in json.decode(response.body)) {
        guilds.add(GuildModel.fromJson(guild));
      }
      return;
    }
    return null;
  }

  @override
  void onInit() {
    super.onInit();
    token = getToken()!;
    if (token == null) {
      return logout();
    }

    fetchGuilds();
  }

  Map user = {
    "id": "sdiuhfhsfisudfoise",
    "username": "denver-code",
    "avatar": "assets/images/avatar.png",
    "email": "csigorek@gmail.com",
    "is_nitro": true,
  };

  void logout() {
    _authManager.logOut();
    Get.offAllNamed("/heading");
  }

  List<Widget> accountSettingsButtons = [
    ProfileButton(
      text: "My Security",
      status: "active",
      icon: Icons.shield_outlined,
      onPressed: () {},
    ),
    ProfileButton(
      text: "Edit Profile",
      status: "inactive",
      icon: Icons.edit_outlined,
      onPressed: () {},
    ),
    ProfileButton(
      text: "Your Hub",
      status: "incative",
      icon: Icons.smartphone_rounded,
      onPressed: () {},
    ),
    ProfileButton(
      text: "Dev tools",
      status: "active",
      icon: Icons.donut_large_rounded,
      onPressed: () {},
    ),
  ];

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }
}
