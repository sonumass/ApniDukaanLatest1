import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:mcsofttech/utils/palette.dart';
import '../../../constants/Constant.dart';
import '../../../models/testimonial/Testimonial.dart';
import '../../../services/navigator.dart';
import '../../../theme/my_theme.dart';
import '../../base/page.dart';
import '../../commonwidget/text_style.dart';

class TestimonialDetails extends AppPageWithAppBar {
  static const String routeName = "/testimonialDetails";

  TestimonialDetails({Key? key}) : super(key: key);

  static Future<bool?> start<bool>(
      String newsDetail, List<Testimonial> newsList, int initialPage) {
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
  List<Widget> get listPage {
    List<Widget> widgetsList = [];
    for (var element in arguments["newsList"]) {
      widgetsList.add(setWidget(element));
    }
    return widgetsList;
  }

  Widget setWidget(Testimonial listData) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 5,
          ),
          Row(crossAxisAlignment:CrossAxisAlignment.start,children: [Padding(padding: const EdgeInsets.all(10),child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/png/app_logo.png',
              image: "${Constant.baseUrl}${listData.img}",
              fit: BoxFit.cover,
              height: 100.0,
            ),
          ),),Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10,),
              Card(
                color: Palette.kColorGreen,
                margin: const EdgeInsets.only(left: 0),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(listData.name,
                      maxLines: 2,
                      style: TextStyles.headingTexStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: MyColors.kColorWhite,
                          fontFamily: "assets/font/Oswald-Regular.ttf")),
                ),
              ),
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(left: 0, right: 10),
                child: Text(listData.degination,
                    maxLines: 2,
                    style: TextStyles.headingTexStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: MyColors.kColorBlack,
                        fontFamily: "assets/font/Oswald-Regular.ttf")),
              ),
            ],
          ),],),
          const SizedBox(
            height: 10,
          ),

          Padding(
            padding: const EdgeInsets.only(left: 0, right: 20, top: 0),
            child: Html(data: listData.desc),
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
