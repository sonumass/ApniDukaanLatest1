import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mcsofttech/controllers/cart/delivery_controller.dart';
import 'package:mcsofttech/services/navigator.dart';
import 'package:mcsofttech/theme/my_theme.dart';
import 'package:mcsofttech/ui/base/page.dart';
import 'package:mcsofttech/ui/commonwidget/text_style.dart';
import 'package:mcsofttech/ui/dialog/loader.dart';
import 'package:mcsofttech/utils/palette.dart';

import '../../../controllers/meridhukaan/total_visitor_controller.dart';
import '../../../models/order/Delivary_addrs_model.dart';
import '../../commonwidget/primary_elevated_button.dart';

class DeliveryPage extends AppPageWithAppBar {
  static String routeName = "/deliveryPage";

  DeliveryPage({super.key});

  static Future<bool?> start<bool>(String title) {
    return navigateTo<bool>(routeName, currentPageTitle: title);
  }

  final wishController = Get.find<TotalVisitorController>();
  final controller = Get.put(DeliveryController());

  @override
  Widget get body {
    return Obx(() => controller.isLoader.value
        ? const Loader()
        : CustomScrollView(
      shrinkWrap: true,
      slivers: <Widget>[
        SliverPadding(
          padding:
          const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          sliver: SliverList(
            delegate: SliverChildListDelegate(
              listItem,
            ),
          ),
        ),
      ],
    ));
  }

  List<Widget> get listItem {
    List<Widget> list = [];
    for (var element in controller.dataList) {
      list.add(listItemCard(element.name ?? "", element.getPlaceAt,
          element.getAddrs, element.isSelected ?? false,element));
    }
    list.add(addNewAddress);
    list.add(addressTextField);
    list.add(continueButton);
    list.add(placeOrderBtn);
    return list;
  }

  Widget listItemCard(
      String name, String placeAt, String address, bool isSelected,DelivaryAddrsModel data) {
    return InkWell(
      onTap: () {
        controller.setDelivaryAddress(data);
      },
      child: Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          elevation: 3,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.0)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                nameAndSelectedPlace(name, placeAt, isSelected,data),
                const SizedBox(
                  height: 10,
                ),
                addressAndDelete(address),
              ],
            ),
          )),
    );
  }

  Widget nameAndSelectedPlace(String name, String placeAt, bool isSelected,DelivaryAddrsModel data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        nameAndPlaceAt(name, placeAt),
        if (isSelected)
          InkWell(
            onTap: () {
              controller.setDelivaryAddress(data);
            },
            child: SvgPicture.asset('assets/png/icon_tick.svg'),
          )
      ],
    );
  }

  Widget nameAndPlaceAt(String text, String place) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 1),
          child: Text(text,
              style: TextStyles.headingTexStyle(
                fontSize: 14,
                height: 14,
                color: Palette.colorTextheader,
                fontWeight: FontWeight.w500,
                fontFamily: 'Montserrat',
              )),
        ),
        const SizedBox(
          width: 5,
        ),
        placeAt(place),
        const SizedBox(
          width: 5,
        ),
      ],
    );
  }

  Widget placeAt(String text) {
    return Container(
      padding: const EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: MyColors.themeColor),
      child: Text(text,
          style: TextStyles.headingTexStyle(
            fontSize: 10,
            height: 10,
            color: Palette.kColorWhite,
            fontWeight: FontWeight.w400,
            fontFamily: 'Montserrat',
          )),
    );
  }

  Widget addressAndDelete(String address) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(address,
            style: TextStyles.headingTexStyle(
              fontSize: 12,
              height: 14,
              color: Palette.colorTextheader,
              fontWeight: FontWeight.w300,
              fontFamily: 'Montserrat',
            )),
        InkWell(
          onTap: () {},
          child: SvgPicture.asset('assets/png/icon_delete.svg'),
        )
      ],
    );
  }

  Widget get addNewAddress {
    return InkWell(
        onTap: () {
          controller.isClickedAddedAddress.toggle();
        },
        child: Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            elevation: 3,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2.0)),
            child: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 10, bottom: 10),
                child: Text("+ Add New Address",
                    style: TextStyles.headingTexStyle(
                      fontSize: 12,
                      height: 24,
                      color: MyColors.themeColor,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Montserrat',
                    )),
              ),
            )));
  }

  Widget get addressTextField {
    return Obx(() => controller.isClickedAddedAddress.value
        ? Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        elevation: 3,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2.0)),
        child: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 10, bottom: 10),
              child: Column(
                children: [
                  nameTextField,
                  mobileTextField,
                  flatTextField,
                  streetTextField,
                  areaTextField,
                  landmarkTextField,
                  pinCodeTextField,
                  countryTextField,
                  stateTextField,
                  cityTextField,
                  const SizedBox(
                    height: 10,
                  ),
                  placeAtRow
                ],
              ),
            )))
        : const SizedBox.shrink());
  }

  Widget get nameTextField {
    return TextFormField(
      controller: controller.nameController,
      cursorColor: MyColors.themeColor,
      decoration: const InputDecoration(
        labelText: 'Name',
        labelStyle: TextStyle(
          color: MyColors.colorTextGrey,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: MyColors.themeColor),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: MyColors.colorTextGrey),
        ),
      ),
    );
  }

  Widget get mobileTextField {
    return TextFormField(
      controller: controller.mobileController,
      cursorColor: MyColors.themeColor,
      decoration: const InputDecoration(
        labelText: 'Mobile',
        labelStyle: TextStyle(
          color: MyColors.colorTextGrey,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: MyColors.themeColor),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: MyColors.colorTextGrey),
        ),
      ),
    );
  }

  Widget get flatTextField {
    return TextFormField(
      controller: controller.flatController,
      cursorColor: MyColors.themeColor,
      decoration: const InputDecoration(
        labelText: 'Flat no./house no.',
        labelStyle: TextStyle(
          color: MyColors.colorTextGrey,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: MyColors.themeColor),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: MyColors.colorTextGrey),
        ),
      ),
    );
  }

  Widget get streetTextField {
    return TextFormField(
      controller: controller.streetController,
      cursorColor: MyColors.themeColor,
      decoration: const InputDecoration(
        labelText: 'Street',
        labelStyle: TextStyle(
          color: MyColors.colorTextGrey,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: MyColors.themeColor),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: MyColors.colorTextGrey),
        ),
      ),
    );
  }

  Widget get areaTextField {
    return TextFormField(
      controller: controller.areaController,
      cursorColor: MyColors.themeColor,
      decoration: const InputDecoration(
        labelText: 'Area',
        labelStyle: TextStyle(
          color: MyColors.colorTextGrey,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: MyColors.themeColor),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: MyColors.colorTextGrey),
        ),
      ),
    );
  }

  Widget get landmarkTextField {
    return TextFormField(
      controller: controller.landmarkController,
      cursorColor: MyColors.themeColor,
      decoration: const InputDecoration(
        labelText: 'Landmark',
        labelStyle: TextStyle(
          color: MyColors.colorTextGrey,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: MyColors.themeColor),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: MyColors.colorTextGrey),
        ),
      ),
    );
  }

  Widget get pinCodeTextField {
    return TextFormField(
      controller: controller.pinCodeController,
      cursorColor: MyColors.themeColor,
      decoration: const InputDecoration(
        labelText: 'Pin code',
        labelStyle: TextStyle(
          color: MyColors.colorTextGrey,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: MyColors.themeColor),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: MyColors.colorTextGrey),
        ),
      ),
    );
  }

  Widget get countryTextField {
    controller.countryController.text = "India";
    return TextFormField(
      enabled: false,
      controller: controller.countryController,
      cursorColor: MyColors.themeColor,
      decoration: const InputDecoration(
        labelText: 'Country',
        labelStyle: TextStyle(
          color: MyColors.colorTextGrey,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: MyColors.themeColor),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: MyColors.colorTextGrey),
        ),
      ),
    );
  }

  Widget get stateTextField {
    return TextFormField(
      controller: controller.stateController,
      cursorColor: MyColors.themeColor,
      decoration: const InputDecoration(
        labelText: 'State',
        labelStyle: TextStyle(
          color: MyColors.colorTextGrey,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: MyColors.themeColor),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: MyColors.colorTextGrey),
        ),
      ),
    );
  }

  Widget get cityTextField {
    return TextFormField(
      controller: controller.cityController,
      cursorColor: MyColors.themeColor,
      decoration: const InputDecoration(
        labelText: 'City',
        labelStyle: TextStyle(
          color: MyColors.colorTextGrey,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: MyColors.themeColor),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: MyColors.colorTextGrey),
        ),
      ),
    );
  }

  Widget get placeAtRow {
    return Row(
      children: [
        customRadioButton("Home", 1),
        const SizedBox(
          width: 5,
        ),
        customRadioButton("Office", 2),
        const SizedBox(
          width: 5,
        ),
        customRadioButton("Work", 3)
      ],
    );
  }

  Widget customRadioButton(String text, int index) {
    return OutlinedButton(
      onPressed: () {
        controller.placeAtValue.value = index;
      },
      style: ButtonStyle(
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
            side: BorderSide(
                color: (controller.placeAtValue.value == index)
                    ? MyColors.themeColor
                    : Colors.black),
            borderRadius: BorderRadius.circular(30.0))),
      ),
      child: Text(text,
          style: TextStyle(
            color: (controller.placeAtValue.value == index)
                ? MyColors.themeColor
                : Colors.grey,
          )),
    );
  }

  Widget get continueButton {
    return InkWell(
      onTap: () {controller.callDelivaryAddressCreate();},
      child: Card(
          color: MyColors.themeColor,
          margin: const EdgeInsets.symmetric(vertical: 8),
          elevation: 3,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.0)),
          child: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 10, bottom: 10),
                child: Text("Save Address",
                    style: TextStyles.headingTexStyle(
                      fontSize: 12,
                      height: 24,
                      color: MyColors.kColorWhite,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Montserrat',
                    )),
              ))),
    );
  }
  Widget get placeOrderBtn {
    return InkWell(
      onTap: () {
        //wishController.createOrderId(wishController.totalPrice.value * 100);
        showModalBottomSheet(
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
                            padding: const EdgeInsets.only(left: 10, right: 10),
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
            });
      },
      child: Card(
          color: MyColors.themeColor,
          margin: const EdgeInsets.symmetric(vertical: 8),
          elevation: 3,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.0)),
          child: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 10, bottom: 10),
                child: Text("Place order",
                    style: TextStyles.headingTexStyle(
                      fontSize: 12,
                      height: 24,
                      color: MyColors.kColorWhite,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Montserrat',
                    )),
              ))),
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
}
