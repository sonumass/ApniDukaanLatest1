import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:mcsofttech/ui/module/splash/splash_screen.dart';
class DynamicLinksApi {
  final dynamicLink = FirebaseDynamicLinks.instance;

  Future<void> initDynamicLinks(BuildContext context) async {
    FirebaseDynamicLinks.instance.onLink;
  }

  void handleSuccessLinking(
      {PendingDynamicLinkData? data, BuildContext? context}) {
    final Uri? deepLink = data?.link;

    if (deepLink != null) {
      Navigator.push(
        context!,
        MaterialPageRoute(
          builder: (context) => SplashScreen(),
        ),
      );
      /*var isRefer = deepLink.pathSegments.contains('referans');
      if (isRefer) {
        var code = deepLink.queryParameters['code'];
        debugPrint(code.toString());
        if (code != null) {
          Navigator.push(
            context!,
            MaterialPageRoute(
              builder: (context) => SplashScreen(),
            ),
          );
        }*/
      //}
    }
  }


  static Future<String> createReferralLink(String referralCode) async {
  /*  final DynamicLinkParameters dynamicLinkParameters = DynamicLinkParameters(
      uriPrefix: 'https://f2dfapp.page.link/tobR',
      link: Uri.parse('https://www.f2df.com/product/details?id=$referralCode'),
      androidParameters: const AndroidParameters(
        packageName: 'com.f2df.mcsofttech',
      ),
    );

    final ShortDynamicLink shortLink =
    await dynamicLinkParameters.buildShortLink();

    final Uri dynamicUrl = shortLink.shortUrl;
    debugPrint(dynamicUrl.toString());*/
    return "";//dynamicUrl.toString();
  }
}