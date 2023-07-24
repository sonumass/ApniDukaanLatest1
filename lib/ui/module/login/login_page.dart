import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mcsofttech/theme/my_theme.dart';
import '../../../constants/Constant.dart';
import '../../../controllers/login/login_controller.dart';
import '../../../services/navigator.dart';
import '../../../utils/palette.dart';
import '../../base/page.dart';
import '../../commonwidget/login_image_carousel.dart';
import '../../commonwidget/primary_elevated_button.dart';
import '../../commonwidget/text_style.dart';
import '../home/drawar/web_view.dart';
import '../home/drawar/web_view_term_and_condition.dart';
import '../home/home.dart';

class LoginPage extends AppPageWithAppBar {
  static const String routeName = "/login";

  final loginController = Get.put(LoginController());

  LoginPage({Key? key}) : super(key: key);

  static Future<bool?> start<bool>() {
    return navigateTo<bool>(routeName);
  }

  RxBool isTermCondition = false.obs;

  // late GoogleSignInAccount? googleUser;

  @override
  double? get toolbarHeight => 0;

  @override
  Widget get body {
    return SafeArea(
        child: Stack(
      children: [
        SizedBox(
          height: MediaQuery.of(Get.context!).size.height,
          child: LoginCarousel(),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: MediaQuery.of(Get.context!).size.width,
            height: MediaQuery.of(Get.context!).size.height / 1.6,
            child: Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "WELCOME TO",
                    style: TextStyles.headingTexStyle(
                      color: Palette.kColorDarkGrey,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("F 2 D F",
                      style: TextStyles.headingTexStyle(
                        color: MyColors.themeColor,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  enterMobileNUmberText,
                  phoneNumber,
                  const Padding(
                    padding: EdgeInsets.only(left: 30, right: 20),
                    child: Divider(
                      height: 2,
                      color: MyColors.kColorDarkGrey,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  termAndCondition,
                  const SizedBox(
                    height: 20,
                  ),
                  getOtpButton,
                  const SizedBox(
                    height: 10,
                  ),
                  bottomRow,
                  const SizedBox(
                    height: 30,
                  ),
                  skipText,
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    ));
  }

  Widget get termAndCondition {
    return Row(
      children: [
        const SizedBox(width: 10),
        Obx(() => Checkbox(
              checkColor: Colors.white,
              value: isTermCondition.value,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0))),
              onChanged: (bool? value) {
                isTermCondition.value = value!;
              },
            )),
        InkWell(
          onTap: () {
            TermAndConditionWebView.start("terms_conditions".tr,
                "${Constant.webViewBaseUrl}/new-f2df/terms-conditions.html");
          },
          child: const Center(
            child: Text.rich(
                TextSpan(text: 'Please accept ', children: <InlineSpan>[
              TextSpan(
                text: 'Term and conditions',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: MyColors.themeColor),
              )
            ])),
          ),
        ),
      ],
    );
  }

  Widget get enterMobileNUmberText {
    return Padding(
      padding: const EdgeInsets.only(left: 30),
      child: Align(
        alignment: Alignment.centerLeft,
        child: SizedBox(
          height: 20,
          child: Text(
            "MOBILE NUMBER",
            style: TextStyles.headingTexStyle(
              color: MyColors.kColorGrey,
              fontSize: 15,
              fontWeight: FontWeight.normal,
              fontFamily: 'Montserrat',
            ),
          ),
        ),
      ),
    );
  }

  Widget get labelText {
    return SizedBox(
      height: 20,
      child: Text(
        "We'll send you a verification code on the mobile number",
        style: TextStyles.labelTextStyle(color: Palette.colorTextGrey),
      ),
    );
  }

  Widget get phoneNumber {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 20),
      child: TextField(
        controller: loginController.mobileController,
        textAlign: TextAlign.left,
        keyboardType: TextInputType.phone,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: const InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(Icons.phone_android),
          hintText: 'Enter you mobile ',
          filled: true,
          contentPadding: EdgeInsets.all(16),
          fillColor: Colors.white,
        ),
      ),
    );
  }

  Widget get getOtpButton {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: SizedBox(
        width: screenWidget,
        height: 45,
        child: PrimaryElevatedBtn(
            "next".tr,
            () async => {
                  loginController.callLoginApi(
                      mobile: loginController.mobileController.text.toString(),
                      type: "mobile",
                      email: "",
                      username: "",
                      loginId: "",
                      termAndCondition: isTermCondition.value)
                },
            borderRadius: 10.0),
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

  Widget get bottomRow {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/svg/icon_flag.svg"),
              const SizedBox(
                width: 5,
              ),
              Text(
                "Made in india",
                style: TextStyles.headingTexStyle(
                  color: MyColors.kColorBlack,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/svg/icon_security.svg"),
              const SizedBox(
                width: 5,
              ),
              Text(
                "100% secure",
                style: TextStyles.headingTexStyle(
                  color: MyColors.kColorBlack,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
            ],
          )
        ],
      ),
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
          style: TextStyles.headingTexStyle(
            color: MyColors.kColorBlack,
            fontSize: 12,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
          ),
        ),
      ),
    );
  }
}
