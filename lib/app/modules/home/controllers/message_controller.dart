import 'dart:convert';

import 'package:denscord_fe/app/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin MessageController {
  var channel;
  TextEditingController messageController = TextEditingController();
  RxList<MessageModel> messages = <MessageModel>[].obs;
  ScrollController messagerListController = ScrollController();

  void sendMessage() {
    if (messageController.text.isNotEmpty) {
      if (channel == null) {
        return;
      }
      channel!.sink.add(json.encode({"message": messageController.text}));
      messageController.clear();
    }
  }
}
