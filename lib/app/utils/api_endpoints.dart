class Endpoints {
  static const String apiUrl = "192.168.1.2:8180";

  static Uri signup = Uri.http(apiUrl, '/api/public/authorisation/signup');
  static Uri login = Uri.http(apiUrl, '/api/public/authorisation/signin');
}
