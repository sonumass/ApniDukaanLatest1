import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mcsofttech/models/newandvideo/BannerList.dart';
import 'package:mcsofttech/ui/base/page.dart';
import 'package:mcsofttech/ui/module/news_and_video/widget/new_widget_card.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import '../../../controllers/news/news_controller.dart';
import '../../../models/home/banner.dart';
import '../../../models/product_filter_model.dart';
import '../../../services/navigator.dart';
import '../../../theme/my_theme.dart';
import '../../../utils/ad_helper.dart';
import '../../../utils/analytics.dart';
import '../../../utils/common_util.dart';
import '../../../utils/palette.dart';
import '../../commonwidget/banner_image_carousel.dart';
import '../../commonwidget/text_style.dart';
import '../../dialog/loader.dart';

class NewsScreen extends AppPageWithAppBar {
  static const String routeName = "/newsScreen";

  NewsScreen({Key? key}) : super(key: key);

  static Future<bool?> start<bool>() {
    return navigateTo<bool>(
      routeName,
      currentPageTitle: "News",
    );
  }

  static final List<User> _animals = [
    User(avatar: "", name: "Lion1"),
    User(avatar: "", name: "Lion2"),
    User(avatar: "", name: "Lion3"),
    User(avatar: "", name: "Lion4"),
    User(avatar: "", name: "Lion5"),
  ];
  final filter = false;
  final _items = _animals
      .map((animal) => MultiSelectItem<User>(animal, animal.name ?? ""))
      .toList();
  final controller = Get.put(NewsController());
  final _scrollController = ScrollController();

  void setAtScroll() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        controller.isLoader.value = false;
        controller.callScrollNewsApi(
            pageNo: controller.pageCount, size: 10, type: "news");
      }
    });
  }

  @override
  Widget get body {
   // Analytics.sendCurrentScreen("NewsScreen");
    setAtScroll();
    controller.callNewsApi(pageNo: controller.pageCount, size: 10, type: "news");
    return Obx(() => controller.isLoader.value
        ? const Loader()
        : controller.newsList.isNotEmpty
            ? SingleChildScrollView(
                controller: _scrollController, child: container)
            : const Center(
                child: Text("No Data founded!"),
              ));
  }

  Widget get container {
    return  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            banner,
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 5),
              child: Wrap(
                spacing: 5,
                children: newsList,
              ),
            ),
          ],
        );


  }
  Widget get banner {
    List<BannerList> banner = controller.bannerList;
    List<BannerData> bannerData = <BannerData>[];
    for (BannerList item in banner) {
      bannerData.add(BannerData(bannerId: 1, img: item.img));
    }
    return bannerData.isNotEmpty
        ? BannerCarousel(bannerList: bannerData)
        : const SizedBox.shrink();
  }
  List<Widget> get newsList {
    List<Widget> list = [];
    for (int i = 0; i <= controller.newsList.length-1; i++) {
      list.add(SizedBox(
          height: 110,
          child: SizedBox(
            width: screenWidget,
            child:  NewsCard(newsData:controller.newsList[i],newsList: controller.newsList,initialPage: i,type:"News"),
          )));
      if ((i + 1) % 6 == 0) {
        list.add(SizedBox(
          height: 150,
          child: AdWidget(
            ad: AdHelper.getBannerAd()..load(),
            key: UniqueKey(),
          ),
        ));
      }

    }
    return list;
  }

  Widget allNews(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyles.headingTexStyle(
              color: Palette.colorTextBlack,
              fontWeight: FontWeight.bold,
              fontSize: 14,
              fontFamily: 'Montserrat',
            ),
          ),
          InkWell(
            onTap: () {
              bottomSheet;
            },
            child: SvgPicture.asset("assets/svg/icon_filter.svg"),
          ),
        ],
      ),
    );
  }

  get bottomSheet {
    final List<User> animals = [
      User(avatar: "", name: "Lion"),
      User(avatar: "", name: "Lion2"),
      User(avatar: "", name: "Lion3"),
      User(avatar: "", name: "Lion4"),
      User(avatar: "", name: "Lion5"),
    ];
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(8.0), topLeft: Radius.circular(8.0)),
          side: BorderSide(color: Colors.white)),
      isScrollControlled: true, // required for min/max child size
      context: Get.context!,
      builder: (ctx) {
        return MultiSelectBottomSheet(
          selectedColor: MyColors.themeColor,
          items: _items,
          initialValue: animals,
          onConfirm: (values) {
            Common.showToast(values.toString());
          },
          maxChildSize: 0.8,
          cancelText: cancel,
          confirmText: apply,
        );
      },
    );
  }

  Text get cancel {
    return Text(
      "Reset",
      style: TextStyles.headingTexStyle(
        color: MyColors.themeColor,
        fontWeight: FontWeight.normal,
        fontSize: 14,
        fontFamily: 'Montserrat',
      ),
    );
  }

  Text get apply {
    return const Text(
      "Apply",
      style: TextStyle(
        color: MyColors.themeColor,
        fontWeight: FontWeight.bold,
        fontSize: 14,
        fontFamily: 'Montserrat',
      ),
    );
  }
}
