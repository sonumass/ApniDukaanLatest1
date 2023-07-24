import 'dart:convert';

import 'package:flutter/services.dart';

abstract class Environment {
  static const String PROD = "prod";
  static const String DEV = "dev";
  static var _config = <String, dynamic>{};
  static var isProd = false;

  static Future<void> initialize(String env) async {
    String configurationPath;
    if (env == PROD) {
      isProd = true;
      configurationPath = "assets/env/prod.json";
    } else {
      configurationPath = "assets/env/dev.json";
    }
    final configStrig = await rootBundle.loadString(configurationPath);
    _config = jsonDecode(configStrig);
  }

  static String get staticLocalUrl {
    return _config['staticLoginUrl'] as String;
  }

  static String get staticBasaeUrl {
    return _config['staticBasaeUrl'];
  }

  static String get logEnable {
    return _config['logEnable'];
  }
}
