import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mcsofttech/ui/module/home/home.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import '../../../controllers/login/login_controller.dart';
import '../../../data/preferences/AppPreferences.dart';
import '../../../services/navigator.dart';
import '../../../theme/my_theme.dart';
import '../../../utils/palette.dart';
import '../../base/page.dart';
import '../../commonwidget/primary_elevated_button.dart';
import '../../commonwidget/text_style.dart';

class OtpPage extends AppPageWithAppBar {
  static String routeName = "/otp";

  final appPreferences = Get.find<AppPreferences>();

  OtpPage({Key? key}) : super(key: key);

  static Future<bool?> start<bool>(String mobile) {
    return navigateOffAll<bool>(routeName, arguments: {'mobile': mobile});
  }

  String otpCode = "";
  final loginController = Get.put(LoginController());

  @override
  double? get toolbarHeight => 0;

  @override
  Widget get body {
    return Container(
      height: screenHeight,
      width: screenWidget,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/png/otp_background.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Text(
              "WELCOME TO",
              style: TextStyles.headingTexStyle(
                color: MyColors.kColorWhite,
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
                  color: MyColors.kColorWhite,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                )),
            const SizedBox(
              height: 20,
            ),
            card,
          ],
        ),
      ),
    );
  }

  Widget get card {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 10, bottom: 30, top: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Text("Verification Code",
                  style: TextStyles.headingTexStyle(
                    color: MyColors.themeColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                  )),
              const SizedBox(
                height: 10,
              ),
              Text("Please sent 4-digit OTP code",
                  style: TextStyles.headingTexStyle(
                    color: MyColors.kColorBlack,
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Montserrat',
                  )),
              const SizedBox(
                height: 5,
              ),
              Text("Sent - ${arguments['mobile']}",
                  style: TextStyles.headingTexStyle(
                    color: MyColors.kColorBlack,
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Montserrat',
                  )),
              otpTextField,
              const SizedBox(
                height: 20,
              ),
              resendText,
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 26, right: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Refferal Code",
                      style: TextStyles.headingTexStyle(
                        color: MyColors.kColorBlack,
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Montserrat',
                      )),
                ),
              ),
              if (appPreferences.isUserExist)
                const SizedBox(
                  height: 10,
                ),
              if (appPreferences.isUserExist) refferalCode,
              const SizedBox(
                height: 20,
              ),
              getOtpButton,
              const SizedBox(
                height: 20,
              ),
              bottomRow,
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.center,
                child: skipText,
              ),
            ],
          ),
        ),
      ),
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
                  color: MyColors.themeColor,
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
                  color: MyColors.themeColor,
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

  Widget get otpTextField {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: OTPTextField(
        length: 4,
        width: screenWidget,
        fieldWidth: 60,
        style: const TextStyle(fontSize: 17),
        textFieldAlignment: MainAxisAlignment.spaceAround,
        fieldStyle: FieldStyle.underline,
        onCompleted: (pin) {
          otpCode = pin;
          debugPrint("Completed: $pin");
        },
      ),
    );
  }

  Widget get refferalCode {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 26, right: 20),
        child: TextField(
          controller: loginController.referralCodeController,
          textAlign: TextAlign.left,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: 'Refferal code',
            filled: true,
            prefixIcon: Padding(
              padding: const EdgeInsets.all(10),
              child: SvgPicture.asset(
                  height: 10, width: 10, 'assets/svg/ic_otp_share.svg'),
            ),
            contentPadding: const EdgeInsets.all(16),
            fillColor: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget get resendText {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Didn't not received the code? ",
          style: TextStyles.headingTexStyle(
            color: MyColors.colorTextGrey,
            fontSize: 12,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
          ),
        ),
        InkWell(
          onTap: () {
            loginController.callOtpReSendApi(
                mobile: arguments['mobile'],
                type: "mobile",
                email: "",
                username: "",
                loginId: "");
          },
          child: SizedBox(
            height: 20,
            child: Text(
              "Resend".tr,
              style: TextStyles.headingTexStyle(
                color: MyColors.themeColor,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget get getOtpButton {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: SizedBox(
        width: screenWidget,
        height: 45,
        child: PrimaryElevatedBtn(
            "Submit".tr,
            () => {
                  loginController.callVerifyOtpApi(
                      mobile: arguments['mobile'], otp: otpCode)
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

  Widget get skipText {
    return InkWell(
      onTap: () {
        Home.start();
      },
      child: SizedBox(
        height: 20,
        child: Text(
          "skip".tr,
          style: TextStyles.headingTexStyle(
            color: MyColors.themeColor,
            fontSize: 12,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
          ),
        ),
      ),
    );
  }
}
