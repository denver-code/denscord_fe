import 'package:denscord_fe/app/components/profile_button.dart';
import 'package:denscord_fe/app/utils/authentication_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var tabIndex = 0.obs;
  late final AuthenticationManager _authManager;

  @override
  void onInit() {
    super.onInit();
    _authManager = Get.find();
  }

  Map user = {
    "id": "sdiuhfhsfisudfoise",
    "username": "denver-code",
    "avatar": "assets/images/avatar.png",
    "email": "csigorek@gmail.com",
    "is_nitro": true,
  };

  void logout() {
    _authManager.logOut();
    Get.offAllNamed("/heading");
  }

  List<Widget> accountSettingsButtons = [
    ProfileButton(
      text: "My Security",
      status: "active",
      icon: Icons.shield_outlined,
      onPressed: () {},
    ),
    ProfileButton(
      text: "Edit Profile",
      status: "inactive",
      icon: Icons.edit_outlined,
      onPressed: () {},
    ),
    ProfileButton(
      text: "Your Hub",
      status: "incative",
      icon: Icons.smartphone_rounded,
      onPressed: () {},
    ),
    ProfileButton(
      text: "Dev tools",
      status: "active",
      icon: Icons.donut_large_rounded,
      onPressed: () {},
    ),
  ];

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }
}
