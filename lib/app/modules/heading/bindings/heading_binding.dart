import 'package:get/get.dart';

import '../controllers/heading_controller.dart';

class HeadingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HeadingController>(
      () => HeadingController(),
    );
  }
}
