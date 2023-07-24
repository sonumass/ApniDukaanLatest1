import 'package:flutter/material.dart';
import 'package:mcsofttech/services/navigator.dart';
import 'package:mcsofttech/theme/my_theme.dart';
import 'package:mcsofttech/ui/base/page.dart';
import 'package:mcsofttech/ui/commonwidget/text_style.dart';
import 'package:mcsofttech/utils/palette.dart';

class ShopOrderDetail extends AppPageWithAppBar {
  static String routeName = "/shop_order_detail";

  ShopOrderDetail({Key? key}) : super(key: key);

  static Future<bool?> start<bool>(String orderId) {
    return navigateTo<bool>(routeName,
        currentPageTitle: "Order Details", arguments: {"orderId": orderId});
  }

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
            wrapSliver(pendingOrder),
            wrapSliver(const Padding(padding:  EdgeInsets.only(top: 20))),
            wrapSliver(acceptOrder),
            wrapSliver(const Padding(padding:  EdgeInsets.only(top: 20))),
            wrapSliver(rejectOrder),
            wrapSliver(const Padding(padding:  EdgeInsets.only(top: 20))),
            wrapSliver(dispatchOrder),
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


  Widget get returnPolicyEnded {
    return Text("Return policy ended at on June 16",
        maxLines: 2,
        style: TextStyles.headingTexStyle(
            fontSize: 20,
            fontWeight: FontWeight.normal,
            color: MyColors.appColor,
            fontFamily: "assets/font/Oswald-Regular.ttf"));
  }
  Widget get acceptOrder {
    return InkWell(onTap: (){},child: Container(padding:const EdgeInsets.all(20),color: Palette.lineColor,child: Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children: [Text("Accept Order",
        maxLines: 2,
        style: TextStyles.headingTexStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: MyColors.kColorGreen,
            fontFamily: "assets/font/Oswald-Regular.ttf")), Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Icon(
          Icons.check_circle,
          color: MyColors.kColorGreen,
        ),
      ),
    )],),),);
  }
  Widget get rejectOrder {
    return InkWell(onTap: (){},child: Container(padding:const EdgeInsets.all(20),color: Palette.lineColor,child: Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children: [Text("Reject Order",
        maxLines: 2,
        style: TextStyles.headingTexStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: MyColors.kColorRed,
            fontFamily: "assets/font/Oswald-Regular.ttf")), Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Icon(
          Icons.check_circle,
          color: MyColors.kColorGrey,
        ),
      ),
    )],),),);
  }
  Widget get dispatchOrder {
    return InkWell(onTap: (){},child: Container(padding:const EdgeInsets.all(20),color: Palette.lineColor,child: Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children: [Text("Dispatched Order",
        maxLines: 2,
        style: TextStyles.headingTexStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: MyColors.blue,
            fontFamily: "assets/font/Oswald-Regular.ttf")),  Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Icon(
          Icons.check_circle,
          color: MyColors.kColorGrey,
        ),
      ),
    )],),),);
  }
  Widget get cancelOrder {
    return InkWell(onTap: (){},child: Container(padding:const EdgeInsets.all(20),color: Palette.lineColor,child: Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children: [Text("Canceled Order",
        maxLines: 2,
        style: TextStyles.headingTexStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: MyColors.kColorRed,
            fontFamily: "assets/font/Oswald-Regular.ttf")),  Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Icon(
          Icons.check_circle,
          color: MyColors.kColorGrey,
        ),
      ),
    )],),),);
  }
  Widget get pendingOrder {
    return InkWell(onTap: (){},child: Container(padding:const EdgeInsets.all(20),color: Palette.lineColor,child: Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children: [Text("Pending Order",
        maxLines: 2,
        style: TextStyles.headingTexStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: MyColors.yellowCard,
            fontFamily: "assets/font/Oswald-Regular.ttf")),  Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Icon(
          Icons.check_circle,
          color: MyColors.kColorGrey,
        ),
      ),
    )],),),);
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
