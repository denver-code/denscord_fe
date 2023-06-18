import 'package:cached_network_image/cached_network_image.dart';
import 'package:denscord_fe/theme.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class MembersView extends GetView<HomeController> {
  const MembersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());
    return Scaffold(
        body: SizedBox(
      height: Get.height,
      child: Padding(
        padding: EdgeInsets.only(left: 50, top: Get.height / 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Row(
                children: [
                  Text(
                    "#",
                    style: TextStyle(
                      color: DenscordColors.textSecondary,
                      fontSize: 25,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Obx(
                    () => Text(
                      controller.activeChannel.value.name.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: "FixelDisplay",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: Get.width,
              height: 1,
              color: DenscordColors.textSecondary,
            ),
            // const SizedBox(
            //   height: 10,
            // ),
            // const Text(
            //   "CONTROLL BUTTONS",
            //   textAlign: TextAlign.center,
            //   style: TextStyle(fontSize: 15, color: Colors.white),
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            // Container(
            //   width: Get.width,
            //   height: 1,
            //   color: DenscordColors.textSecondary,
            // ),
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Obx(
                  () => Text(
                    "${controller.activeGuild.value.membersCount} Member(s):",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: DenscordColors.textSecondary,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Obx(
              () => Expanded(
                child: homeController.members.isNotEmpty
                    ? ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: homeController.members.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            key: Key(homeController.members[index].id ??
                                index.toString()),
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(100.0),
                              child: CachedNetworkImage(
                                fit: BoxFit.fill,
                                width: 35,
                                height: 35,
                                imageUrl: homeController
                                        .members[index].avatar ??
                                    "https://cdn.discordapp.com/embed/avatars/0.png",
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                        CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                            title: Row(
                              children: [
                                Text(
                                  homeController.members[index].username ?? "",
                                  style: const TextStyle(color: Colors.white),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                homeController.activeGuild.value.owner ==
                                        homeController.members[index].id
                                    ? const Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                            onTap: () {},
                          );
                        })
                    : const SizedBox(),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
