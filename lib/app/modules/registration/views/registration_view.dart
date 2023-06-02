import 'package:denscord_fe/app/components/back_button.dart';
import 'package:denscord_fe/app/components/button.dart';
import 'package:denscord_fe/app/components/input_field.dart';
import 'package:denscord_fe/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import '../controllers/registration_controller.dart';

class RegistrationView extends GetView<RegistrationController> {
  const RegistrationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    RegistrationController controller = Get.put(RegistrationController());
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 17.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: Get.height / 20,
              ),
              const LeadingBackButton(),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: Get.height / 50,
                  ),
                  const Text("Registration",
                      style: TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.w800,
                          fontFamily: "FixelDisplay")),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "We're so excited to see you!",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: DenscordColors.textSecondary),
                    // textAlign: TextAlign.center,
                  ),
                ],
              ),
              SizedBox(
                height: Get.height / 6.8,
              ),
              Column(
                children: [
                  Form(
                      // autovalidateMode: AutovalidateMode.onUserInteraction,
                      key: controller.formKey,
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "PICK A USERNAME",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: DenscordColors.textSecondary),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          InputFormWidget(
                            text: "What should everyone call you?",
                            controller: controller.usernameController,
                            isPassword: false,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Username can\'t be empty!';
                              }
                              return null;
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(RegExp(r"\s"))
                            ],
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "You can always change this later!",
                              style: TextStyle(
                                color: DenscordColors.textSecondary,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "ACCOUNT INFORMATION",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: DenscordColors.textSecondary),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Column(
                            children: [
                              InputFormWidget(
                                text: "Email",
                                controller: controller.emailController,
                                isPassword: false,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Email can\'t be empty!';
                                  } else if (!controller.emailRegex
                                      .hasMatch(value)) {
                                    return 'Email are invalid!';
                                  }
                                  return null;
                                },
                                inputFormatters: [
                                  FilteringTextInputFormatter.deny(
                                      RegExp(r"\s"))
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              InputFormWidget(
                                text: "Password",
                                controller: controller.passwordController,
                                isPassword: true,
                                maxLenght: 72,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Password can\'t be empty!';
                                  } else if (value.length < 6) {
                                    return 'Password must be at least 6 characters long!';
                                  }
                                  return null;
                                },
                                inputFormatters: [
                                  FilteringTextInputFormatter.deny(
                                      RegExp(r"\s"))
                                ],
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Password must be 6-72 characters",
                                  style: TextStyle(
                                    color: DenscordColors.textSecondary,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          BigButtonWidget(
                            text: "Register",
                            height: Get.height / 19,
                            onPressed: controller.validateAndSave,
                            backgroundColor: DenscordColors.buttonPrimary,
                          ),
                        ],
                      ))
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
