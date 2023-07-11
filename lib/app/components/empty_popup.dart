import 'package:denscord_fe/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmptyPopup {
  final Widget content;
  final String title;

  EmptyPopup({
    required this.content,
    this.title = "New Dialog",
  });

  build() {
    Get.defaultDialog(
      radius: DenscrodSizes.borderRadius,
      title: title,
      titleStyle: const TextStyle(
        color: Colors.white,
        fontSize: 17,
      ),
      content: content,
      backgroundColor: DenscordColors.scaffoldForeground,
    );
  }
}
