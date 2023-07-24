import 'package:flutter/material.dart';
import 'package:mcsofttech/services/navigator.dart';
import 'package:mcsofttech/theme/my_theme.dart';
import 'package:mcsofttech/ui/base/page.dart';
import 'package:mcsofttech/ui/commonwidget/text_style.dart';
import 'package:mcsofttech/ui/module/profile/profile_page.dart';
import 'package:mcsofttech/utils/palette.dart';
import 'package:order_tracker/order_tracker.dart';

import 'my_order.dart';

class OrderTracking extends AppPageWithAppBar {
  static String routeName = "/order_track";

  OrderTracking({Key? key}) : super(key: key);

  static Future<bool?> start<bool>() {
    return navigateTo<bool>(routeName,
        currentPageTitle: "Order Details");
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
            wrapSliver(const Padding(padding:  EdgeInsets.only(top: 20))),
            wrapSliver(orderTracker),
            wrapSliver(const Padding(padding:  EdgeInsets.only(top: 20))),



          ]),)
    );
  }
Widget wrapSliver(Widget child){
    return SliverPadding(padding: const EdgeInsets.only(top: 10),sliver: SliverToBoxAdapter(child: child,),);
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
}
