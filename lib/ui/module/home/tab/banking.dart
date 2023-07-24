import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcsofttech/models/home/banner.dart';
import 'package:mcsofttech/ui/module/home/tab/banking/apply_for_loan.dart';
import 'package:mcsofttech/ui/module/home/tab/banking/apply_insaurance.dart';
import '../../../../data/preferences/AppPreferences.dart';
import '../../../../utils/palette.dart';
import '../../../commonwidget/banner_image_carousel.dart';
import '../../../commonwidget/text_style.dart';

class BankingTabs extends StatefulWidget {
  const BankingTabs({Key? key}) : super(key: key);

  @override
  State<BankingTabs> createState() => _BankingTabsState();
}

class _BankingTabsState extends State<BankingTabs> {
  final appPreferences = Get.find<AppPreferences>();

  @override
  Widget build(BuildContext context) {
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
