class Endpoints {
  static const String apiUrl = "192.168.1.2:8180";

  static Uri signup = Uri.http(apiUrl, '/api/public/authorisation/signup');
  static Uri login = Uri.http(apiUrl, '/api/public/authorisation/signin');

  static Uri getGuilds = Uri.http(apiUrl, '/api/private/guild/');
  static Uri getChannels(String guildId) =>
      Uri.http(apiUrl, '/api/private/guild/$guildId/channel/');
  static Uri getMembers(String guildId) =>
      Uri.http(apiUrl, '/api/private/guild/$guildId/members');
  static Uri getMember(String memberId) =>
      Uri.http(apiUrl, '/api/public/profile/$memberId/');
  static Uri getMessages(String guildId, String channelId) => Uri.http(
      apiUrl, '/api/private/guild/$guildId/channel/$channelId/message/');
  static Uri getBulkMembersRoute = Uri.http(apiUrl, '/api/public/profile/bulk');
  static Uri getMyProfileRoute = Uri.http(apiUrl, '/api/private/profile/');
  static Uri createChannelRoute(String guildId) =>
      Uri.http(apiUrl, '/api/private/guild/$guildId/channel/');
  static Uri createGuildRoute = Uri.http(apiUrl, '/api/private/guild/');
  static Uri leaveGuildRoute(String guildId) =>
      Uri.http(apiUrl, '/api/private/guild/$guildId/leave');
  static Uri joinGuildRoute(String guildId, String guildKey) =>
      Uri.http(apiUrl, '/api/private/guild/$guildId/join/$guildKey');
  static Uri deleteGuildRoute(String guildId) =>
      Uri.http(apiUrl, '/api/private/guild/$guildId');
  static Uri deleteChannelRoute(String guildId, String channelId) =>
      Uri.http(apiUrl, '/api/private/guild/$guildId/channel/$channelId');
  static Uri deleteMessageRoute(
          String guildId, String channelId, String messageId) =>
      Uri.http(apiUrl,
          '/api/private/guild/$guildId/channel/$channelId/message/$messageId');
  static Uri sendInviteRequestRoute = Uri.http(apiUrl, '/api/private/social/');
  static Uri getInvitesRoute = Uri.http(apiUrl, '/api/private/social/');
  static Uri acceptInviteRoute(String inviteId) =>
      Uri.http(apiUrl, '/api/private/social/$inviteId/accept');
  static Uri declineInviteRoute(String inviteId) =>
      Uri.http(apiUrl, '/api/private/social/$inviteId/decline');
  static Uri getUserRoute(String query) =>
      Uri.http(apiUrl, '/api/public/profile/$query');
}
