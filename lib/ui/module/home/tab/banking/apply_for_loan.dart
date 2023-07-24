import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:webview_flutter/webview_flutter.dart';

import '../../../../../constants/Constant.dart';
import '../../../../../controllers/banking/banking_controller.dart';
import '../../../../../utils/analytics.dart';
import '../../../../../utils/palette.dart';
import '../../../../base/base_satateless_widget.dart';
import '../../../../commonwidget/primary_elevated_button.dart';
import '../../../../commonwidget/text_see_more.dart';
import '../../../../commonwidget/text_style.dart';

class ApplyLoanPage extends BaseStateLessWidget {
  ApplyLoanPage({Key? key, url}) : super(key: key);
  final controller = Get.put(BankingController());

  @override
  Widget build(BuildContext context) {
    //Analytics.sendCurrentScreen("ApplyLoanPage");
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            aboutHeaderText,
            const SizedBox(
              height: 20,
            ),
            aboutText,
            const SizedBox(
              height: 20,
            ),
            userName,
            const SizedBox(
              height: 20,
            ),
            userEmail,
            const SizedBox(
              height: 20,
            ),
            userMobile,
            const SizedBox(
              height: 20,
            ),
            loanAmount,
            const SizedBox(
              height: 20,
            ),
            /*cropAmount,
            const SizedBox(
              height: 20,
            ),*/
            address,
            const SizedBox(
              height: 20,
            ),
            message,
            const SizedBox(
              height: 20,
            ),
            applyButtonTraining,
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget get loanAmount {
    return TextField(
      controller: controller.userLoanController,
      textAlign: TextAlign.left,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.currency_rupee),
        hintText: 'loan_amount'.tr,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            width: .10,
            color: Palette.appColor,
          ),
        ),
        filled: true,
        contentPadding: const EdgeInsets.all(16),
        fillColor: Colors.white,
      ),
    );
  }

  Widget get cropAmount {
    return TextField(
      controller: controller.cropAmountController,
      textAlign: TextAlign.left,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.currency_rupee),
        hintText: 'crop_insurance_amount'.tr,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            width: .10,
            color: Palette.appColor,
          ),
        ),
        filled: true,
        contentPadding: const EdgeInsets.all(16),
        fillColor: Colors.white,
      ),
    );
  }

  Widget get aboutHeaderText {
    return Text(
      "apply_loan".tr,
      style: TextStyles.headingTexStyle(
          color: Palette.kColorBlack,
          fontFamily: "assets/font/Oswald-Regular.ttf"),
    );
  }

  Widget get aboutText {
    return ExpandableText(
      "apply_loan_about".tr,
      trimLines: 2,
    );
  }

  Widget get userName {
    return TextField(
      controller: controller.userNameController,
      textAlign: TextAlign.left,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.account_box_rounded),
        hintText: 'enter_user_name'.tr,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            width: .10,
            color: Palette.appColor,
          ),
        ),
        filled: true,
        contentPadding: const EdgeInsets.all(16),
        fillColor: Colors.white,
      ),
    );
  }

  Widget get userEmail {
    return TextField(
      controller: controller.userEmailController,
      textAlign: TextAlign.left,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.email),
        hintText: 'enter_your_email'.tr,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            width: .10,
            color: Palette.appColor,
          ),
        ),
        filled: true,
        contentPadding: const EdgeInsets.all(16),
        fillColor: Colors.white,
      ),
    );
  }

  Widget get userMobile {
    return TextField(
      controller: controller.userMobileController,
      textAlign: TextAlign.left,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.phone_android_sharp),
        hintText: 'enter_user_mobile'.tr,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            width: .10,
            color: Palette.appColor,
          ),
        ),
        filled: true,
        contentPadding: const EdgeInsets.all(16),
        fillColor: Colors.white,
      ),
    );
  }

  Widget get address {
    return TextField(
      controller: controller.userAddressController,
      textAlign: TextAlign.left,
      keyboardType: TextInputType.text,
      maxLines: 4,
      decoration: InputDecoration(
        hintText: 'enter_user_address'.tr,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            width: .10,
            color: Palette.appColor,
          ),
        ),
        filled: true,
        contentPadding: const EdgeInsets.all(16),
        fillColor: Colors.white,
      ),
    );
  }

  Widget get message {
    return TextField(
      controller: controller.userMessageController,
      textAlign: TextAlign.left,
      keyboardType: TextInputType.text,
      maxLines: 4,
      decoration: InputDecoration(
        hintText: 'enter_user_message'.tr,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            width: .10,
            color: Palette.appColor,
          ),
        ),
        filled: true,
        contentPadding: const EdgeInsets.all(16),
        fillColor: Colors.white,
      ),
    );
  }

  Widget get applyButtonTraining {
    return SizedBox(
      width: screenWidget,
      height: 45,
      child: PrimaryElevatedBtn(
          "Apply Now", () => controller.callApplyLoanApi(),
          borderRadius: 20.0),
    );
  }
}
