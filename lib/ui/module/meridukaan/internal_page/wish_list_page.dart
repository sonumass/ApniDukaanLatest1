import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mcsofttech/ui/base/page.dart';
import 'package:mcsofttech/ui/dialog/loader.dart';
import 'package:mcsofttech/ui/module/cart/widget/wish_list_card.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../controllers/meridhukaan/total_visitor_controller.dart';
import '../../../../controllers/product/product_Detail_controller.dart';
import '../../../../controllers/product/product_list_controller.dart';
import '../../../../data/preferences/AppPreferences.dart';
import '../../../../models/home/AllProduct.dart';
import '../../../../notifire/cart_notifire.dart';
import '../../../../services/navigator.dart';
import '../../../../theme/my_theme.dart';
import '../../../../utils/common_util.dart';
import '../../../../utils/palette.dart';
import '../../../commonwidget/kart_counter.dart';
import '../../../commonwidget/text_style.dart';
import '../../cart/cart_list_page.dart';

class WishListPage extends AppPageWithAppBar {
  static const String routeName = "/WishListPage";

  WishListPage({Key? key}) : super(key: key);

  static Future<bool?> start<bool>(
    String title, {
    allProduct,
  }) {
    return navigateTo<bool>(routeName, currentPageTitle: title, arguments: {
      'allProduct': allProduct,
    });
  }

  final myProducts = [].obs;

  final controller = Get.put(ProductDetailController());
  final controllerProduct = Get.put(ProductController());
  final appPreferences = Get.find<AppPreferences>();
  final wishController = Get.put(TotalVisitorController());
  late AllProduct allProduct;

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
    wishController.callUserDashboardCardCall("Wish");
    return Obx(() => wishController.isLoader.value
        ? const Loader()
        : wishController.equiryList.isNotEmpty
            ? SingleChildScrollView(
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [allNews("All Product"), clearAll],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        if (wishController.equiryList.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 5),
                            child: Wrap(
                              spacing: 5,
                              children: newsList,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink());
  }

  Widget get clearAll {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 10),
      child: Text(
          maxLines: 1,
          "Clear All",
          style: TextStyles.headingTexStyle(
              color: MyColors.kColorRed,
              fontWeight: FontWeight.normal,
              fontSize: 14,
              fontFamily: 'Montserrat')),
    );
  }

  List<Widget> get newsList {
    List<Widget> list = [];
    for (int i = 0; i <= wishController.equiryList.length - 1; i++) {
      list.add(SizedBox(
          height: 110,
          child: SizedBox(
            width: screenWidget,
            child: WishListCard(product: wishController.equiryList[i]),
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
        ],
      ),
    );
  }
}
