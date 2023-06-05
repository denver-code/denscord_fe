import 'package:denscord_fe/app/modules/heading/views/heading_view.dart';
import 'package:denscord_fe/app/modules/home/views/home_view.dart';
import 'package:denscord_fe/app/utils/authentication_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoard extends StatelessWidget {
  const OnBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthenticationManager authManager = Get.find();

    return Obx(() {
      return authManager.isLogged.value ? HomeView() : const HeadingView();
    });
  }
}
