import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcsofttech/ui/base/base_satateless_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../data/preferences/AppPreferences.dart';
import '../../../models/home/banner.dart';
import '../../../utils/analytics.dart';
import '../../commonwidget/banner_image_carousel.dart';

class PrimeFbVideo extends BaseStateLessWidget {
  final String url;

  PrimeFbVideo({Key? key, required this.url}) : super(key: key);
  final appPreferences = Get.find<AppPreferences>();

  @override
  Widget build(BuildContext context) {
   // Analytics.sendCurrentScreen("prime_fb");
    return WebView(
          initialUrl: url);
  }

  Widget get banner {
    List<String> banner = appPreferences.banner;
    List<BannerData> bannerData = <BannerData>[];
    for (String item in banner) {
      bannerData.add(BannerData(bannerId: 1, img: item));
    }
    return BannerCarousel(bannerList: bannerData);
  }
}
