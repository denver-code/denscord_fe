import 'package:denscord_fe/app/components/not_implemented.dart';
import 'package:flutter/material.dart';
import 'package:overlapping_panels/overlapping_panels.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class GuildView extends GetView<HomeController> {
  GuildView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());
    return NotImplementedScreen();
  }
}
