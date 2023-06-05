import 'dart:convert';

import 'package:denscord_fe/app/models/login_request_model.dart';
import 'package:denscord_fe/app/models/login_response_model.dart';
import 'package:denscord_fe/app/models/register_request_model.dart';
import 'package:denscord_fe/app/utils/api_endpoints.dart';
import 'package:denscord_fe/app/utils/authentication_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RegistrationController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RegExp get emailRegex => RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  final AuthenticationManager _authManager = Get.put(AuthenticationManager());

  get json => null;

  void validateAndSave() {
    final FormState form = formKey.currentState!;

    if (form.validate()) {
      register(emailController.text, passwordController.text,
          usernameController.text);
    }
  }

  Future<String?> sendRegistrationRequest(RegisterRequestModel body) async {
    var response = await http.post(Endpoints.signup,
        headers: {"Content-Type": "application/json"}, body: body.export());
    if (response.statusCode == 200) {
      return "success";
    }
    return jsonDecode(response.body)["detail"];
  }

  void register(String email, String password, String username) {
    RegisterRequestModel body = RegisterRequestModel(
        email: email, password: password, username: username);
    sendRegistrationRequest(body).then((String? value) {
      if (value! == "success") {
        Get.snackbar("Success", "Welcome! Now you can authorise!",
            colorText: Colors.white, snackPosition: SnackPosition.BOTTOM);
        Get.toNamed("/authorisation");
      } else {
        Get.snackbar("Error", value.toString(),
            colorText: Colors.white, snackPosition: SnackPosition.BOTTOM);
      }
    });
  }
}
