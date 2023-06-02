import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RegExp get emailRegex => RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  void validateAndSave() {
    final FormState form = formKey.currentState!;

    if (form.validate()) {
      login(emailController.text, passwordController.text);
    }
  }

  void login(String email, String password) {
    Get.toNamed("/home");
  }
}
