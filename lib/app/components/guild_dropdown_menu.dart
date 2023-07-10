import 'package:denscord_fe/app/components/dialog.dart';
import 'package:denscord_fe/app/components/textfield.dart';
import 'package:denscord_fe/app/modules/home/controllers/home_controller.dart';
import 'package:denscord_fe/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GuildDropdownMenu extends StatelessWidget {
  const GuildDropdownMenu({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());
    return PopupMenuButton(
      color: DenscordColors.scaffoldForeground,
      shape: ShapeBorder.lerp(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(DenscrodSizes.borderRadius)),
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(DenscrodSizes.borderRadius)),
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
                  colorText: Colors.white, snackPosition: SnackPosition.BOTTOM);
              return;
            }
            Future.delayed(
                const Duration(seconds: 0),
                () => MyDialog(
                      title: "Creating new channel",
                      onPressed: () {
                        if (homeController.channelNameController.text.isEmpty) {
                          Get.snackbar("Error", "Channel name can't be empty!",
                              colorText: Colors.white,
                              snackPosition: SnackPosition.BOTTOM);
                          return;
                        }
                        if (homeController.channelNameController.text.length >
                            15) {
                          Get.snackbar("Error",
                              "Channel name can't be longer than 15 characters!",
                              colorText: Colors.white,
                              snackPosition: SnackPosition.BOTTOM);
                          return;
                        }
                        homeController.createChannel();
                      },
                      content: Column(
                        children: [
                          MyTextField(
                            isEnabled: homeController.activeGuild.value.owner ==
                                homeController.me.value.id,
                            controller: homeController.channelNameController,
                            hintText: "Name of the new best channel ever",
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          MyTextField(
                            isEnabled: homeController.activeGuild.value.owner ==
                                homeController.me.value.id,
                            controller:
                                homeController.channelDescriptionController,
                            hintText: "Description of the channel",
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
          enabled: true,
          onTap: homeController.copyGuildIdToClipboard,
          child: const Text(
            "Copy Guild ID",
            style: TextStyle(color: Colors.white),
          ),
        ),
        PopupMenuItem(
          onTap: () {
            if (homeController.activeGuild.value.owner ==
                homeController.me.value.id) {
              Get.snackbar("Permissions denied!",
                  "You can't leave this guild as you are owner!",
                  colorText: Colors.white, snackPosition: SnackPosition.BOTTOM);
              return;
            }
            homeController.leaveGuild();
          },
          child: Text(
            "Leave",
            style: TextStyle(color: Colors.red[400]),
          ),
        ),
        PopupMenuItem(
          enabled: homeController.activeGuild.value.owner ==
              homeController.me.value.id,
          onTap: homeController.deleteGuild,
          child: Text(
            "Delete Guild",
            style: TextStyle(color: Colors.red[400]),
          ),
        )
      ],
    );
  }
}
