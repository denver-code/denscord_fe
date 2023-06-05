import 'package:denscord_fe/config.dart';

class Endpoints {
  static const String apiUrl = "http://localhost:8000/api";

  static const String signup = "$apiUrl/public/authorisation/signup";
  static const String login = "$apiUrl/public/authorisation/login";
}
