import 'package:flutter/material.dart';
import 'package:mcsofttech/services/navigator.dart';
import 'package:mcsofttech/theme/my_theme.dart';
import 'package:mcsofttech/ui/base/page.dart';
import 'package:mcsofttech/ui/commonwidget/text_style.dart';
import 'package:mcsofttech/ui/module/meridukaan/shop_order_detail.dart';

class MyShopOrder extends AppPageWithAppBar {
  static String routeName = "/myShopOrder";

  MyShopOrder({Key? key}) : super(key: key);

  static Future<bool?> start<bool>() {
    return navigateTo<bool>(
      routeName,
      currentPageTitle: "My Orders",
    );
  }

  @override
  Widget get body {
    return Scaffold(
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return item();
        },
      ),
    );
  }

  Widget items(VoidCallback onPress, String title) {
    return SizedBox(
      width: screenWidget,
      child: InkWell(
        onTap: onPress,
        child: Card(
          elevation: 3,
          margin:
              const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
          shape: RoundedRectangleBorder(
            side: BorderSide(width: .5, color: MyColors.kColorGrey),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title,
                    maxLines: 2,
                    style: TextStyles.headingTexStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: MyColors.kColorBlack,
                        fontFamily: "assets/font/Oswald-Regular.ttf")),
                const Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: MyColors.themeColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget item() {
    return SizedBox(
      width: screenWidget,
      child: InkWell(
        onTap: () {ShopOrderDetail.start("Order-ID : QE3WR16D3C6DFG6DF");},
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
                  ShopOrderDetail.start("Order-ID : QE3WR16D3C6DFG6DF");
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
                          image:
                              "https://assets.thehansindia.com/h-upload/2022/07/18/1303611-pro.webp")),
                ),
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, right: 20),
                    child: Text("Elzzi Liquied ssdgdfhgfhfgjhjgh dfhgfhfghgfgf",
                        maxLines: 2,
                        style: TextStyles.headingTexStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: MyColors.kColorBlack,
                            fontFamily: "assets/font/Oswald-Regular.ttf")),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, right: 20),
                    child: Text(" Delivered At 14 June 2023",
                        maxLines: 2,
                        style: TextStyles.headingTexStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: MyColors.colorTextGrey,
                            fontFamily: "assets/font/Oswald-Regular.ttf")),
                  ),
                  const SizedBox(
                    height: 5,
                  )
                ],
              )),
              const Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: MyColors.themeColor,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
