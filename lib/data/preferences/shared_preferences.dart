import 'package:get/get.dart';

import 'AppPreferences.dart';

class SharedConfig {
  static final String authToken = Get.find<AppPreferences>().authToken;
  static final bool isLoggedIn = Get.find<AppPreferences>().isLoggedIn;
  static final String userId = Get.find<AppPreferences>().userId;
}
