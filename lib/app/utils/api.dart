import 'dart:convert';

import 'package:denscord_fe/app/models/channel_response_model.dart';
import 'package:denscord_fe/app/models/guild_response_model.dart';
import 'package:denscord_fe/app/models/member_model.dart';
import 'package:denscord_fe/app/models/message_model.dart';
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
}
