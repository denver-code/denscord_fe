import 'package:cached_network_image/cached_network_image.dart';
import 'package:denscord_fe/app/modules/home/views/guilds_view.dart';
import 'package:denscord_fe/app/modules/home/views/members_right_view.dart';
import 'package:denscord_fe/app/modules/home/views/messager_view.dart';
import 'package:denscord_fe/app/modules/home/views/profile_view.dart';
import 'package:denscord_fe/theme.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:overlapping_panels/overlapping_panels.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  final TextStyle unselectedLabelStyle = TextStyle(
      color: Colors.white.withOpacity(0.5),
      fontWeight: FontWeight.w500,
      fontSize: 12);

  final TextStyle selectedLabelStyle = const TextStyle(
      color: Colors.white, fontWeight: FontWeight.w500, fontSize: 12);

  final RxBool isFooter = false.obs;

  buildBottomNavigationMenu(context, landingPageController) {
    return SizedBox(
      height: Get.height / 8.5,
      child: BottomNavigationBar(
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
            icon: Obx(
              () => CachedNetworkImage(
                imageUrl: landingPageController.me.value.avatar ??
                    "https://www.gravatar.com/avatar/0bc83cb571cd1c50ba6f3e8a78ef1346",
                imageBuilder: (context, imageProvider) => Container(
                  width: 35.0,
                  height: 35.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: imageProvider,
                      // fit: BoxFit.cover,
                    ),
                  ),
                ),
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());
    return Scaffold(
        // bottomNavigationBar: buildBottomNavigationMenu(context, homeController),
        body: Stack(
      // fit: StackFit.expand,
      children: [
        Obx(() => IndexedStack(
              index: homeController.tabIndex.value,
              children: [
                // GuildView(),
                OverlappingPanels(
                  main: const MessagerView(),
                  left: const GuildView(),
                  right: const MembersView(),
                  restWidth: 50,
                  onSideChange: (side) {
                    if (side == RevealSide.main || side == RevealSide.right) {
                      isFooter.value = false;
                    } else if (side == RevealSide.left) {
                      isFooter.value = true;
                    }
                  },
                ),
                const ProfileView(),
              ],
            )),
        Obx(() => Align(
              alignment: Alignment.bottomCenter,
              child: AnimatedSlide(
                offset: Offset(0, isFooter.value ? 0 : 1),
                child: buildBottomNavigationMenu(context, homeController),
                duration: const Duration(milliseconds: 100),
              ),
            ))
      ],
    ));
  }
}
