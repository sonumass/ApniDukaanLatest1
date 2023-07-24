import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcsofttech/constants/Constant.dart';
import 'package:mcsofttech/controllers/export/buyes_requirement_controller.dart';
import 'package:mcsofttech/theme/my_theme.dart';
import 'package:mcsofttech/ui/base/base_satateless_widget.dart';
import '../../../../models/export/buyer/SubCat.dart';
import '../../../commonwidget/text_style.dart';

class BuyerSubCatCard extends BaseStateLessWidget {
  final SubCat subCat;

  BuyerSubCatCard({Key? key, required this.subCat}) : super(key: key);
  final controller = Get.find<BuyerController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenWidget,
      child: InkWell(onTap: (){},child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: .5, color: MyColors.kColorGrey),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 8, bottom: 10),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: FadeInImage.assetNetwork(
                        width: 78,
                        height: 78,
                        fit: BoxFit.fill,
                        placeholder: "assets/png/placeholder.png",
                        image: "${Constant.baseUrl}/${subCat.subCategoryImg}")),
              ),
            ),
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        header,
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0, right: 20),
                      child: Row(
                        children: [
                          Text("Qty:${subCat.quantity} ${subCat.type}",
                              style: TextStyles.headingTexStyle(
                                color: MyColors.colorTextGrey,
                                fontWeight: FontWeight.normal,
                                fontSize: 14,
                                fontFamily: 'Montserrat',
                              )),
                          const SizedBox(
                            width: 5,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: buyNow,
            ),
          ],
        ),
      ),),
    );
  }

  Widget get header {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 10),
      child: Text(
          maxLines: 1,
          subCat.subCategoryName,
          style: TextStyles.headingTexStyle(
              color: MyColors.themeColor,
              fontWeight: FontWeight.bold,
              fontSize: 14,
              fontFamily: 'Montserrat')),
    );
  }

  Widget get buyNow {
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: () {
          controller.showPriceSheet(Get.context, screenHeight, screenWidget,"");
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: MyColors.themeColor, width: 1),
              color: MyColors.kColorWhite,
              borderRadius: BorderRadius.circular(5.0)),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
            child: Text(
              "BUY NOW",
              style: TextStyles.labelTextStyle(
                  fontSize: 10, color: MyColors.themeColor),
            ),
          ),
        ),
      ),
    );
  }
}
