import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mcsofttech/ui/module/export/widget/buyer_sub_cat_list_card.dart';
import '../../../controllers/export/buyes_availability_controller.dart';
import '../../../models/export/buyer/SubCat.dart';
import '../../../services/navigator.dart';
import '../../../theme/my_theme.dart';
import '../../base/page.dart';

class BuyerAvailabilityPage extends AppPageWithAppBar{
  static const String routeName = "/BuyerAvailabilityPage";
  BuyerAvailabilityPage({super.key});
  final controller = Get.put(BuyerAvailabilityController());
  static Future<bool?> start<bool>(String title, {subCatList}) {
    return navigateTo<bool>(routeName,
        currentPageTitle: title,
        arguments: {'subCatList': subCatList});
  }
     List<SubCat> subCatList=[];
  @override
  Widget get body {
    subCatList=arguments["subCatList"];
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

                subCatList.isNotEmpty
                    ? Padding(
                  padding: const EdgeInsets.only(left: 10, right: 5),
                  child: Wrap(
                    spacing: 5,
                    children: productList,
                  ),
                )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ));
  }

  List<Widget> get productList {
    List<Widget> list = [];
    for (int i = 0; i <= subCatList.length - 1; i++) {
      list.add(SizedBox(
          height: 110,
          child: SizedBox(
            width: screenWidget,
            child: BuyerSubCatCard(subCat:subCatList[i]),
          )));

    }
    return list;
  }
}