import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mcsofttech/ui/base/page.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../notifire/cart_notifire.dart';
import '../../../services/navigator.dart';
import '../../../utils/common_util.dart';
import '../../commonwidget/kart_counter.dart';
import '../cart/cart_list_page.dart';

class NotificationPage extends AppPageWithAppBar {
  static const String routeName = "/notificationPage";

  NotificationPage({Key? key}) : super(key: key);

  static Future<bool?> start<bool>(
    String title, {
    allProduct,
  }) {
    return navigateTo<bool>(routeName, currentPageTitle: title, arguments: {
      'allProduct': allProduct,
    });
  }

  final myProducts = [].obs;

  @override
  List<Widget>? get action => [
        InkWell(
          onTap: () {
            showDialog(
                context: Get.context!,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Select Language'),
                    content: Common.languageAlertDialoagContainer(),
                  );
                });
          },
          child: Padding(
            padding:
                const EdgeInsets.only(left: 0, right: 15, top: 8, bottom: 8),
            child: Stack(
              children: [
                Align(
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                        width: 25, height: 25, 'assets/png/icon_lang.svg')),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () async => await launchUrl(
              Uri.parse("whatsapp://send?phone=+919138111860&text=hello")),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 0, right: 15, top: 8, bottom: 8),
            child: Stack(
              children: [
                Align(
                    alignment: Alignment.center,
                    child: SvgPicture.asset("assets/png/icon_chat_app.svg")),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            CartListPage.start("my_cart".tr);
            /* if (appPreferences.isLoggedIn) {
               // KartStorePage.start();
              } else {
              //  LogInScreen.start();
              }*/
          },
          child: Padding(
            padding:
                const EdgeInsets.only(left: 0, right: 15, top: 8, bottom: 8),
            child: Stack(
              children: [
                Align(
                    alignment: Alignment.center,
                    child: SvgPicture.asset('assets/png/icon_cart.svg')),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: KartCounter(
                    count: Provider.of<CartNotifier>(Get.context!)
                        .productList
                        .length,
                  ),
                )
              ],
            ),
          ),
        ),
      ];

  @override
  Widget get body {
    myProducts.add({"id": 1, "title": "Product #1", "price": 101});
    myProducts.add({"id": 2, "title": "Product #2", "price": 102});
    myProducts.add({"id": 3, "title": "Product #3", "price": 103});
    myProducts.add({"id": 4, "title": "Product #4", "price": 104});
    myProducts.add({"id": 5, "title": "Product #5", "price": 105});
    myProducts.add({"id": 6, "title": "Product #6", "price": 106});
    myProducts.add({"id": 7, "title": "Product #7", "price": 107});
    return SafeArea(
        child: ListView.builder(
      itemCount: myProducts.length,
      itemBuilder: (BuildContext ctx, index) {
        // Display the list item
        return Dismissible(
          key: UniqueKey(),

          // only allows the user swipe from right to left
          direction: DismissDirection.endToStart,

          // Remove this product from the list
          // In production enviroment, you may want to send some request to delete it on server side
          onDismissed: (_) {
            myProducts.removeAt(index);
          },

          // This will show up when the user performs dismissal action
          // It is a red background and a trash icon
          background: Container(
            color: Colors.red,
            margin: const EdgeInsets.symmetric(horizontal: 15),
            alignment: Alignment.centerRight,
            child: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),

          // Display item's title, price...
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: ListTile(
              leading: CircleAvatar(
                child: Text(myProducts[index]["id"].toString()),
              ),
              title: Text(myProducts[index]["title"]),
              subtitle: Text("\$${myProducts[index]["price"].toString()}"),
              trailing: const Icon(Icons.arrow_back),
            ),
          ),
        );
      },
    ));
  }
}
