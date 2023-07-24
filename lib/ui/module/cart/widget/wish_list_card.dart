import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcsofttech/constants/Constant.dart';
import 'package:mcsofttech/theme/my_theme.dart';
import 'package:mcsofttech/ui/base/base_satateless_widget.dart';
import '../../../../controllers/meridhukaan/add_user_action_controller.dart';
import '../../../../controllers/meridhukaan/total_visitor_controller.dart';
import '../../../../controllers/product/product_Detail_controller.dart';
import '../../../../controllers/product/product_list_controller.dart';
import '../../../../data/preferences/AppPreferences.dart';
import '../../../../models/meridukaan/userdashboard/Equiry.dart';
import '../../../../utils/common_util.dart';
import '../../../../utils/palette.dart';
import '../../../commonwidget/text_style.dart';
import '../../login/login_page.dart';

class WishListCard extends BaseStateLessWidget {
  final controller = Get.put(ProductDetailController());
  final controllerProduct = Get.put(ProductController());
  final appPreferences = Get.find<AppPreferences>();
  final wishController = Get.find<TotalVisitorController>();
  final userActionController = Get.put(AddUserActionController());

  WishListCard({Key? key, required this.product}) : super(key: key);
  final Equiry product;

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
                        image:
                            "${Constant.baseUrl}${product.productImg.isNotEmpty ? product.productImg : "/img/product/noaImg2.png"}")),
              ),
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [header, delete],
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0, right: 20),
                  child: Row(
                    children: [
                      Text("\u{20B9} ${product.price}",
                          style: TextStyles.headingTexStyle(
                              fontSize: 12,
                              color: Palette.appColor,
                              fontFamily: "assets/font/Oswald-Regular.ttf")),
                      const SizedBox(
                        width: 5,
                      ),
                      /*Text("\u{20B9} 26000",
                          style: TextStyles.headingTexStyle(
                              fontSize: 12,
                              decoration: TextDecoration.lineThrough,
                              color: Palette.kColorRed,
                              fontFamily: "assets/font/Oswald-Regular.ttf"))*/
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                addToCarAndBuyNow,
              ],
            )),
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
          product.productName,
          style: TextStyles.headingTexStyle(
              color: MyColors.themeColor,
              fontWeight: FontWeight.bold,
              fontSize: 14,
              fontFamily: 'Montserrat')),
    );
  }

  Widget get delete {
    return InkWell(
      onTap: () {
        wishController.deleteAction("Wish", product.product_id, product.id);
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 0, right: 10),
        child: Icon(
          Icons.delete,
          color: MyColors.kColorRed,
        ),
      ),
    );
  }

  Widget get addToCarAndBuyNow {
    return Row(
      children: [
        InkWell(
          onTap: () {
            if (appPreferences.isLoggedIn) {
              controller.productAdd(product, 1);
            } else {
              LoginPage.start();
            }
            userActionController.userActionApi(
                product.productName,
                product.price.toString(),
                product.subCategory,
                product.product_id,
                "Cart",
                product.mobile,
                "cart",
                product.product_user_id.toString(),
                product.productImg,
                "",
                product.qunatity.toString());
          },
          child: Container(
            decoration: BoxDecoration(
                color: MyColors.themeColor,
                borderRadius: BorderRadius.circular(5.0)),
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
              child: Text(
                "ADD TO CART",
                style: TextStyles.labelTextStyle(
                    fontSize: 10, color: MyColors.kColorWhite),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        InkWell(
          onTap: () {
            Common.showToast("Coming soon");
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
      ],
    );
  }
}
