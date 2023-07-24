import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mcsofttech/data/network/apiservices/export_api_services.dart';
import '../../data/preferences/AppPreferences.dart';
import '../../models/export/buyer/Cat.dart';
import '../../models/export/buyer_list.dart';
import '../../theme/my_theme.dart';
import '../../ui/commonwidget/outline_elevated_button.dart';
import '../../ui/commonwidget/primary_elevated_button.dart';
import '../../ui/commonwidget/text_style.dart';
import '../../utils/common_util.dart';
import '../base_getx_controller.dart';

class BuyerController extends BaseController {
  final apiServices = Get.put(ExportApiServices());
  final appPreferences = Get.find<AppPreferences>();
  final buyerList = <Cat>[].obs;
  final isLoader = false.obs;

  void buyerRequirementApi() async {
    isLoader.value = true;
    final response = await apiServices.buyerRequirementApi();
    isLoader.value = false;
    if (response == null) Common.showToast("Server Error!");
    if (response != null && response.status == 200) {
      buyerList.value = response.cat;
    }
  }

  void addRequirementApi(
      String show,
      String productName,
      String name,
      String phoneNumber,
      String location,
      String offerPrice,
      String quantity,
      String expectedDate) async {
    if(phoneNumber.isEmpty){
      Common.showToast("mobile_validation".tr);
      return;
    }
    if(name.isEmpty){
      Common.showToast("name_validation".tr);
      return;
    }
    showLoader();
    final response = await apiServices.addRequirementApi(show, productName,
        name, phoneNumber, location, offerPrice, quantity, expectedDate);
    hideLoader();
    if (response == null) Common.showToast("Server Error!");
    if (response != null && response.status == 200) {
      // Common.showToast(response.message);
      showSuccessConnectDialog();
    } else {
      Common.showToast(response?.message ?? "");
    }
  }

  void showPriceSheet(context, double screenHeight, double screenWidget,String productNameText) {
    final productNameController = TextEditingController();
    final nameController = TextEditingController();
    final mobileController = TextEditingController();
    final locationController = TextEditingController();
    final quantityController = TextEditingController();
    final offerPriceController = TextEditingController();
    final expectedDateController = TextEditingController();
    productNameController.text=productNameText;
    showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(8.0), topLeft: Radius.circular(15.0)),
            side: BorderSide(color: Colors.white)),
        context: context,
        builder: (BuildContext c) {
          return Padding(padding: MediaQuery.of(context).viewInsets,child: Container(child: Wrap(
            children: <Widget>[const SizedBox(
              height: 10,
            ),
              Padding(padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),child: enquiaryForm(screenWidget),),
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
                    productName(productNameController, "Product Name"),
                    productName(nameController, "Name"),
                    productName(mobileController, "Phone Number"),
                    productName(locationController, "Location"),
                    productName(quantityController, "Quantity"),
                    productName(offerPriceController, "Offer Price"),
                    productName(expectedDateController,
                        "Expected Date DD-MM-YYYY"),
                  ],
                ),
              ), Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20,top: 10,left: 10,right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: PrimaryElevatedBtn("SUBMIT", () {
                            addRequirementApi(
                                "App",
                                productNameController.text.toString(),
                                nameController.text.toString(),
                                mobileController.text.toString(),
                                locationController.text.toString(),
                                quantityController.text.toString(),
                                offerPriceController.text.toString(),
                                expectedDateController.text.toString());
                            Navigator.of(Get.context!).pop();
                            if(productNameText.isNotEmpty){
                              appPreferences.savePopUp(true);
                            }

                          })),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: OutLineElevatedBtn("CANCEL", () {
                            Navigator.of(Get.context!).pop();
                          })),
                    ],
                  ),
                ),
              ),],)));

        });
  }

  Widget productName(TextEditingController controller, label) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: label,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
              width: 1, color: MyColors.colorTextGrey), //<-- SEE HERE
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: MyColors.themeColor), //<-- SEE HERE
        ),
      ),
    );
  }

  Widget enquiaryForm(double screenWidget) {
    return Center(child: Text("ENQUIRY FORM",
        textAlign: TextAlign.center,
        style: TextStyles.headingTexStyle(
            color: MyColors.themeColor,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat')),);
  }

  void showSuccessConnectDialog() {
    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      //this right here
      child: SizedBox(
        height: 300.0,
        width: 300.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 0, right: 10),
              child: Text(
                  maxLines: 1,
                  "Successfully!",
                  style: TextStyles.headingTexStyle(
                      color: MyColors.themeColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      fontFamily: 'Montserrat')),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 0, right: 10),
              child: Text(
                  maxLines: 4,
                  "Information has been submit successfully,one of our customer care executive will connect with you soon.",
                  textAlign: TextAlign.center,
                  style: TextStyles.headingTexStyle(
                      color: MyColors.colorTextGrey,
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      fontFamily: 'Montserrat')),
            ),
            const Padding(padding: EdgeInsets.only(top: 50.0)),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: SizedBox(
                width: 200,
                height: 45,
                child: PrimaryElevatedBtn("Back to home",
                    () async => {Navigator.of(Get.context!).pop()},
                    borderRadius: 10.0),
              ),
            )
          ],
        ),
      ),
    );
    showDialog(
        context: Get.context!, builder: (BuildContext context) => errorDialog);
  }
}
