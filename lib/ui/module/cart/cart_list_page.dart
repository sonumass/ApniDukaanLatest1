import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mcsofttech/data/preferences/AppPreferences.dart';
import 'package:mcsofttech/models/meridukaan/userdashboard/Equiry.dart';
import 'package:mcsofttech/theme/my_theme.dart';
import 'package:mcsofttech/ui/base/page.dart';
import 'package:mcsofttech/ui/dialog/loader.dart';
import 'package:mcsofttech/ui/module/cart/kart_card.dart';
import '../../../controllers/meridhukaan/total_visitor_controller.dart';
import '../../../controllers/product/product_Detail_controller.dart';
import '../../../services/navigator.dart';
import '../../../utils/palette.dart';
import '../../commonwidget/primary_elevated_button.dart';
import '../../commonwidget/text_style.dart';
import 'delivery_page.dart';

class CartListPage extends AppPageWithAppBar {
  static String routeName = "/cartListPage";

  CartListPage({Key? key}) : super(key: key);

  static Future<bool?> start<bool>(
    String title,
  ) {
    return navigateTo<bool>(routeName, currentPageTitle: title);
  }

  final wishController = Get.put(TotalVisitorController());
  final productCartController = Get.put(ProductDetailController());
  final appPreference = Get.find<AppPreferences>();
  final cartCount = 0.obs;
  final totalPrice = 0.obs;
  late List<Equiry> productList;
  final pinCodeController = TextEditingController();

  @override
  Widget get body {
    wishController.callUserDashboardCardCall("Cart");
    return Obx(() => wishController.isLoader.value
        ? const Loader()
        : SafeArea(
            child: Stack(
            children: [
              Padding(
                  padding:
                      const EdgeInsets.only(left: 12, right: 12, bottom: 0),
                  child: wishController.equiryList.isNotEmpty
                      ? cartList
                      : const SizedBox.shrink()),
              Positioned(
                bottom: 0,
                child: bottomUI,
              )
            ],
          )));
  }

  Widget get bottomUI {
    return SizedBox(
      width: screenWidget,
      child: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(10),
            elevation: 2,
            color: MyColors.kColorWhite,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("subTotal".tr),
                      Obx(() =>
                          Text("\u{20B9} ${wishController.totalPrice.value}"))
                    ],
                  ),
                  Divider(
                    color: MyColors.lineColor,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('shipping'.tr), const Text("\u{20B9} 0")],
                  ),
                  Divider(
                    color: MyColors.kColorGrey,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "total_amount".tr,
                        style: TextStyles.headingTexStyle(
                            color: Palette.kColorBlack,
                            fontSize: 16,
                            fontFamily: "assets/font/Oswald-Bold.ttf"),
                      ),
                      totalAmountText
                    ],
                  ),
                ],
              ),
            ),
          ),
          checkOut
        ],
      ),
    );
  }

  Widget get cartList {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 25),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: screenHeight / 1.6,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: ListView(
                scrollDirection: Axis.vertical,
                children: List.generate(wishController.equiryList.length,
                    (i) => KartCard(product: wishController.equiryList[i])),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget get pinCodeWidget {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [pinCodeField, pinCode],
    );
  }

  Widget get pinCodeField {
    return SizedBox(
        width: screenWidget / 1.7,
        child: Card(
            margin: const EdgeInsets.only(left: 10),
            elevation: 2,
            color: MyColors.kColorWhite,
            child: TextField(
                controller: pinCodeController,
                textAlign: TextAlign.left,
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                style: TextStyles.headingTexStyle(
                    color: MyColors.themeColor,
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                    height: 20,
                    fontFamily: 'Montserrat'),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter Pin Code ',
                  filled: true,
                  contentPadding: EdgeInsets.all(16),
                  fillColor: Colors.white,
                ))));
  }

  Widget get pinCode {
    return SizedBox(
      width: 150,
      height: 70,
      child: Padding(
          padding: const EdgeInsets.all(10),
          child: SizedBox(
            child: PrimaryElevatedBtn(
                buttonStyle: checkOutButtonStyle,
                "PinCode",
                () {},
                borderRadius: 1.0),
          )),
    );
  }

  Widget get checkOut {
    return SizedBox(
      width: screenWidget,
      child: Padding(
          padding: const EdgeInsets.all(10),
          child: SizedBox(
            child: PrimaryElevatedBtn(
                buttonStyle: checkOutButtonStyle, "proceed_to_continue".tr, () {
              DeliveryPage.start("Delivery To");
              // wishController.createOrderId(wishController.totalPrice.value*100);
              /* showModalBottomSheet(
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8.0),
                          topLeft: Radius.circular(15.0)),
                      side: BorderSide(color: Colors.white)),
                  context: Get.context!,
                  builder: (BuildContext c) {
                    return Padding(
                        padding: MediaQuery.of(Get.context!).viewInsets,
                        child: Container(
                            child: Wrap(
                          children: <Widget>[
                            const SizedBox(
                              height: 10,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Divider(
                              height: 1,
                              color: MyColors.themeColor,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  payFullPayment,
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  if (wishController.totalPrice.value > 1000)
                                    payPartial,
                                  const SizedBox(height: 50),
                                ],
                              ),
                            ),
                          ],
                        )));
                  });*/
            }, borderRadius: 1.0),
          )),
    );
  }

  Widget get payFullPayment {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: SizedBox(
        width: screenWidget,
        height: 45,
        child: PrimaryElevatedBtn(
            "Pay Full Payment",
            () async =>
                {wishController.createOrderId(wishController.totalPrice.value)},
            borderRadius: 10.0),
      ),
    );
  }

  Widget get payPartial {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: SizedBox(
        width: screenWidget,
        height: 45,
        child: PrimaryElevatedBtn("Book @ 10%", () async {
          int price = wishController.totalPrice.value;
          double data = (price / 10);
          wishController.createOrderId(data.toInt());
        }, borderRadius: 10.0),
      ),
    );
  }

  Widget get totalAmountText {
    return Obx(() => Text(
          "\u{20B9} ${wishController.totalPrice.value}",
          style: TextStyles.headingTexStyle(
              color: Palette.kColorBlack,
              fontSize: 16,
              fontFamily: "assets/font/Oswald-Bold.ttf"),
        ));
  }

  ButtonStyle get checkOutButtonStyle {
    return ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> state) {
          if (state.contains(MaterialState.pressed)) {
            return MyColors.themeColor;
          } else if (state.contains(MaterialState.disabled)) {
            return MyColors.themeColor;
          }
          return MyColors.themeColor;
        }));
  }
}
