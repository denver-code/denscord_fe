import 'dart:convert';

import 'package:denscord_fe/app/models/login_response_model.dart';
import 'package:denscord_fe/app/modules/registration/controllers/registration_controller.dart';
import 'package:denscord_fe/app/utils/api_endpoints.dart';
import 'package:denscord_fe/app/utils/authentication_manager.dart';
import 'package:http/http.dart' as http;
import 'package:denscord_fe/app/models/login_request_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthorisationController extends GetxController {
  final registrationController = Get.put(RegistrationController());

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RegExp get emailRegex => RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  final AuthenticationManager _authManager = Get.put(AuthenticationManager());

  void validateAndSave() {
    final FormState form = formKey.currentState!;

    if (form.validate()) {
      login(emailController.text, passwordController.text);
    }
  }

  @override
  void onInit() {
    super.onInit();
    if (registrationController.emailController.text.isNotEmpty) {
      emailController.text = registrationController.emailController.text;
    }
  }

  Future<LoginResponseModel?> sendAuthorisationRequest(
      LoginRequestModel body) async {
    var response = await http.post(Endpoints.login,
        headers: {"Content-Type": "application/json"}, body: body.export());
    if (response.statusCode == 200) {
      return LoginResponseModel.fromJson(json.decode(response.body));
    }
    return null;
  }

  void login(String email, String password) {
    LoginRequestModel body =
        LoginRequestModel(email: email, password: password);
    sendAuthorisationRequest(body).then((value) {
      if (value != null) {
        _authManager.login(value.token);
        Get.offAllNamed("/home");
      } else {
        Get.snackbar("Error", "Wrong email or password",
            colorText: Colors.white, snackPosition: SnackPosition.BOTTOM);
      }
    });
  }
}
