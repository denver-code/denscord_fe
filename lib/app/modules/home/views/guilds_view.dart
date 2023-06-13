import 'package:cached_network_image/cached_network_image.dart';
import 'package:denscord_fe/theme.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class GuildView extends GetView<HomeController> {
  const GuildView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());
    return Scaffold(
        body: Obx(
      () => Row(children: [
        Container(
          width: Get.width / 5,
          height: Get.height,
          decoration: BoxDecoration(color: DenscordColors.scaffoldForeground),
          child: ListView.builder(
              itemCount: homeController.guilds.length,
              itemBuilder: (context, index) {
                return ListTile(
                  key: Key(homeController.guilds[index].id ?? index.toString()),
                  title: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 2.5, color: Colors.white),
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100.0),
                      child: CachedNetworkImage(
                        fit: BoxFit.fill,
                        imageUrl: homeController.guilds[index].avatar ??
                            "https://cdn.discordapp.com/embed/avatars/0.png",
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                                    value: downloadProgress.progress),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                  onTap: () {
                    homeController.setActiveGuild(
                        homeController.guilds[index].id.toString());
                  },
                );
              }),
        ),
        SizedBox(
          width: Get.width / 1.5,
          height: Get.height,
          child: Padding(
            padding: const EdgeInsets.only(top: 50.0, left: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  homeController.activeGuild.value.name ?? "Unknown Guild",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontFamily: "FixelDisplay"),
                ),
                Expanded(
                  child: homeController.channels.isNotEmpty
                      ? ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: homeController.channels.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              key: Key(homeController.channels[index].id ??
                                  index.toString()),
                              title: Text(
                                "#${homeController.channels[index].name ?? ""}",
                                style: TextStyle(color: Colors.white),
                              ),
                              onTap: () {},
                            );
                          })
                      : const Text("No channels"),
                )
              ],
            ),
          ),
        )
      ]),
    ));
  }
}
