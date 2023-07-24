import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import 'package:mcsofttech/constants/Constant.dart';
import 'package:mcsofttech/models/home/AllProduct.dart';
import 'package:mcsofttech/theme/my_theme.dart';

import 'package:mcsofttech/ui/base/base_satateless_widget.dart';
import 'package:mcsofttech/ui/module/product/product_detail.dart';

import '../../../../../controllers/meridhukaan/add_user_action_controller.dart';
import '../../../../../controllers/product/product_Detail_controller.dart';
import '../../../../../data/preferences/AppPreferences.dart';
import '../../../../../models/product_filter_model.dart';
import '../../../../../utils/palette.dart';
import '../../../../commonwidget/text_style.dart';
import '../../../login/login_page.dart';

class BestSellarCard extends BaseStateLessWidget {
  BestSellarCard(this.recommdedProduct);

  final AllProduct recommdedProduct;
  final userActionController = Get.put(AddUserActionController());
  final controller = Get.put(ProductDetailController());
  final appPreferences = Get.find<AppPreferences>();

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
              onTap: () {
                ProductDetail.start("Product Detail",
                    allProduct: recommdedProduct);
              },
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
                        image: recommdedProduct.img1.isNotEmpty
                            ? Constant.baseUrl + recommdedProduct.img1
                            : "${Constant.baseUrl}/img/product/noaImg2.png")),
              ),
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                productName,
                Padding(
                  padding: const EdgeInsets.only(left: 0, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: SizedBox(
                        width: screenWidget / 4,
                        child: Row(
                          children: [
                            Text("\u{20B9} ${recommdedProduct.productFee}",
                                style: TextStyles.headingTexStyle(
                                    fontSize: 10,
                                    color: Palette.appColor,
                                    fontFamily:
                                        "assets/font/Oswald-Regular.ttf")),
                            const SizedBox(
                              width: 7,
                            ),
                            Text("\u{20B9} ${recommdedProduct.oldFee}",
                                style: TextStyles.headingTexStyle(
                                    fontSize: 10,
                                    decoration: TextDecoration.lineThrough,
                                    color: Palette.kColorRed,
                                    fontFamily:
                                        "assets/font/Oswald-Regular.ttf")),
                          ],
                        ),
                      )),
                      InkWell(
                        onTap: () {
                          if (appPreferences.isLoggedIn) {
                            controller.addToCart(recommdedProduct);
                          } else {
                            LoginPage.start();
                          }

                          userActionController.userActionApi(
                              recommdedProduct.productName,
                              (recommdedProduct.productFee * 1).toString(),
                              recommdedProduct.subCategory?.subCategoryName ??
                                  "",
                              recommdedProduct.p_id,
                              "Cart",
                              recommdedProduct.mobile,
                              "cart",
                              recommdedProduct.userId.toString(),
                              recommdedProduct.img1,
                              "",
                              "1");
                        },
                        child: Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: .5, color: MyColors.kColorGrey),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Text(
                              "ADD TO CART",
                              style: TextStyles.labelTextStyle(
                                  color: MyColors.themeColor,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Montserrat',
                                  fontSize: 10),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                )
              ],
            )),
          ],
        ),
      ),
    );
  }

  Widget get productName {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 10),
      child: Text(
          maxLines: 1,
          recommdedProduct.subCategory?.subCategoryName ?? "",
          style: TextStyles.headingTexStyle(
              color: Palette.colorTextBlack,
              fontWeight: FontWeight.normal,
              fontSize: 14,
              fontFamily: 'Montserrat')),
    );
  }

  Widget favouriteRow() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Card(
              color: Palette.appColor,
              margin: const EdgeInsets.all(5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: const Padding(
                padding: EdgeInsets.all(3),
                child: Text(
                  " Featured",
                  style: TextStyle(color: Palette.colorWhite),
                ),
              )),
          const Icon(
            Icons.favorite,
            color: Palette.kColorRed,
          )
        ],
      ),
    );
  }

  void openFilterDialog() async {
    List<User> userList = [
      User(name: "Jon", avatar: ""),
      User(name: "Lindsey ", avatar: ""),
      User(name: "Valarie ", avatar: ""),
      User(name: "Elyse ", avatar: ""),
      User(name: "Ethel ", avatar: ""),
      User(name: "Emelyan ", avatar: ""),
      User(name: "Catherine ", avatar: ""),
      User(name: "Stepanida  ", avatar: ""),
      User(name: "Carolina ", avatar: ""),
      User(name: "Nail  ", avatar: ""),
      User(name: "Kamil ", avatar: ""),
      User(name: "Mariana ", avatar: ""),
      User(name: "Katerina ", avatar: ""),
    ];

    List<User> selectedUserList = [];
    await FilterListDialog.display<User>(
      Get.context!,
      listData: userList,
      selectedListData: selectedUserList,
      choiceChipLabel: (user) => user!.name,
      validateSelectedItem: (list, val) => list!.contains(val),
      onItemSearch: (user, query) {
        return user.name!.toLowerCase().contains(query.toLowerCase());
      },
      onApplyButtonClick: (list) {
        selectedUserList = List.from(list!);

        Get.back();
      },
    );
  }
}
