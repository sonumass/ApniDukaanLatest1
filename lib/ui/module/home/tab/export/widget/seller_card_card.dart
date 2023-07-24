import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcsofttech/constants/Constant.dart';
import 'package:mcsofttech/controllers/export/seller_availabel_controller.dart';
import 'package:mcsofttech/theme/my_theme.dart';
import 'package:mcsofttech/ui/base/base_satateless_widget.dart';
import '../../../../../../models/export/buyer_list.dart';
import '../../../../../commonwidget/text_style.dart';

class SellerCard extends BaseStateLessWidget {
  final controller = Get.find<SellerController>();
  final BuyerList buyerList;

  SellerCard({Key? key, required this.buyerList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenWidget,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: .5, color: MyColors.kColorGrey),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 10, bottom: 10),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: FadeInImage.assetNetwork(
                        width: 78,
                        height: 78,
                        fit: BoxFit.fill,
                        placeholder: "assets/png/placeholder.png",
                        image: "${Constant.baseUrl}/img/product/noaImg2.png")),
              ),
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                header,
                const SizedBox(
                  height: 5,
                ),
                sellerName,
                const SizedBox(
                  height: 5,
                ),
                quantity,
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0, right: 20),
                  child: Row(
                    children: [
                      Text("Price:\u{20B9} ${buyerList.offerPrice}",
                          style: TextStyles.headingTexStyle(
                              color: MyColors.colorTextGrey,
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                              fontFamily: 'Montserrat')),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                location,
                const SizedBox(
                  height: 10,
                ),
              ],
            )),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: connect,
            ),
          ],
        ),
      ),
    );
  }

  Widget get header {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 10),
      child: Text(
          maxLines: 1,
          buyerList.productName,
          style: TextStyles.headingTexStyle(
              color: MyColors.themeColor,
              fontWeight: FontWeight.bold,
              fontSize: 14,
              fontFamily: 'Montserrat')),
    );
  }

  Widget get sellerName {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 10),
      child: Text(
          maxLines: 1,
          "Name:${buyerList.name}",
          style: TextStyles.headingTexStyle(
              color: MyColors.colorTextGrey,
              fontWeight: FontWeight.normal,
              fontSize: 14,
              fontFamily: 'Montserrat')),
    );
  }

  Widget get quantity {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 10),
      child: Text(
          maxLines: 1,
          "Qty: ${buyerList.quantity}",
          style: TextStyles.headingTexStyle(
              color: MyColors.colorTextGrey,
              fontWeight: FontWeight.normal,
              fontSize: 14,
              fontFamily: 'Montserrat')),
    );
  }

  Widget get location {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 10),
      child: Text(
          maxLines: 1,
          "Location: ${buyerList.location}",
          style: TextStyles.headingTexStyle(
              color: MyColors.colorTextGrey,
              fontWeight: FontWeight.normal,
              fontSize: 14,
              fontFamily: 'Montserrat')),
    );
  }

  Widget get connect {
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
              "Connect",
              style: TextStyles.labelTextStyle(
                  fontSize: 10, color: MyColors.themeColor),
            ),
          ),
        ),
      ),
    );
  }
}
