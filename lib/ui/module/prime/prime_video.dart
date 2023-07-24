import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcsofttech/ui/base/base_satateless_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../data/preferences/AppPreferences.dart';
import '../../../models/home/banner.dart';
import '../../../utils/analytics.dart';
import '../../commonwidget/banner_image_carousel.dart';

class PrimeVideo extends BaseStateLessWidget {
  final String url;
  PrimeVideo({Key? key, required this.url}) : super(key: key);
  final appPreferences = Get.find<AppPreferences>();
  @override
  Widget build(BuildContext context) {
    //Analytics.sendCurrentScreen("prime_video");
    return WebView(
      gestureRecognizers: Set()
        ..add(Factory<VerticalDragGestureRecognizer>(
            () => VerticalDragGestureRecognizer())),
      initialUrl: url,
      onWebResourceError: (WebResourceError error) {
        //Common.showToast(error.description);
        print(error.description);
        //loadUrl("http://connectivitycheck.gstatic.com/generate_204");
      },
      allowsInlineMediaPlayback: true,
      javascriptMode: JavascriptMode.unrestricted,
    );
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
