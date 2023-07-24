import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:mcsofttech/models/newandvideo/Images.dart';
import 'package:mcsofttech/ui/module/news_and_video/widget/image_at_news_detail_carousel.dart';
import 'package:mcsofttech/utils/common_util.dart';
import 'package:mcsofttech/utils/palette.dart';
import '../../../models/home/banner.dart';
import '../../../models/newandvideo/News.dart';
import '../../../services/navigator.dart';
import '../../../theme/my_theme.dart';
import '../../base/page.dart';
import '../../commonwidget/text_style.dart';

class NewsDetails extends AppPageWithAppBar {
  static const String routeName = "/newsDetails";

  NewsDetails({Key? key}) : super(key: key);

  static Future<bool?> start<bool>(
      String newsDetail, List<News> newsList, int initialPage) {
    return navigateTo<bool>(routeName,
        currentPageTitle: newsDetail,
        arguments: {"newsList": newsList, "initialPage": initialPage});
  }

  RxInt previousPage = 0.obs;

  @override
  Widget get body {
    final PageController controller =
        PageController(initialPage: arguments["initialPage"]);
    return PageView(
      controller: controller,
      onPageChanged: _onPageViewChange,
      children: listPage,
    );
  }

  _onPageViewChange(int page) {
    previousPage.value = page;
    if (page != 0) {
      previousPage--;
    } else {
      previousPage.value = 2;
    }
  }

  Widget imageCarousal(News newsData) {
    List<Images> imageList = newsData.images;
    List<BannerData> bannerData = <BannerData>[];
    for (Images item in imageList) {
      bannerData.add(BannerData(bannerId: 1, img: item.filePath));
    }
    return bannerData.isNotEmpty
        ? NewsImageCarousel(bannerList: bannerData)
        : const SizedBox.shrink();
  }

  List<Widget> get listPage {
    List<Widget> widgetsList = [];
    for (var element in arguments["newsList"]) {
      widgetsList.add(setWidget(element));
    }
    return widgetsList;
  }

  Widget setWidget(News newsData) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          imageCarousal(newsData),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Card(
                color: Palette.kColorGreen,
                margin: const EdgeInsets.only(left: 10),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(newsData.catIds,
                      maxLines: 2,
                      style: TextStyles.headingTexStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: MyColors.kColorWhite,
                          fontFamily: "assets/font/Oswald-Regular.ttf")),
                ),
              ),
              Row(children: [InkWell(
                onTap: () {
                  Common.share(linkUrl: "https://f2df.com/krishi-darshan/news/details?id=${newsData.id}",title: newsData.heading);
                },

                child: const Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(Icons.bookmark_border,color: Palette.kTextColorBlue,size: 40,),
                ),
              ),InkWell(
                onTap: () {
                  Common.share(linkUrl: "https://f2df.com/krishi-darshan/news/details?id=${newsData.id}",title: newsData.heading);
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: SvgPicture.asset("assets/svg/icon_share.svg"),
                ),
              )],)
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Text(newsData.createDate,
                maxLines: 2,
                style: TextStyles.headingTexStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: MyColors.kColorBlack,
                    fontFamily: "assets/font/Oswald-Regular.ttf")),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 0, right: 20, top: 10),
            child: Html(data: newsData.details),
          ),
          const SizedBox(
            height: 5,
          )
        ],
      ),
    );
  }

  Widget category(String catName) {
    return Card(
      color: Palette.kColorGreen,
      margin: const EdgeInsets.all(10),
      child: Text(catName),
    );
  }
}
