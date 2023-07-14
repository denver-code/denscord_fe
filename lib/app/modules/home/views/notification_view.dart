import 'package:cached_network_image/cached_network_image.dart';
import 'package:denscord_fe/app/components/empty_popup.dart';
import 'package:denscord_fe/app/models/stack_trace_model.dart';
import 'package:denscord_fe/app/utils/clipboard.dart';
import 'package:denscord_fe/app/utils/format_date.dart';
import 'package:denscord_fe/theme.dart';
import 'package:get_storage/get_storage.dart';
import 'package:overlapping_panels/overlapping_panels.dart';
// import 'package:timeago/timeago.dart' as timeago;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/notification_item.dart';
import '../controllers/home_controller.dart';

class NotificationsView extends GetView<HomeController> {
  const NotificationsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());
    return Scaffold(
        appBar: AppBar(
          title: const Column(children: [
            Text(
              "Notifications",
              style: TextStyle(fontSize: 17),
            )
            // ToDo: Implement "For you" and "Mentions" tabs
          ]),
          centerTitle: true,
          backgroundColor: DenscordColors.buttonSecondary,
          // need add refresh button at the right
          actions: [
            IconButton(
              onPressed: () {
                homeController.inviteRequests.clear();
                homeController.getInvites();
              },
              icon: const Icon(Icons.refresh),
            )
          ],
        ),
        backgroundColor: DenscordColors.scaffoldForeground,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Obx(
              () => homeController.inviteRequests.isNotEmpty
                  ? ListView.builder(
                      itemCount: homeController.inviteRequests.length,
                      itemBuilder: (context, index) {
                        return NotificationItem(
                            notification: homeController.inviteRequests[index]);
                      })
                  : const Center(child: Text("No notifications or invites :(")),
            ),
          ),
        ));
  }
}
