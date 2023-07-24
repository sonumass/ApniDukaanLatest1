/*import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';*/
import 'package:mcsofttech/data/preferences/shared_preferences.dart';

class Analytics {
  Analytics._();
/*

  static final _analytics = FirebaseAnalytics();

  static get firebaseAnalyticsObserver =>
      FirebaseAnalyticsObserver(analytics: _analytics);

  static Future<void> logAppOpen() {
    return _analytics.logAppOpen();
  }

  static Future<void> sendCurrentScreen(String screenName) {
    return _analytics.setCurrentScreen(screenName: screenName);
  }

  static Future<void> logLogin({String? loginMethod}) {
    return _analytics.logLogin(loginMethod: loginMethod);
  }

  static Future<void> logEvent(
      {required String name, Map<String, Object?>? map}) async {
    final parameters = {
      "user_id": SharedConfig.userId,
      "platform":'Mobile',
      if(map !=null) ...map,
    };
    await _analytics.logEvent(name: name,parameters: parameters);
  }
static Future<void> logUser({
  required String? userId,
  required String? userName,
})async{
    await _analytics.setUserId(userId);
    await _analytics.setUserProperty(name: "user_name", value: userName);


}
*/

}