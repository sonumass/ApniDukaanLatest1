import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcsofttech/ui/module/home/tab/training/apply_trainning.dart';
import 'package:mcsofttech/ui/module/home/tab/training/successfully_training_page.dart';
import 'package:mcsofttech/ui/module/home/tab/training/upcoming_t_page.dart';
import '../../../../data/preferences/AppPreferences.dart';
import '../../../../models/home/banner.dart';
import '../../../../services/navigator.dart';
import '../../../../utils/analytics.dart';
import '../../../../utils/palette.dart';
import '../../../base/page.dart';
import '../../../commonwidget/banner_image_carousel.dart';

class TrainingPage extends AppPageWithAppBar {
  static const String routeName = "/trainingPage";

  TrainingPage({Key? key}) : super(key: key);

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
   // Analytics.sendCurrentScreen("training_view");
    return Scaffold(
        body: DefaultTabController(
      length: 3,
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
                const TabBar(
                  tabs: [
                    Tab(
                        child: Text(
                      'Apply Training',
                      style: TextStyle(
                          fontSize: 15,
                          color: Palette.appColor,
                          fontFamily: "assets/font/Oswald-Bold.ttf"),
                    )),
                    Tab(
                        child: Text('Upcoming Training',
                            style: TextStyle(
                                fontSize: 15,
                                color: Palette.appColor,
                                fontFamily: "assets/font/Oswald-Bold.ttf"))),
                    Tab(
                        child: Text('Successfully Training',
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
          children: [
            ApplyTraining(),
            UpcomingTrainingPage(clickApplyAt: false),
             SuccessfullyTraining(),
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
