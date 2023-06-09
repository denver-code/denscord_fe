import 'dart:convert';

import 'package:denscord_fe/app/models/channel_response_model.dart';
import 'package:denscord_fe/app/models/guild_response_model.dart';
import 'package:denscord_fe/app/models/invite_request_model.dart';
import 'package:denscord_fe/app/models/member_model.dart';
import 'package:denscord_fe/app/models/message_model.dart';
import 'package:denscord_fe/app/models/user_model.dart';
import 'package:denscord_fe/app/utils/api_endpoints.dart';
import 'package:denscord_fe/app/utils/cache_manager.dart';
import 'package:http/http.dart' as http;

class APIService extends Endpoints with CacheManager {
  Future<List<MessageModel>> getMessages({
    required String guildId,
    required String channelId,
  }) async {
    var request = await http.get(
      Endpoints.getMessages(guildId, channelId),
      headers: {"Authorisation": getToken().toString()},
    );
    List<MessageModel> messages = <MessageModel>[];
    if (request.statusCode == 200) {
      for (var message in json.decode(request.body)) {
        messages.add(MessageModel.fromJson(message));
      }
      return messages;
    } else {
      return [];
    }
  }

  Future<List<String>> getMembersId({
    required String guildId,
  }) async {
    var request = await http.get(
      Endpoints.getMembers(guildId),
      headers: {"Authorisation": getToken().toString()},
    );
    List<String> members = <String>[];
    if (request.statusCode == 200) {
      for (var memberId in json.decode(request.body)) {
        members.add(memberId);
      }
      return members;
    } else {
      return [];
    }
  }

  Future<MemberModel?> getMember({
    required String memberId,
  }) async {
    var request = await http.get(
      Endpoints.getMember(memberId),
      headers: {"Authorisation": getToken().toString()},
    );
    if (request.statusCode == 200) {
      return MemberModel.fromJson(json.decode(request.body));
    } else {
      return null;
    }
  }

  Future<List<MemberModel>> getBulkMembers({
    required List<String> membersId,
  }) async {
    List<MemberModel> members = <MemberModel>[];
    var request = await http.post(
      Endpoints.getBulkMembersRoute,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({"users": membersId}),
    );
    if (request.statusCode == 200) {
      for (var member in json.decode(request.body)) {
        members.add(MemberModel.fromJson(member));
      }
      return members;
    } else {
      return [];
    }
  }

  Future<List<ChannelModel>> getChannels({
    required String guildId,
  }) async {
    var request = await http.get(
      Endpoints.getChannels(guildId),
      headers: {"Authorisation": getToken().toString()},
    );
    List<ChannelModel> channels = <ChannelModel>[];
    if (request.statusCode == 200) {
      for (var channel in json.decode(request.body)) {
        channels.add(ChannelModel.fromJson(channel));
      }
      return channels;
    } else {
      return [];
    }
  }

  Future<List<GuildModel>> getGuilds() async {
    var request = await http.get(
      Endpoints.getGuilds,
      headers: {"Authorisation": getToken().toString()},
    );
    List<GuildModel> guilds = <GuildModel>[];
    if (request.statusCode == 200) {
      for (var guild in json.decode(request.body)) {
        guilds.add(GuildModel.fromJson(guild));
      }
      return guilds;
    } else {
      return [];
    }
  }

  Future<UserModel> getMyProfile() async {
    var request = await http.get(
      Endpoints.getMyProfileRoute,
      headers: {"Authorisation": getToken().toString()},
    );
    if (request.statusCode == 200) {
      return UserModel.fromJson(json.decode(request.body));
    } else {
      return UserModel();
    }
  }

  Future<bool> createNewChannel({
    required String guildId,
    required String name,
    required String description,
  }) async {
    var request = await http.post(
      Endpoints.createChannelRoute(guildId),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorisation": getToken().toString(),
      },
      body: json.encode({
        "name": name,
        "description": description,
      }),
    );
    if (request.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> createNewGuild({
    required String name,
    required String description,
    required bool isPrivate,
  }) async {
    var request = await http.post(
      Endpoints.createGuildRoute,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorisation": getToken().toString(),
      },
      body: json.encode({
        "name": name,
        "description": description,
        "is_private": isPrivate,
      }),
    );
    if (request.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> leaveGuild({
    required String guildId,
  }) async {
    var request = await http.get(
      Endpoints.leaveGuildRoute(guildId),
      headers: {"Authorisation": getToken().toString()},
    );
    if (request.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<String> joinGuild({
    required String guildId,
    String guildKey = "",
  }) async {
    var request = await http.get(
      Endpoints.joinGuildRoute(guildId, guildKey),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorisation": getToken().toString(),
      },
    );
    if (request.statusCode == 200) {
      return "Joined";
    } else {
      return json.decode(request.body)["detail"];
    }
  }

  Future<bool> deleteGuild({
    required String guildId,
  }) async {
    var request = await http.delete(
      Endpoints.deleteGuildRoute(guildId),
      headers: {"Authorisation": getToken().toString()},
    );
    if (request.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteChannel({
    required String guildId,
    required String channelId,
  }) async {
    var request = await http.delete(
      Endpoints.deleteChannelRoute(guildId, channelId),
      headers: {"Authorisation": getToken().toString()},
    );
    if (request.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteMessage({
    required String guildId,
    required String channelId,
    required String messageId,
  }) async {
    var request = await http.delete(
      Endpoints.deleteMessageRoute(guildId, channelId, messageId),
      headers: {"Authorisation": getToken().toString()},
    );
    if (request.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<String> sendInvite({
    required String guildId,
    required String recipientId,
  }) async {
    var request = await http.post(
      Endpoints.sendInviteRequestRoute,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorisation": getToken().toString(),
      },
      body: json.encode({
        "recipient_id": recipientId,
        "guild_id": guildId,
      }),
    );
    if (request.statusCode == 200) {
      return "sent";
    } else {
      return json.decode(request.body)["detail"];
    }
  }

  Future<bool> acceptInvite({
    required String inviteId,
  }) async {
    var request = await http.get(
      Endpoints.acceptInviteRoute(inviteId),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorisation": getToken().toString(),
      },
    );
    if (request.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> declineInvite({
    required String inviteId,
  }) async {
    var request = await http.get(
      Endpoints.declineInviteRoute(inviteId),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorisation": getToken().toString(),
      },
    );
    if (request.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<InviteRequestModel>?> getMyInviteRequests() async {
    var request = await http.get(
      Endpoints.getInvitesRoute,
      headers: {"Authorisation": getToken().toString()},
    );
    if (request.statusCode == 200) {
      List<InviteRequestModel> inviteRequests = <InviteRequestModel>[];
      for (var inviteRequest in json.decode(request.body)) {
        inviteRequests.add(InviteRequestModel.fromJson(inviteRequest));
      }
      return inviteRequests;
    } else {
      return null;
    }
  }

  Future<String?> getIdByUsername({
    required String username,
  }) async {
    var request = await http.get(
      Endpoints.getUserRoute(username),
      headers: {"Authorisation": getToken().toString()},
    );
    if (request.statusCode == 200) {
      return json.decode(request.body)["id"];
    } else {
      return null;
    }
  }
}
