import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/preferences/AppPreferences.dart';
import '../../../../models/home/banner.dart';
import '../../../../services/navigator.dart';
import '../../../../utils/palette.dart';
import '../../../base/page.dart';
import '../../../commonwidget/banner_image_carousel.dart';
import '../../../commonwidget/text_style.dart';
import 'banking/apply_for_loan.dart';
import 'banking/apply_insaurance.dart';

class BankingPage extends AppPageWithAppBar {
  static const String routeName = "/bankingPage";

  BankingPage({Key? key}) : super(key: key);

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
                      'Apply For Insurance',
                      style: TextStyle(
                          fontSize: 15,
                          color: Palette.appColor,
                          fontFamily: "assets/font/Oswald-Bold.ttf"),
                    )),
                    Tab(
                        child: Text('Apply For Loan',
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
            ApplyInsaurancePage(),
            ApplyLoanPage(),
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

  Text get applyForInsurance {
    return Text("Apply For Insurance",
        style: TextStyles.headingTexStyle(
            fontSize: 12,
            color: Palette.appColor,
            fontFamily: "assets/font/Oswald-Regular.ttf"));
  }

  Widget get applyForLoan {
    return Text("Apply For Loan",
        style: TextStyles.headingTexStyle(
            fontSize: 12,
            color: Palette.appColor,
            fontFamily: "assets/font/Oswald-Bold.ttf"));
  }
}
