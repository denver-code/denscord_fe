import 'package:cached_network_image/cached_network_image.dart';
import 'package:denscord_fe/app/components/profile_button.dart';
import 'package:denscord_fe/app/components/settings_button.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../theme.dart';
import '../controllers/home_controller.dart';

class ProfileView extends GetView<HomeController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());
    return Scaffold(
        // backgroundColor: Colors.white,
        body: SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              SizedBox(
                height: Get.height / 3.8,
                child: Stack(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.asset("assets/images/profile_bg.png",
                            width: Get.width)),
                    Image.asset("assets/images/shade.png", width: Get.width),
                  ],
                ),
              ),
              Positioned(
                top: Get.height / 15,
                left: Get.width / 22,
                child: Text(
                  "Profile",
                  style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                      color: DenscordColors.textSecondary),
                ),
              ),
              Positioned(
                top: Get.height / 5.90,
                left: Get.width / 22,
                child: Obx(
                  () => CachedNetworkImage(
                    imageUrl: homeController.me.value.avatar ??
                        "https://www.gravatar.com/avatar/0bc83cb571cd1c50ba6f3e8a78ef1346",
                    imageBuilder: (context, imageProvider) => Container(
                      width: 70.0,
                      height: 70.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: imageProvider,
                          // fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            CircularProgressIndicator(
                                value: downloadProgress.progress),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Obx(
                          () => Text("@${homeController.me.value.username}",
                              style: const TextStyle(
                                // color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 18.0,
                              )),
                        ),
                        const SizedBox(width: 10.0),
                        Obx(
                          () => homeController.me.value.isNitro
                              ? Image.asset("assets/images/nitro.png",
                                  width: 20.0, height: 20.0)
                              : const SizedBox(),
                        )
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios_rounded,
                        color: DenscordColors.textSecondary, size: 20.0),
                  ],
                ),
                const SizedBox(height: 15.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "ACCOUNT SETTINGS",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: DenscordColors.textSecondary),
                  ),
                ),
                const SizedBox(height: 20.0),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        homeController.accountSettingsButtons[0],
                        homeController.accountSettingsButtons[1],
                      ],
                    ),
                    SizedBox(height: Get.height / 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        homeController.accountSettingsButtons[2],
                        homeController.accountSettingsButtons[3],
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 15.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "OTHER SETTINGS",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: DenscordColors.textSecondary),
                  ),
                ),
                const SizedBox(height: 20.0),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ProfileSquareButton(
                        text: "Authorised Apps",
                        icon: const Icon(
                          Icons.key_rounded,
                          color: Colors.white,
                          size: 33,
                        ),
                        onPressed: () {},
                      ),
                      const SizedBox(width: 10.0),
                      ProfileSquareButton(
                        text: "Nitro",
                        icon:
                            Image.asset("assets/images/nitro.png", width: 33.0),
                        onPressed: () {},
                      ),
                      const SizedBox(width: 10.0),
                      ProfileSquareButton(
                        text: "QR-code",
                        icon: const Icon(
                          Icons.qr_code_scanner_rounded,
                          color: Colors.white,
                          size: 33,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "APP SETTINGS",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: DenscordColors.textSecondary),
                  ),
                ),
                const SizedBox(height: 7.0),
                SettingsButton(
                    text1: "Voice",
                    text2: "Voice activity",
                    icon: Icons.mic_rounded,
                    onTap: () {}),
                SettingsButton(
                    text1: "Apperance",
                    text2: "Dark Mode",
                    icon: Icons.palette_outlined,
                    onTap: () {}),
                SettingsButton(
                    text1: "Accessibility",
                    text2: "",
                    icon: Icons.accessibility_new_rounded,
                    onTap: () {}),
                SettingsButton(
                    text1: "Information",
                    text2: "About Denscord",
                    icon: Icons.info_outline_rounded,
                    onTap: () {}),
                SettingsButton(
                    text1: "Log out",
                    text2: "See you later!",
                    icon: Icons.logout_rounded,
                    onTap: controller.logout),
              ],
            ),
          ),
          SizedBox(height: Get.height / 8.2),
        ],
      ),
    ));
  }
}
