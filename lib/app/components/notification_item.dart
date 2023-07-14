import 'package:denscord_fe/app/models/invite_request_model.dart';
import 'package:denscord_fe/app/modules/home/controllers/home_controller.dart';
import 'package:denscord_fe/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationItem extends StatelessWidget {
  NotificationItem({super.key, required this.notification});
  InviteRequestModel notification;

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(notification.sender!.avatar.toString()),
      ),
      title: Text(
        "Invite from ${notification.sender!.username.toString()} to join \"${notification.guild!.name.toString()}\" Guild",
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      subtitle: Text(
        notification.guild!.description.toString(),
        style: TextStyle(
          color: DenscordColors.textSecondary,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(
              Icons.check,
              color: Colors.green[400],
            ),
            onPressed: () {
              homeController.answerInviteRequest(
                  action: true, inviteRequest: notification);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.red[400],
            ),
            onPressed: () {
              homeController.answerInviteRequest(
                  action: false, inviteRequest: notification);
            },
          ),
        ],
      ),
    );
  }
}
