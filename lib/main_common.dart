//import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:mcsofttech/environment.dart';
import 'package:get/get.dart';
import 'package:mcsofttech/notifire/cart_notifire.dart';
import 'package:mcsofttech/route.dart';
import 'package:mcsofttech/theme/my_theme.dart';
import 'package:mcsofttech/ui/module/splash/splash_screen.dart';
import 'package:mcsofttech/utils/FirebaseNotificationHandler.dart';
import 'package:mcsofttech/utils/analytics.dart';
import 'package:mcsofttech/utils/translater.dart';
import 'package:provider/provider.dart';
import 'controllers/bindings/initial_binding.dart';
import 'data/mapper/mapper.dart';

Future<void> mainCommon(String env) async {

    WidgetsFlutterBinding.ensureInitialized();
    Firebase.initializeApp();
    MapperFactory.initialize();
    await Environment.initialize(env);
    debugPrint("MainCommon Env $env");
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    await InitialBindings().dependencies();
   // FirebaseNotifications().init();
    //FirebaseNotifications.flutterLocalNotificationsPlugin;
    //https://www.youtube.com/watch?v=Hg1ZJjWzRxs for iOS notification
    MobileAds.instance.initialize();
    //Analytics.logAppOpen();
   /* MobileAds.instance.updateRequestConfiguration(
      RequestConfiguration(
        testDeviceIds: <String>['CC4A58D8BB0AFCC571E4AAC6BCAA5F68'],
      ),
    );*/
    runApp(ChangeNotifierProvider(
      create: (_) => CartNotifier(),
      child: getMaterialApp,
    ));


}
/*Analytics.firebaseAnalyticsObserver*/
GetMaterialApp get getMaterialApp => GetMaterialApp(
      title: '',
      debugShowCheckedModeBanner: false,
      navigatorObservers: [],
      translations: TranslateData(),
      locale: const Locale(
        'en',
        'US',
      ),
      fallbackLocale:
          const Locale.fromSubtags(languageCode: 'en', countryCode: ' US'),
      theme: ThemeData(
        primarySwatch: MyColors.appColor,
      ),
      getPages: Routes.get(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
          child: child ?? Container(),
        );
      },
      defaultTransition: Transition.rightToLeftWithFade,
      initialRoute: SplashScreen.routeName,
    );
