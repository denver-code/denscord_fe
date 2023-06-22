import 'package:cached_network_image/cached_network_image.dart';
import 'package:denscord_fe/app/components/dialog.dart';
import 'package:denscord_fe/app/components/textfield.dart';
import 'package:denscord_fe/theme.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

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
                  title: CachedNetworkImage(
                    imageUrl: homeController.guilds[index].avatar ??
                        "https://www.gravatar.com/avatar/0bc83cb571cd1c50ba6f3e8a78ef1346",
                    imageBuilder: (context, imageProvider) => Container(
                      width: 80.0,
                      height: 80.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: homeController.activeGuild.value.id ==
                                  homeController.guilds[index].id
                              ? Colors.white
                              : Colors.transparent,
                          width: 2.0,
                        ),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: RichText(
                        overflow: TextOverflow.ellipsis,
                        // strutStyle: StrutStyle(fontSize: 12.0),
                        text: TextSpan(
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontFamily: "FixelDisplay",
                          ),
                          text: homeController.activeGuild.value.name ??
                              "Unknown Guild",
                        ),
                      ),
                    ),
                    PopupMenuButton(
                      color: DenscordColors.scaffoldForeground,
                      shape: ShapeBorder.lerp(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  DenscrodSizes.borderRadius)),
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  DenscrodSizes.borderRadius)),
                          1),
                      icon: const Icon(
                        Icons.more_vert_rounded,
                        color: Colors.white,
                      ),
                      tooltip: "Guild Options",
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          enabled: false,
                          child: Text(
                            "Settings",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        const PopupMenuItem(
                          enabled: false,
                          child: Text(
                            "Invite",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        PopupMenuItem(
                          onTap: () {
                            if (homeController.activeGuild.value.owner !=
                                homeController.me.value.id) {
                              Get.snackbar("Permissions denied!",
                                  "You can't create channels in this guild as you are not owner!",
                                  colorText: Colors.white,
                                  snackPosition: SnackPosition.BOTTOM);
                              return;
                            }
                            Future.delayed(
                                const Duration(seconds: 0),
                                () => MyDialog(
                                      onPressed: () {
                                        if (homeController.channelNameController
                                            .text.isEmpty) {
                                          Get.snackbar("Error",
                                              "Channel name can't be empty!",
                                              colorText: Colors.white,
                                              snackPosition:
                                                  SnackPosition.BOTTOM);
                                          return;
                                        }
                                        if (homeController.channelNameController
                                                .text.length >
                                            15) {
                                          Get.snackbar("Error",
                                              "Channel name can't be longer than 15 characters!",
                                              colorText: Colors.white,
                                              snackPosition:
                                                  SnackPosition.BOTTOM);
                                          return;
                                        }
                                        homeController.createChannel();
                                      },
                                      content: Column(
                                        children: [
                                          MyTextField(
                                            isEnabled: homeController
                                                    .activeGuild.value.owner ==
                                                homeController.me.value.id,
                                            controller: homeController
                                                .channelNameController,
                                            hintText:
                                                "Name of the new best channel ever",
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          MyTextField(
                                            isEnabled: homeController
                                                    .activeGuild.value.owner ==
                                                homeController.me.value.id,
                                            controller: homeController
                                                .channelDescriptionController,
                                            hintText:
                                                "Description of the channel",
                                          ),
                                        ],
                                      ),
                                    ).build());
                          },
                          child: const Text(
                            "Add channel",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        PopupMenuItem(
                          onTap: () {
                            if (homeController.activeGuild.value.owner ==
                                homeController.me.value.id) {
                              Get.snackbar("Permissions denied!",
                                  "You can't leave this guild as you are owner!",
                                  colorText: Colors.white,
                                  snackPosition: SnackPosition.BOTTOM);
                              return;
                            }
                            homeController.leaveGuild();
                          },
                          child: Text(
                            "Leave",
                            style: TextStyle(color: Colors.red[400]),
                          ),
                        ),
                      ],
                    ),
                  ],
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
                                style: TextStyle(
                                    color: homeController
                                                .activeChannel.value.id ==
                                            homeController.channels[index].id
                                        ? Colors.white
                                        : Colors.white54),
                              ),
                              onTap: () {
                                homeController.setActiveChannel(homeController
                                    .channels[index].id
                                    .toString());
                              },
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
