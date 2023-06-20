import 'dart:convert';

import 'package:denscord_fe/app/components/profile_button.dart';
import 'package:denscord_fe/app/models/channel_response_model.dart';
import 'package:denscord_fe/app/models/guild_response_model.dart';
import 'package:denscord_fe/app/models/member_model.dart';
import 'package:denscord_fe/app/models/message_model.dart';
import 'package:denscord_fe/app/utils/api_endpoints.dart';
import 'package:denscord_fe/app/utils/authentication_manager.dart';
import 'package:denscord_fe/app/utils/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class HomeController extends GetxController with CacheManager {
  // late final WebSocketChannel? channel;
  var channel;

  var tabIndex = 0.obs;
  final AuthenticationManager _authManager = Get.put(AuthenticationManager());
  RxList<GuildModel> guilds = <GuildModel>[].obs;
  RxList<ChannelModel> channels = <ChannelModel>[].obs;
  RxList<MemberModel> members = <MemberModel>[].obs;
  RxList<MessageModel> messages = <MessageModel>[].obs;

  TextEditingController messageController = TextEditingController();
  ScrollController messagerListController = ScrollController();

  late String token;

  Rx<GuildModel> activeGuild = GuildModel().obs;
  Rx<ChannelModel> activeChannel = ChannelModel().obs;

  void sendMessage() {
    if (messageController.text.isNotEmpty) {
      if (channel == null) {
        return;
      }
      channel!.sink.add(json.encode({"message": messageController.text}));
      messageController.clear();
      if (messages.length > 9) {
        messagerListController.animateTo(
          messagerListController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut,
        );
      }
    }
  }

  void setActiveGuild(String guildId) {
    if (channel != null) {
      channel!.sink.close();
    }
    if (activeGuild.value.id == guildId) {
      return;
    }
    activeGuild.value = guilds.firstWhere((guild) => guild.id == guildId);
    activeGuild.refresh();
    fetchChannels();
    fetchMembers();
  }

  Future fetchMessages() async {
    var request = await http.get(
      Endpoints.getMessages(
          activeGuild.value.id.toString(), activeChannel.value.id.toString()),
      headers: {"Authorisation": token},
    );
    if (request.statusCode == 200) {
      messages.clear();
      for (var message in json.decode(request.body)) {
        messages.add(MessageModel.fromJson(message));
      }
      messages.sort((a, b) => a.createdAt!.compareTo(b.createdAt.toString()));

      messages = messages.reversed.toList().obs;
    }
  }

  void fetchMembers() async {
    var r1 = await http.get(
      Endpoints.getMembers(activeGuild.value.id.toString()),
      headers: {"Authorisation": token},
    );
    List<String> membersIdList = [];
    if (r1.statusCode == 200) {
      for (var member in json.decode(r1.body)) {
        membersIdList.add(member);
      }
    } else {
      return;
    }
    // ignore: no_leading_underscores_for_local_identifiers
    List<MemberModel> _members = <MemberModel>[];
    for (var memberId in membersIdList) {
      var r2 = await http.get(
        Endpoints.getMember(memberId.toString()),
        headers: {"Authorisation": token},
      );
      if (r2.statusCode == 200) {
        _members.add(MemberModel.fromJson(json.decode(r2.body)));
      }
    }
    members.clear();
    members.addAll(_members);
  }

  void setActiveChannel(String channelId) {
    if (channel != null) {
      channel!.sink.close();
    }
    if (activeChannel.value.id == channelId) {
      return;
    }
    activeChannel.value =
        channels.firstWhere((channel) => channel.id == channelId);
    activeChannel.refresh();
    channels.refresh();
    fetchMessages();
    channel = IOWebSocketChannel.connect(
        Uri.parse(
            'ws://${Endpoints.apiUrl}/ws/${activeGuild.value.id}/${activeChannel.value.id}'),
        headers: {"Authorisation": token});
    channel.stream.listen((event) {
      var newMessage = json.decode(event);
      newMessage['created_at'] = newMessage['created_at']['\$date'];
      messages.insert(0, MessageModel.fromJson(newMessage));
      if (messages.length > 9) {
        messagerListController.animateTo(
          messagerListController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future fetchChannels() async {
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

  Future fetchGuilds() async {
    var response = await http.get(
      Endpoints.getGuilds,
      headers: {"Authorisation": token},
    );
    guilds.clear();
    if (response.statusCode == 200) {
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
    // ignore: unnecessary_null_comparison
    if (token == null) {
      return logout();
    }

    fetchGuilds().then(
      (value) {
        if (guilds.isNotEmpty) {
          setActiveGuild(guilds[0].id.toString());
        }

        fetchChannels().then((value) {
          if (channels.isNotEmpty) {
            setActiveChannel(channels[0].id.toString());
          }
        });
      },
    );
  }

  @override
  void dispose() {
    if (channel != null) {
      channel!.sink.close();
    }
    super.dispose();
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
