import 'package:flutter/material.dart';
import 'package:mcsofttech/services/navigator.dart';
import 'package:mcsofttech/theme/my_theme.dart';
import 'package:mcsofttech/ui/base/page.dart';
import 'package:mcsofttech/ui/commonwidget/text_style.dart';
import 'package:mcsofttech/ui/module/profile/profile_page.dart';
import 'package:mcsofttech/utils/palette.dart';
import 'package:order_tracker/order_tracker.dart';

import 'my_order.dart';
import 'order_tracking.dart';

class OrderDetail extends AppPageWithAppBar {
  static String routeName = "/order_detail";

  OrderDetail({Key? key}) : super(key: key);

  static Future<bool?> start<bool>(String orderId) {
    return navigateTo<bool>(routeName,
        currentPageTitle: "Order Details", arguments: {"orderId": orderId});
  }

  List<TextDto> orderList = [
    TextDto("Your order has been placed", "Fri, 25th Mar '22 - 10:47pm"),
    TextDto("Seller ha processed your order", "Sun, 27th Mar '22 - 10:19am"),
    TextDto("Your item has been picked up by courier partner.",
        "Tue, 29th Mar '22 - 5:00pm"),
  ];

  List<TextDto> shippedList = [
    TextDto("Your order has been shipped", "Tue, 29th Mar '22 - 5:04pm"),
    TextDto("Your item has been received in the nearest hub to you.", null),
  ];

  List<TextDto> outOfDeliveryList = [
    TextDto("Your order is out for delivery", "Thu, 31th Mar '22 - 2:27pm"),
  ];

  List<TextDto> deliveredList = [
    TextDto("Your order has been delivered", "Thu, 31th Mar '22 - 3:58pm"),
  ];

  @override
  Widget get body {
    return Scaffold(
      body: Padding(padding: const EdgeInsets.all(20),child: CustomScrollView(
          physics:const  BouncingScrollPhysics(),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            wrapSliver(orderId),
            wrapSliver(divider),
            wrapSliver(orderProductList),
            wrapSliver(trackOrder),
            wrapSliver(const Padding(padding:  EdgeInsets.only(top: 20))),
            wrapSliver(cancelOrder),
            //wrapSliver(orderTracker),
            wrapSliver(const Padding(padding:  EdgeInsets.only(top: 20))),
            wrapSliver(divider),
            wrapSliver(const Padding(padding:  EdgeInsets.only(top: 10))),
            wrapSliver(returnPolicyEnded),

            wrapSliver(const Padding(padding:  EdgeInsets.only(top: 10))),
            wrapSliver(divider),
            wrapSliver(const Padding(padding:  EdgeInsets.only(top: 10))),
            wrapSliver(needHelp),
            wrapSliver(const Padding(padding:  EdgeInsets.only(top: 10))),
            wrapSliver(invoiceDownload),


          ]),)
    );
  }
Widget wrapSliver(Widget child){
    return SliverPadding(padding: const EdgeInsets.only(top: 10),sliver: SliverToBoxAdapter(child: child,),);
}
  Widget get orderId {
    return Text("Order-ID : QE3WR16D3C6DFG6DF",
        maxLines: 2,
        style: TextStyles.headingTexStyle(
            fontSize: 20,
            fontWeight: FontWeight.normal,
            color: MyColors.colorTextGrey,
            fontFamily: "assets/font/Oswald-Regular.ttf"));
  }

  Widget get divider {
    return const Divider(
      color: MyColors.colorTextGrey,
      height: 2,
    );
  }

  Widget get orderProductList {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 1,
      itemBuilder: (BuildContext context, int index) {
        return item();
      },
    );
  }

  Widget item() {
    return SizedBox(
        width: screenWidget,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0, right: 20),
                      child: Text(
                          "Elzzi Liquied ssdgdfhgfhfgjhjgh dfhgfhfghgfgf",
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
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0, right: 20),
                      child: Text(" Seller : The Dry State",
                          maxLines: 2,
                          style: TextStyles.headingTexStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: MyColors.colorTextGrey,
                              fontFamily: "assets/font/Oswald-Regular.ttf")),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0, right: 20),
                      child: Text(" \u{20B9} 299",
                          maxLines: 2,
                          style: TextStyles.headingTexStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: MyColors.kColorBlack,
                              fontFamily: "assets/font/Oswald-Regular.ttf")),
                    ),
                  ],
                )),
                Padding(
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
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            divider
          ],
        ));
  }

  Widget get orderTracker {
    return OrderTracker(
      status: Status.delivered,
      activeColor: Colors.green,
      inActiveColor: Colors.grey[300],
      orderTitleAndDateList: orderList,
      shippedTitleAndDateList: shippedList,
      outOfDeliveryTitleAndDateList: outOfDeliveryList,
      deliveredTitleAndDateList: deliveredList,
    );
  }
  Widget get returnPolicyEnded {
    return Text("Return policy ended at on June 16",
        maxLines: 2,
        style: TextStyles.headingTexStyle(
            fontSize: 20,
            fontWeight: FontWeight.normal,
            color: MyColors.colorTextGrey,
            fontFamily: "assets/font/Oswald-Regular.ttf"));
  }
  Widget get trackOrder {
    return InkWell(onTap: (){OrderTracking.start();},child: Container(padding:const EdgeInsets.all(20),color: Palette.lineColor,child: Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children: [Text("Track you order",
        maxLines: 2,
        style: TextStyles.headingTexStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: MyColors.kColorBlack,
            fontFamily: "assets/font/Oswald-Regular.ttf")),const Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: EdgeInsets.only(right: 10),
        child: Icon(
          Icons.arrow_forward_ios_outlined,
          color: MyColors.themeColor,
        ),
      ),
    )],),),);
  }
  Widget get cancelOrder {
    return Container(padding:const EdgeInsets.all(20),color: Palette.lineColor,child: Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children: [Text("Cancel Order?",
        maxLines: 2,
        style: TextStyles.headingTexStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: MyColors.kColorBlack,
            fontFamily: "assets/font/Oswald-Regular.ttf")),const Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: EdgeInsets.only(right: 10),
        child: Icon(
          Icons.arrow_forward_ios_outlined,
          color: MyColors.themeColor,
        ),
      ),
    )],),);
  }
  Widget get needHelp {
    return Text("Need Help?",
        maxLines: 2,
        style: TextStyles.headingTexStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: MyColors.appColor,
            fontFamily: "assets/font/Oswald-Regular.ttf"));
  }
  Widget get invoiceDownload {
    return Container(padding:const EdgeInsets.all(20),color: Palette.lineColor,child: Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children: [Text("Invoice Download",
        maxLines: 2,
        style: TextStyles.headingTexStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: MyColors.kColorBlack,
            fontFamily: "assets/font/Oswald-Regular.ttf")),const Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: EdgeInsets.only(right: 10),
        child: Icon(
          Icons.arrow_forward_ios_outlined,
          color: MyColors.themeColor,
        ),
      ),
    )],),);
  }
}
