import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/preferences/AppPreferences.dart';
import '../../../../models/home/banner.dart';
import '../../../../services/navigator.dart';
import '../../../../utils/palette.dart';
import '../../../base/page.dart';
import '../../../commonwidget/banner_image_carousel.dart';
import '../../prime/prime_fb_video.dart';
import '../../prime/prime_video.dart';

class PrimePage extends AppPageWithAppBar {
  static const String routeName = "/primePage";

  PrimePage({Key? key}) : super(key: key);

  static Future<bool?> start<bool>(
    String title, {
    allProduct,
  }) {
    return navigateTo<bool>(routeName, currentPageTitle: title, arguments: {
      'allProduct': allProduct,
    });
  }

  final appPreferences = Get.find<AppPreferences>();

  @override
  Widget get body {
    return Scaffold(
        body: DefaultTabController(
      length: 2,
      child: NestedScrollView(
        scrollDirection: Axis.vertical,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverToBoxAdapter(
            child: Column(
              children: [
                banner,
                const SizedBox(
                  height: 10,
                ),
                TabBar(
                  tabs: [
                    Tab(
                        child: Text(
                      "visit_faceBook".tr,
                      style: const TextStyle(
                          fontSize: 15,
                          color: Palette.appColor,
                          fontFamily: "assets/font/Oswald-Bold.ttf"),
                    )),
                    Tab(
                        child: Text("visit_youTube".tr,
                            style: const TextStyle(
                                fontSize: 15,
                                color: Palette.appColor,
                                fontFamily: "assets/font/Oswald-Bold.ttf"))),
                  ],
                ),
              ],
            ),
          ),
        ],
        body: TabBarView(
          children: [
            PrimeFbVideo(url: "http://www.facebook.com/f2dfsupport"),
            PrimeVideo(url: "https://www.youtube.com/c/F2DFOFFICIAL"),
          ],
        ),
      ),
    ));
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
