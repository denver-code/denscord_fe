import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void copyToClipboard(String valueToSet) async {
  await Clipboard.setData(
    ClipboardData(
      text: valueToSet,
    ),
  );
  Get.snackbar(
    "Copied",
    "Copied to clipboard",
    colorText: Colors.white,
    snackPosition: SnackPosition.BOTTOM,
    duration: const Duration(
      milliseconds: 650,
    ),
  );
}
