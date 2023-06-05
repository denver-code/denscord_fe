import 'dart:convert';
import 'package:denscord_fe/app/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:denscord_fe/app/models/login_request_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthorisationController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RegExp get emailRegex => RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  void validateAndSave() {
    final FormState form = formKey.currentState!;

    if (form.validate()) {
      login(emailController.text, passwordController.text);
    }
  }

  void sendAuthorisationRequest(LoginRequestModel body) async {
    var url = Uri.http('localhost:8000', '/api/public/authorisation/signin');
    print(url);
    var response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body.export());
    print("${response.statusCode}");
    print("${response.body}");
    // return response;
  }

  void login(String email, String password) {
    LoginRequestModel body =
        LoginRequestModel(email: email, password: password);
    var r = sendAuthorisationRequest(body);
    // Get.offAllNamed("/home");
  }
}
