import 'package:get/get.dart';

import '../controllers/authorisation_controller.dart';

class AuthorisationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthorisationController>(
      () => AuthorisationController(),
    );
  }
}
