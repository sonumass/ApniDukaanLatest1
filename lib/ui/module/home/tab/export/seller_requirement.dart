import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcsofttech/controllers/export/seller_availabel_controller.dart';
import 'package:mcsofttech/ui/dialog/loader.dart';
import 'package:mcsofttech/ui/module/home/tab/export/widget/seller_card_card.dart';
import '../../../../../theme/my_theme.dart';
import '../../../../../utils/analytics.dart';
import '../../../../base/base_satateless_widget.dart';

class SellerAvailabilityPage extends BaseStateLessWidget {
  SellerAvailabilityPage({Key? key, url}) : super(key: key);
  final controller = Get.put(SellerController());

  @override
  Widget build(BuildContext context) {
    //Analytics.sendCurrentScreen("SellerAvailabilityPage");
    controller.sellerListApi();
    return Obx(() => controller.isLoader.value
        ? const Loader()
        : controller.buyerList.isNotEmpty
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
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 5),
                          child: Wrap(
                            spacing: 5,
                            children: productList,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink());
  }

  List<Widget> get productList {
    List<Widget> list = [];
    for (int i = 0; i <= controller.buyerList.length - 1; i++) {
      list.add(SizedBox(
          height: 150,
          child: SizedBox(
            width: screenWidget,
            child: SellerCard(buyerList: controller.buyerList[i]),
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
}
