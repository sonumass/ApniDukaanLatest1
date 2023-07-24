import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcsofttech/models/home/banner.dart';
import 'package:mcsofttech/theme/my_theme.dart';
import '../../../../data/preferences/AppPreferences.dart';
import '../../../../utils/palette.dart';
import '../../commonwidget/banner_image_carousel.dart';
import '../../commonwidget/text_style.dart';
import '../home/tab/export/buyer_requirenment.dart';
import '../home/tab/export/seller_requirement.dart';

class ExportTabs extends StatefulWidget {
  const ExportTabs({Key? key}) : super(key: key);

  @override
  State<ExportTabs> createState() => _ExportTabsState();
}

class _ExportTabsState extends State<ExportTabs> {
  final appPreferences = Get.find<AppPreferences>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors.coloPageBg,
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
                    TabBar(
                      indicatorColor: MyColors.themeColor,
                      tabs: [
                        Tab(
                            child: Text(
                          'buyer_requirement'.tr,
                          style: TextStyles.headingTexStyle(
                            color: MyColors.themeColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            fontFamily: 'Montserrat',
                          ),
                        )),
                        Tab(
                            child: Text('seller_availability'.tr,
                                style: TextStyles.headingTexStyle(
                                  color: MyColors.themeColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  fontFamily: 'Montserrat',
                                ))),
                      ],
                    ),
                  ],
                ),
              ),
            ],
            body: TabBarView(
              children: [
                BuyerRequirementPage(),
                SellerAvailabilityPage(),
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
