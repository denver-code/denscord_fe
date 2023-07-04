import 'package:denscord_fe/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDialog {
  final String title;
  final Function()? onPressed;
  final Widget content;
  final String confirmText;

  MyDialog({
    required this.onPressed,
    required this.content,
    this.title = "New Dialog",
    this.confirmText = "Create",
  });

  build() {
    Get.defaultDialog(
      radius: DenscrodSizes.borderRadius,
      title: title,
      content: content,
      cancel: SizedBox(
        width: Get.width / 5,
        child: TextButton(
          style: TextButton.styleFrom(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            // backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(DenscrodSizes.borderRadius),
                side: const BorderSide(color: Colors.black)),
          ),
          child: const Text(
            "Cancel",
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      confirm: SizedBox(
        width: Get.width / 5,
        child: TextButton(
          style: TextButton.styleFrom(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(DenscrodSizes.borderRadius)),
          ),
          onPressed: onPressed,
          child: Text(
            confirmText,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
