import 'package:get/get.dart';

import '../ui/module/splash/splash_screen.dart';

class SplashScreenRoutes {
  SplashScreenRoutes._();

  static List<GetPage> get routes =>
      [GetPage(name: SplashScreen.routeName, page: () => SplashScreen())];
}
