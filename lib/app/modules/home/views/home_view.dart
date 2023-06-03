import 'package:denscord_fe/app/modules/home/views/guilds_view.dart';
import 'package:denscord_fe/app/modules/home/views/profile_view.dart';
import 'package:denscord_fe/theme.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  final TextStyle unselectedLabelStyle = TextStyle(
      color: Colors.white.withOpacity(0.5),
      fontWeight: FontWeight.w500,
      fontSize: 12);

  final TextStyle selectedLabelStyle = const TextStyle(
      color: Colors.white, fontWeight: FontWeight.w500, fontSize: 12);

  buildBottomNavigationMenu(context, landingPageController) {
    return Obx(() => BottomNavigationBar(
          showUnselectedLabels: false,
          showSelectedLabels: false,
          onTap: landingPageController.changeTabIndex,
          currentIndex: landingPageController.tabIndex.value,
          backgroundColor: DenscordColors.buttonSecondary,
          unselectedItemColor: Colors.white.withOpacity(0.5),
          selectedItemColor: Colors.white,
          unselectedLabelStyle: unselectedLabelStyle,
          selectedLabelStyle: selectedLabelStyle,
          items: [
            BottomNavigationBarItem(
              icon: Image.asset("assets/images/obs_dark.png", width: 25.0),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: ClipRRect(
                  borderRadius: BorderRadius.circular(25.0),
                  child: Image.asset(landingPageController.user["avatar"],
                      width: 30.0)),
              label: 'Profile',
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());
    return Scaffold(
      bottomNavigationBar: buildBottomNavigationMenu(context, homeController),
      body: Obx(() => IndexedStack(
            index: homeController.tabIndex.value,
            children: [GuildView(), ProfileView()],
          )),
    );
  }
}
