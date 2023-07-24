import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcsofttech/ui/module/home/tab/export/widget/buyer_requirement_card.dart';
import 'package:weather/weather.dart';
import '../../../../../controllers/export/buyes_requirement_controller.dart';
import '../../../../../theme/my_theme.dart';
import '../../../../../utils/analytics.dart';
import '../../../../../utils/palette.dart';
import '../../../../base/base_satateless_widget.dart';
import '../../../../commonwidget/text_style.dart';

class BuyerRequirementPage extends BaseStateLessWidget {
  BuyerRequirementPage({Key? key, url}) : super(key: key);
  final controller = Get.put(BuyerController());

  @override
  Widget build(BuildContext context) {
   // Analytics.sendCurrentScreen("BuyerRequirementPage");
    /* WeatherFactory wf =  WeatherFactory("e4QfAepAOmgZSpu7RfETDBdP1VjB2quP", language: Language.HINDI);

   wf.currentWeatherByLocation(28.588815,77.791813).then((value) => debugPrint("sonu ${value.weatherDescription}"));*/
    controller.buyerRequirementApi();

    return SingleChildScrollView(
        child: Container(
      color: MyColors.coloPageBg,
      child: SizedBox(
        width: screenWidget,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            couldNotFindAnyThing(context),
            const SizedBox(
              height: 10,
            ),
            Obx(() => controller.buyerList.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(left: 10, right: 5),
                    child: Wrap(
                      spacing: 5,
                      children: productList,
                    ),
                  )
                : const SizedBox.shrink()),
          ],
        ),
      ),
    ));
  }

  List<Widget> get productList {
    List<Widget> list = [];
    for (int i = 0; i <= controller.buyerList.length - 1; i++) {
      list.add(SizedBox(
          height: 110,
          child: SizedBox(
            width: screenWidget,
            child: BuyerRequirementCard(buyerList: controller.buyerList[i]),
          )));
      /*if ((i + 1) % 6 == 0) {
        list.add(SizedBox(
          height: 150,
          child: AdWidget(
            ad: AdHelper.getBannerAd()..load(),
            key: UniqueKey(),
          ),
        ));
      }*/
    }
    return list;
  }

  Widget couldNotFindAnyThing(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Can't find any thing?",
                style: TextStyles.headingTexStyle(
                  color: Palette.colorTextBlack,
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  fontFamily: 'Montserrat',
                ),
              ),
              InkWell(
                onTap: () {
                  controller.showPriceSheet(
                      context, screenHeight, screenWidget,"");
                },
                child: Text(
                  "Add you requirement",
                  style: TextStyles.headingTexStyle(
                    color: MyColors.themeColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
