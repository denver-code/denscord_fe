import 'package:cached_network_image/cached_network_image.dart';
import 'package:denscord_fe/theme.dart';
import 'package:flutter/gestures.dart';
import 'package:overlapping_panels/overlapping_panels.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class MessagerView extends GetView<HomeController> {
  const MessagerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());
    return Scaffold(
      backgroundColor: DenscordColors.scaffoldForeground,
      body: Column(children: [
        Container(
          height: 90,
          width: double.infinity,
          decoration: BoxDecoration(
            color: DenscordColors.scaffoldBackground,
            border: Border(
              bottom: BorderSide(
                color: DenscordColors.textSecondary,
                width: 1,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 2, left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    //
                    IconButton(
                      onPressed: () => OverlappingPanels.of(context)
                          ?.reveal(RevealSide.left),
                      icon: const Icon(
                        Icons.menu_outlined,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Obx(
                      () => Text(
                        "# ${controller.activeChannel.value.name}",
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.search_outlined,
                      color: Colors.white,
                      size: 25,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    IconButton(
                      onPressed: () => OverlappingPanels.of(context)
                          ?.reveal(RevealSide.right),
                      icon: const Icon(
                        Icons.group_outlined,
                        color: Colors.white,
                        size: 25,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        // Messages view
        Obx(
          () => Expanded(
            child: homeController.messages.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    controller: homeController.messagerListController,
                    reverse: true,
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    padding: EdgeInsets.zero,
                    itemCount: homeController.messages.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        key: Key(homeController.messages[index].id.toString()),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(100.0),
                          child: CachedNetworkImage(
                            fit: BoxFit.fill,
                            width: 35,
                            height: 35,
                            imageUrl: homeController
                                    .messages[index].authorAvatar ??
                                "https://www.gravatar.com/avatar/0bc83cb571cd1c50ba6f3e8a78ef1346",
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    CircularProgressIndicator(
                                        value: downloadProgress.progress),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                        title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                homeController.messages[index].authorUsername
                                    .toString(),
                                style: const TextStyle(color: Colors.white),
                              ),
                              // const SizedBox(
                              //   width: 10,
                              // ),
                              Text(
                                timeago.format(DateTime.parse(homeController
                                    .messages[index].createdAt
                                    .toString())),
                                style: TextStyle(
                                    color: DenscordColors.textSecondary,
                                    fontSize: 14),
                              ),
                            ]),
                        subtitle: Text(
                          homeController.messages[index].message.toString(),
                          maxLines: 500,
                          style: const TextStyle(color: Colors.white),
                        ),
                        onTap: () {},
                      );
                    })
                : const Center(
                    child: Text(
                      "Empty Channel...",
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
          ),
        ),

        // Text input bar
        Container(
          width: Get.width,
          // height: 75,
          decoration: BoxDecoration(
            color: DenscordColors.scaffoldBackground,
            border: Border(
              top: BorderSide(
                color: DenscordColors.textSecondary,
                width: 1,
              ),
            ),
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 5),
            child: Row(
              children: [
                const Icon(
                  Icons.file_copy_outlined,
                  color: Colors.white,
                  size: 25,
                ),
                const SizedBox(
                  width: 20,
                ),
                const Icon(Icons.wallet_giftcard_rounded,
                    color: Colors.white, size: 25),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 5),
                    child: Obx(
                      () => TextField(
                        enabled: homeController.activeChannel.value.id != null,
                        controller: homeController.messageController,
                        cursorColor: Colors.white,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(DenscrodSizes.borderRadius)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(DenscrodSizes.borderRadius)),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            fillColor: DenscordColors.scaffoldForeground,
                            // const Color.fromARGB(255, 50, 50, 50)
                            filled: true,
                            hintText:
                                "Message #${controller.activeChannel.value.name}",
                            hintStyle: TextStyle(
                                color: Colors.grey[500], fontSize: 14)),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: homeController.sendMessage,
                  child: const Icon(
                    Icons.send_rounded,
                    color: Colors.white,
                    size: 25,
                  ),
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
