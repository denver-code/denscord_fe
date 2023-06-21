import 'dart:convert';

import 'package:denscord_fe/app/components/profile_button.dart';
import 'package:denscord_fe/app/models/channel_response_model.dart';
import 'package:denscord_fe/app/models/message_model.dart';
import 'package:denscord_fe/app/modules/home/controllers/state_controller.dart';
import 'package:denscord_fe/app/utils/api_endpoints.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/io.dart';

class HomeController extends GetxController with StateController {
  createChannel() async {
    String description = channelDescriptionController.text.isEmpty
        ? "No description"
        : channelDescriptionController.text;
    apiService
        .createNewChannel(
            guildId: activeGuild.value.id.toString(),
            name: channelNameController.text,
            description: description)
        .then((value) {
      channelDescriptionController.clear();
      channelNameController.clear();
      switch (value) {
        case true:
          Get.back();
          fetchChannels().then((value) {
            Get.snackbar("Success", "Channel created",
                colorText: Colors.white, snackPosition: SnackPosition.BOTTOM);
          });
          channels.refresh();
          break;
        case false:
          Get.snackbar("Error", "Something went wrong",
              colorText: Colors.white, snackPosition: SnackPosition.BOTTOM);
          break;
      }
    });
  }

  leaveGuild() async {
    apiService
        .leaveGuild(guildId: activeGuild.value.id.toString())
        .then((value) {
      switch (value) {
        case true:
          Get.snackbar("Success", "You left the guild,",
              colorText: Colors.white, snackPosition: SnackPosition.BOTTOM);
          fetchGuilds();
          fetchChannels();
          break;
        case false:
          Get.snackbar("Error", "Something went wrong",
              colorText: Colors.white, snackPosition: SnackPosition.BOTTOM);
      }
    });
  }

  sendMessage() {
    if (messageController.text.isNotEmpty) {
      if (channel == null) {
        return;
      }
      channel!.sink.add(json.encode({"message": messageController.text}));
      messageController.clear();
    }
  }

  fetchMessages() async {
    apiService
        .getMessages(
      guildId: activeGuild.value.id.toString(),
      channelId: activeChannel.value.id.toString(),
    )
        .then((value) {
      messages.clear();
      messages.addAll(value);
      messages.sort((a, b) => a.createdAt!.compareTo(b.createdAt.toString()));
      messages = messages.reversed.toList().obs;
      messages.refresh();
    });
  }

  fetchMembers() async {
    var membersIdList = await apiService.getMembersId(
      guildId: activeGuild.value.id.toString(),
    );

    members.clear();

    var membersList = await apiService.getBulkMembers(
      membersId: membersIdList,
    );

    members.addAll(membersList);
    members.refresh();
  }

  Future fetchChannels() async {
    channels.clear();
    apiService
        .getChannels(
      guildId: activeGuild.value.id.toString(),
    )
        .then((value) {
      if (value.isEmpty) {
        return;
      }

      channels.addAll(value);
      channels.refresh();
      setActiveChannel(channels.first.id.toString());
    });
  }

  Future fetchGuilds() async {
    guilds.clear();
    apiService.getGuilds().then((value) {
      if (value.isEmpty) {
        return;
      }

      guilds.addAll(value);
      guilds.refresh();
      setActiveGuild(guilds.first.id.toString());
    });
  }

  void setActiveChannel(String channelId) {
    if (activeChannel.value.id == channelId) {
      return;
    }
    if (channel != null) {
      channel!.sink.close();
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
      messages.refresh();
    });
  }

  setActiveGuild(String guildId, {bool needFetchChannels = true}) {
    if (activeGuild.value.id == guildId) {
      return;
    }
    if (channel != null) {
      channel!.sink.close();
    }
    activeGuild.value = guilds.firstWhere((guild) => guild.id == guildId);
    activeGuild.refresh();
    if (needFetchChannels) {
      fetchChannels().then((value) {
        messages.clear();
        messages.refresh();
        if (channels.isNotEmpty) {
          setActiveChannel(channels.first.id.toString());
        } else {
          activeChannel.value = ChannelModel();
          activeChannel.refresh();
        }
      });
    }
    fetchMembers();
  }

  @override
  void onInit() async {
    super.onInit();
    token = apiService.getToken()!;
    await apiService.getMyProfile().then((value) {
      me.value = value;
      me.refresh();
    });
    fetchGuilds();
    fetchChannels();
  }

  @override
  void dispose() {
    if (channel != null) {
      channel!.sink.close();
    }
    super.dispose();
  }

  void logout() {
    authManager.logOut();
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
