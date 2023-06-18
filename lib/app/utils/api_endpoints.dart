class Endpoints {
  static const String apiUrl = "192.168.1.2:8180";

  static Uri signup = Uri.http(apiUrl, '/api/public/authorisation/signup');
  static Uri login = Uri.http(apiUrl, '/api/public/authorisation/signin');

  static Uri getGuilds = Uri.http(apiUrl, '/api/private/guild/');
  static Uri getChannels(String guildId) =>
      Uri.http(apiUrl, '/api/private/guild/$guildId/channel/');
  static Uri getMembers(String guildId) =>
      Uri.http(apiUrl, '/api/private/guild/$guildId/members/');
  static Uri getMember(String memberId) =>
      Uri.http(apiUrl, '/api/public/profile/$memberId/');
  static Uri getMessages(String guildId, String channelId) => Uri.http(
      apiUrl, '/api/private/guild/$guildId/channel/$channelId/message/');
}
