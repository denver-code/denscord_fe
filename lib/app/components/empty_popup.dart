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
      content: content,
    );
  }
}
