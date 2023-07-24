import 'package:flutter/material.dart';
import 'package:get/get.dart';

//import 'package:google_sign_in/google_sign_in.dart';
import 'package:mcsofttech/ui/module/login/login_page.dart';
import 'package:mcsofttech/utils/palette.dart';

import '../../../controllers/login/login_controller.dart';
import '../../../services/navigator.dart';
import '../../../utils/common_util.dart';
import '../../base/page.dart';
import '../../commonwidget/primary_elevated_button.dart';
import '../../commonwidget/text_style.dart';
import '../home/home.dart';

class BeforLoginPage extends AppPageWithAppBar {
  static String routeName = "/beforelogin";
  final loginController = Get.put(LoginController());

  BeforLoginPage({Key? key}) : super(key: key);

  static Future<bool?> start<bool>() {
    return navigateOffAll<bool>(routeName);
  }
final isTermCondition=false.obs;
  //late  GoogleSignInAccount? googleUser;

  @override
  double? get toolbarHeight => 0;

  @override
  Widget get body {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.topRight,
            child: skipText,
          ),
          SizedBox(
            height: screenHeight / 2.0,
            child: companyLogo,
          ),
          const SizedBox(
            height: 20,
          ),
          continueWithMobileButton,
          const SizedBox(
            height: 10,
          ),
          /*otText,
          const SizedBox(
            height: 10,
          ),
          continueWithGmailButton,*/
          bottomRow
        ],
      ),
    );
  }
  Widget get termAndCondition{
    return Row(children: [Checkbox(
      checkColor: Colors.white,
      value: isTermCondition.value,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      onChanged: (bool? value) {
        isTermCondition.value=value!;
      },
    )],);
  }

  Widget get continueWithMobileButton {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: SizedBox(
        width: screenWidget,
        height: 45,
        child: PrimaryElevatedBtn(
            "login_with_mobile".tr, () => {LoginPage.start()},
            borderRadius: 40.0),
      ),
    );
  }

  Widget get continueWithGmailButton {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: SizedBox(
        width: screenWidget,
        height: 45,
        child: PrimaryElevatedBtn("login_with_gmail".tr, () => {getLoginFE()},
            borderRadius: 40.0),
      ),
    );
  }

  Widget get otText {
    return SizedBox(
      height: 20,
      child: Text(
        "or".tr,
        style: TextStyles.labelTextStyle(color: Palette.appColor),
      ),
    );
  }

  Widget get companyLogo {
    return SizedBox(
      width: 152,
      height: 55,
      child: Image.asset("assets/png/app_logo.png"),
    );
  }

  Widget get skipText {
    return InkWell(
      onTap: () {
        Home.start();
      },
      child: SizedBox(
        height: 20,
        child: Text(
          "Skip >>   ",
          style: TextStyles.labelTextStyle(color: Palette.appColor),
        ),
      ),
    );
  }

  Future<void> getLoginFE() async {
    /* try {
      GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: [
          'email',
          'https://www.googleapis.com/auth/contacts.readonly',
        ],
      );
      googleUser = await googleSignIn.signIn();
      debugPrint(googleUser?.email.toString());
      */ /*loginController.callLoginApi(
          mobile: "",
          loginId: googleUser?.email ?? googleUser?.email.toString(),
          type: "gmail",
          username: googleUser?.displayName.toString());*/ /*
      Common.getDeviceId().then((value) => loginController.callLoginApi(
          mobile: "",
          loginId: value,
          type: "gmail",
          username:""));
    } catch (e) {
      Common.getDeviceId().then((value) => loginController.callLoginApi(
          mobile: "",
          loginId: value,
          type: "gmail",
          username: ""));
      debugPrint(e.toString());
      Common.showToast(e.toString());
    }*/
  }

  Widget get bottomRow {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.security,
                color: Colors.blue,
              ),
              Text(
                "100% secure",
                style: TextStyles.labelTextStyle(color: Palette.appColor),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 20,
            child: Text(
              "Made in india",
              style: TextStyles.labelTextStyle(color: Palette.appColor),
            ),
          ),
        ],
      ),
    );
  }
}
