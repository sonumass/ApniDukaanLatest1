import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mcsofttech/ui/dialog/loader.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../controllers/meridhukaan/total_training_controller.dart';
import '../../../../notifire/cart_notifire.dart';
import '../../../../services/navigator.dart';
import '../../../../theme/my_theme.dart';
import '../../../../utils/common_util.dart';
import '../../../base/page.dart';
import '../../../commonwidget/kart_counter.dart';
import '../../../commonwidget/text_style.dart';
import '../../cart/cart_list_page.dart';
import '../../product/product_search_page.dart';

class TotalTraining extends AppPageWithAppBar {
  static const String routeName = "/totalTraining";

  TotalTraining({Key? key}) : super(key: key);

  static Future<bool?> start<bool>(
    String title,
  ) {
    return navigateTo<bool>(routeName, currentPageTitle: title);
  }

  final controller = Get.put(TotalTrainingController());

  @override
  List<Widget>? get action => [
        InkWell(
          onTap: () {
            showDialog(
                context: Get.context!,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Select Language'),
                    content: Common.languageAlertDialoagContainer(),
                  );
                });
          },
          child: Padding(
            padding:
                const EdgeInsets.only(left: 0, right: 15, top: 8, bottom: 8),
            child: Stack(
              children: [
                Align(
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                        width: 25, height: 25, 'assets/png/icon_lang.svg')),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () async => await launchUrl(
              Uri.parse("whatsapp://send?phone=+919138111860&text=hello")),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 0, right: 15, top: 8, bottom: 8),
            child: Stack(
              children: [
                Align(
                    alignment: Alignment.center,
                    child: SvgPicture.asset("assets/png/icon_chat_app.svg")),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            CartListPage.start("my_cart".tr);
            /* if (appPreferences.isLoggedIn) {
               // KartStorePage.start();
              } else {
              //  LogInScreen.start();
              }*/
          },
          child: Padding(
            padding:
                const EdgeInsets.only(left: 0, right: 15, top: 8, bottom: 8),
            child: Stack(
              children: [
                Align(
                    alignment: Alignment.center,
                    child: SvgPicture.asset('assets/png/icon_cart.svg')),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: KartCounter(
                    count: Provider.of<CartNotifier>(Get.context!)
                        .productList
                        .length,
                  ),
                )
              ],
            ),
          ),
        ),
      ];

  @override
  Widget get body {
    controller.callTotalTraining();
    return Obx(() => controller.isLoader.value
        ? const Loader()
        : controller.trainingList.isNotEmpty
            ? CustomScrollView(
                shrinkWrap: true,
                slivers: <Widget>[
                  SliverPadding(
                    padding: const EdgeInsets.all(0.0),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate(
                        listItem,
                      ),
                    ),
                  ),
                ],
              )
            : Center(
                child: Text(
                  "No Data Found!",
                  style: TextStyles.headingTexStyle(color: MyColors.kColorRed),
                ),
              ));
  }

  Widget get searchView {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: GestureDetector(
          onTap: () {
            ProductSearchList.start("Products",
                fromPage: "home", banner: controller.appPreferences.banner);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: screenWidget / 1.28,
                height: 50,
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Center(
                    child: TextField(
                      enabled: false,
                      textAlign: TextAlign.left,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintStyle: TextStyles.headingTexStyle(
                            color: MyColors.kColorGrey,
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Montserrat'),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(12),
                          child: InkWell(
                            onTap: () {
                              ProductSearchList.start("Products",
                                  fromPage: "home",
                                  banner: controller.appPreferences.banner);
                            },
                            child:
                                SvgPicture.asset('assets/svg/icon_search.svg'),
                          ),
                        ),
                        hintText: 'product_category'.tr,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 3,
                child:
                    SvgPicture.asset(height: 40, 'assets/svg/icon_filter.svg'),
              )
            ],
          )),
    );
  }

  Widget get headerRow {
    return Container(
      color: MyColors.kColorExtraLightGrey,
      child: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                width: screenWidget / 4,
                child: Text(
                  "Date",
                  textAlign: TextAlign.center,
                  style: TextStyles.headingTexStyle(
                    color: MyColors.themeColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                  ),
                )),
            SizedBox(
                width: screenWidget / 4,
                child: Text(
                  "Venue",
                  textAlign: TextAlign.center,
                  style: TextStyles.headingTexStyle(
                    color: MyColors.themeColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                  ),
                )),
            SizedBox(
                width: screenWidget / 4,
                child: Text(
                  "Training Name",
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyles.headingTexStyle(
                    color: MyColors.themeColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                  ),
                )),
            SizedBox(
                width: screenWidget / 4,
                child: Text(
                  "Certificate",
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyles.headingTexStyle(
                    color: MyColors.themeColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                  ),
                )),
          ],
        ),
      ),
    );
  }

  List<Widget> get listItem {
    List<Widget> list = [searchView, headerRow];
    controller.trainingList.forEach((element) {
      list.add(Container(
        color: MyColors.kColorWhite,
        child: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: screenWidget / 5,
                      child: Text(
                        Common.dateParsing(element.updateDate),
                        textAlign: TextAlign.center,
                        style: TextStyles.headingTexStyle(
                          color: MyColors.colorTextGrey,
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Montserrat',
                        ),
                      )),
                  SizedBox(
                      width: screenWidget / 5,
                      child: Text(
                        element.venue,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyles.headingTexStyle(
                          color: MyColors.colorTextGrey,
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Montserrat',
                        ),
                      )),
                  SizedBox(
                    width: screenWidget / 5,
                    child: Text(
                      element.trainingName,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyles.headingTexStyle(
                        color: MyColors.themeColor,
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                  SizedBox(
                      width: screenWidget / 5,
                      child: Text(
                        element.certificate,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyles.headingTexStyle(
                          color: MyColors.colorTextGrey,
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Montserrat',
                        ),
                      )),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                color: MyColors.colorTextGrey,
              )
            ],
          ),
        ),
      ));
    });

    return list;
  }
}
