import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mcsofttech/ui/base/page.dart';
import 'package:mcsofttech/ui/module/news_and_video/tab/new_tab.dart';
import 'package:mcsofttech/ui/module/news_and_video/tab/new_videos.dart';
import '../../../../../utils/palette.dart';
import '../../../data/preferences/AppPreferences.dart';
import '../../../models/home/banner.dart';
import '../../../services/navigator.dart';
import '../../commonwidget/banner_image_carousel.dart';

class NewsAndVideo extends AppPageWithAppBar {
  static String routeName = "/newsandvideo";
  final appPreferences = Get.find<AppPreferences>();

  static Future<bool?> start<bool>(String title, {categoryId, storeId}) {
    return navigateTo<bool>(routeName, currentPageTitle: title);
  }

  @override
  Widget get body {
    return Scaffold(
        body: DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: NestedScrollView(
        scrollDirection: Axis.vertical,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverToBoxAdapter(
            child: Column(
              children: [
                banner,
                const TabBar(
                  tabs: [
                    Tab(
                        child: Text(
                      'News',
                      style: TextStyle(
                          fontSize: 15,
                          color: Palette.appColor,
                          fontFamily: "assets/font/Oswald-Bold.ttf"),
                    )),
                    Tab(
                        child: Text('Video',
                            style: TextStyle(
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
          children: [NewsPage(), YoutubePlayerWidget()],
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
