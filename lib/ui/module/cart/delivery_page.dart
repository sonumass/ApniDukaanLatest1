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

class DeliveryPage extends AppPageWithAppBar {
  static String routeName = "/deliveryPage";

  DeliveryPage({super.key});

  static Future<bool?> start<bool>(String title) {
    return navigateTo<bool>(routeName, currentPageTitle: title);
  }

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
    list.add(listItemCard("Rahul Kumar", "Home", true));
    list.add(listItemCard("Kamal Ranga", "Office", false));
    list.add(listItemCard("Sunil Chopra", "Work", false));
    list.add(listItemCard("Sonu Saini", "Godown", false));
    list.add(addNewAddress);
    list.add(addressTextField);
    list.add(continueButton);
    return list;
  }

  Widget listItemCard(String name, String placeAt, bool isSelected) {
    return Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.0)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              nameAndSelectedPlace(name, placeAt, isSelected),
              const SizedBox(
                height: 10,
              ),
              addressAndDelete(),
            ],
          ),
        ));
  }
  Widget nameAndSelectedPlace(String name, String placeAt, bool isSelected) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        nameAndPlaceAt(name, placeAt),
        if (isSelected)
          InkWell(
            onTap: () {},
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
          borderRadius: BorderRadius.circular(10.0), color: MyColors.themeColor),
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

  Widget addressAndDelete() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("121, Gali number 1, Kalkaji, New Delhi",
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
    return InkWell(onTap:(){controller.isClickedAddedAddress.toggle();},child:Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.0)),
        child: Align(
          alignment: Alignment.center,
          child: Padding(
            padding:
            const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
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
    return Obx(() => controller.isClickedAddedAddress.value?Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.0)),
        child: Align(
            alignment: Alignment.center,
            child: Padding(
              padding:
              const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
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
                  const SizedBox(height: 10,),
                  placeAtRow
                ],
              ),
            ))):const SizedBox.shrink());
  }

  Widget get nameTextField {
    return TextFormField(
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
    return TextFormField(
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

  Widget get cityTextField {
    return TextFormField(
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

  Widget get placeAtRow {
    return Row(
      children: [customRadioButton("Home",1),const SizedBox(width: 5,),customRadioButton("Office",2),const SizedBox(width: 5,),customRadioButton("Work",3)],
    );
  }

  Widget customRadioButton(String text, int index) {
    return OutlinedButton(
      onPressed: () {
        controller.placeAtValue.value=index;
      },
      style: ButtonStyle(
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
            side: BorderSide(color: (controller.placeAtValue.value == index) ? MyColors.themeColor: Colors.black),
            borderRadius: BorderRadius.circular(30.0))),
      ),
      child:  Text(text,
          style: TextStyle(
            color: (controller.placeAtValue.value == index) ? MyColors.themeColor : Colors.grey,
          )),
    );
  }
  Widget get continueButton{
    return InkWell(onTap:(){Get.back();},child: Card(color:MyColors.themeColor,margin: const EdgeInsets.symmetric(vertical: 8),
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.0)),
        child: Align(
            alignment: Alignment.center,
            child: Padding(
              padding:
              const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
              child: Text("Continue",
                  style: TextStyles.headingTexStyle(
                    fontSize: 12,
                    height: 24,
                    color: MyColors.kColorWhite,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Montserrat',
                  )),))),);
}

}

