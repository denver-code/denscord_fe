import 'package:denscord_fe/app/components/button.dart';
import 'package:denscord_fe/app/components/logo.dart';
import 'package:denscord_fe/app/utils/hex2color.dart';
import 'package:denscord_fe/theme.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/heading_controller.dart';

class HeadingView extends GetView<HeadingController> {
  const HeadingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    HeadingController controller = Get.put(HeadingController());
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 17.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: Get.height / 20,
            ),
            const LogoWidget(),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width / 15),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Image.asset(
                        "assets/images/girl1.png",
                        scale: 2,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Image.asset(
                        "assets/images/girl2.png",
                        scale: 2,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Image.asset(
                        "assets/images/lad1.png",
                        scale: 2,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: Get.height / 30,
            ),
            Column(
              children: [
                const Text("Welcome to Denscord",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontFamily: "FixelDisplay")),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "Tiny clone of Discord which you can use to\ntalk with communities and friends",
                  style: TextStyle(
                      color: HexColor.fromHex("989898"),
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            SizedBox(
              height: Get.height / 20,
            ),
            Column(
              children: [
                BigButtonWidget(
                  text: "Register",
                  height: Get.height / 19,
                  onPressed: controller.onRegistration,
                  backgroundColor: DenscordColors.buttonPrimary,
                ),
                const SizedBox(
                  height: 10,
                ),
                BigButtonWidget(
                  text: "Log In",
                  height: Get.height / 19,
                  onPressed: controller.onAuthorisation,
                  backgroundColor: DenscordColors.buttonSecondary,
                ),
              ],
            ),
            SizedBox(
              height: Get.height / 80,
            ),
          ],
        ),
      )),
    );
  }
}
