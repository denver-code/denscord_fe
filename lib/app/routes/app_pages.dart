import 'package:get/get.dart';

import '../modules/authorisation/bindings/authorisation_binding.dart';
import '../modules/authorisation/views/authorisation_view.dart';
import '../modules/heading/bindings/heading_binding.dart';
import '../modules/heading/views/heading_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/registration/bindings/registration_binding.dart';
import '../modules/registration/views/registration_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static String INITIAL = Routes.HEADING;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.AUTHORISATION,
      page: () => const AuthorisationView(),
      binding: AuthorisationBinding(),
    ),
    GetPage(
      name: _Paths.REGISTRATION,
      page: () => const RegistrationView(),
      binding: RegistrationBinding(),
    ),
    GetPage(
      name: _Paths.HEADING,
      page: () => const HeadingView(),
      binding: HeadingBinding(),
    ),
  ];
}
