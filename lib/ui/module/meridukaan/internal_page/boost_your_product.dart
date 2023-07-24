import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../../../controllers/meridhukaan/boost_product_controller.dart';
import '../../../../controllers/meridhukaan/my_product_controller.dart';
import '../../../../controllers/meridhukaan/total_training_controller.dart';
import '../../../../data/preferences/AppPreferences.dart';
import '../../../../services/navigator.dart';
import '../../../../theme/my_theme.dart';
import '../../../../utils/common_util.dart';
import '../../../base/page.dart';
import '../../../commonwidget/text_style.dart';

class BoostYourProduct extends AppPageWithAppBar {
  static const String routeName = "/boostYourProduct";

  BoostYourProduct({Key? key}) : super(key: key);

  static Future<bool?> start<bool>(
    String title,String productID
  ) {
    return navigateTo<bool>(routeName, currentPageTitle: title,arguments: {"productID":productID});
  }

  final controller = Get.put(TotalTrainingController());
  final appPreferences = Get.find<AppPreferences>();



  @override
  Widget get body {
    return SafeArea(
      child: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: screenWidget,
              height: 150,
              child: Container(
                color: MyColors.themeColor,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Icon(
                      Icons.local_offer,
                      color: MyColors.yellowCard,
                      size: 80,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Reach more buyer and sell faster",
                      textAlign: TextAlign.start,
                      style: TextStyles.headingTexStyle(
                          color: MyColors.kColorWhite, fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: screenWidget,
              child: InkWell(
                onTap: () {
                  controller.createOrderId(49 * 100,arguments["productID"]);
                },
                child: Card(
                  margin: const EdgeInsets.only(top: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: firstCard,
                ),
              ),
            ),
            SizedBox(
              width: screenWidget,
              child: InkWell(
                onTap: () {
                  controller.createOrderId(99 * 100,arguments["productID"]);

                },
                child: Card(
                  margin: const EdgeInsets.only(top: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: secondCard,
                ),
              ),
            ),
            SizedBox(
              width: screenWidget,
              child: InkWell(
                onTap: () {
                  controller.createOrderId(299 * 100,arguments["productID"]);
                  },
                child: Card(
                  margin: const EdgeInsets.only(top: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: thirdCard,
                ),
              ),
            )
          ],
        ),
      )),
    );
  }

  Widget get firstCard {
    return Container(
      decoration: const BoxDecoration(
          color: MyColors.pink,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Boost Ad for 3 days",
                  textAlign: TextAlign.start,
                  style:
                      TextStyles.headingTexStyle(color: MyColors.kColorWhite),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Reach up to 2 time for other buyers",
                  style: TextStyles.headingTexStyle(
                      color: MyColors.kColorWhite,
                      fontSize: 12,
                      fontStyle: FontStyle.normal),
                )
              ],
            ),
            Text(
              "\u{20B9} 49",
              style: TextStyles.headingTexStyle(color: MyColors.kColorWhite),
            )
          ],
        ),
      ),
    );
  }

  Widget get secondCard {
    return Container(
      decoration: const BoxDecoration(
          color: MyColors.blue,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Boost Ad for 7 days",
                  textAlign: TextAlign.start,
                  style:
                      TextStyles.headingTexStyle(color: MyColors.kColorWhite),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Reach up to 5 time for other buyers",
                  style: TextStyles.headingTexStyle(
                      color: MyColors.kColorWhite,
                      fontSize: 12,
                      fontStyle: FontStyle.normal),
                )
              ],
            ),
            Text(
              "\u{20B9} 99",
              style: TextStyles.headingTexStyle(color: MyColors.kColorWhite),
            )
          ],
        ),
      ),
    );
  }

  Widget get thirdCard {
    return Container(
      decoration: const BoxDecoration(
          color: MyColors.yellowCard,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Boost Ad for 30 days",
                  textAlign: TextAlign.start,
                  style:
                      TextStyles.headingTexStyle(color: MyColors.kColorWhite),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Reach up to 20 time for other buyers",
                  style: TextStyles.headingTexStyle(
                      color: MyColors.kColorWhite,
                      fontSize: 12,
                      fontStyle: FontStyle.normal),
                )
              ],
            ),
            Text(
              "\u{20B9} 299",
              style: TextStyles.headingTexStyle(color: MyColors.kColorWhite),
            )
          ],
        ),
      ),
    );
  }


}
