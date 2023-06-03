import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class GuildView extends GetView<HomeController> {
  GuildView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());
    return Scaffold(
        body: Center(
      child: Text(
        'GuildView is working',
        style: TextStyle(fontSize: 20),
      ),
    ));
  }
}
