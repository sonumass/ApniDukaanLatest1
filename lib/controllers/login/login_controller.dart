import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcsofttech/controllers/base_getx_controller.dart';
import 'package:mcsofttech/data/network/apiservices/login_api_service.dart';
import 'package:mcsofttech/data/preferences/AppPreferences.dart';
import 'package:mcsofttech/models/login/LoginData.dart';
import 'package:mcsofttech/ui/module/home/home.dart';
import 'package:mcsofttech/ui/module/login/otp_page.dart';
import 'package:mcsofttech/ui/module/profile/profile_page.dart';
import 'package:mcsofttech/utils/analytics.dart';
import '../../utils/common_util.dart';

class LoginController extends BaseController {
  final apiServices = Get.put(LoginApiServices());
  final appPreferences = Get.find<AppPreferences>();
  final mobileController = TextEditingController();
  final referralCodeController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final userNameController = TextEditingController();
  final userProfileData = "";
  final type = "mobile";
  final isLoader = false.obs;
  late LoginData loginModel;

  void callLoginApi({mobile, loginId, username, email, type,termAndCondition}) async {
    if (type != "gmail" && mobileController.text.isEmpty) {
      Common.showToast("Please enter mobile");
      return;
    }
    if(!termAndCondition){
      Common.showToast("Please accept term and condition.");
      return;
    }
    showLoader();
    try {
      final response = await apiServices.loginApi(
        mobile,
        loginId,
          termAndCondition
      );
      hideLoader();
      if (response == null) Common.showToast("Server Error!");
      if (response != null &&
          response.status == 200 &&
          response.loginData != null) {
        loginModel = response.loginData!;
        appPreferences.saveEmail(loginModel.email);
        appPreferences.saveUserName(loginModel.name);
        appPreferences.saveUserId(loginModel.id.toString());
        appPreferences.saveUserImage(loginModel.img);
        appPreferences.saveMobile(mobile ?? "");
        appPreferences.saveLoggedIn(true);
        appPreferences.saveReferralCode(loginModel.reffralCode);
        appPreferences.saveUserExit(loginModel.userExist);
        if (type == "mobile") {
          appPreferences.saveLoggedIn(false);
          OtpPage.start(mobile);
        } else if (!loginModel.userExist) {
          EditProfile.start(fromTab: "FromLogin");
        } else {
         // Analytics.logLogin(loginMethod: "mobile");
          //Analytics.logUser(userId: appPreferences.userId, userName: appPreferences.userName);
          Home.start();
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void callOtpReSendApi({mobile, loginId, username, email, type}) async {
    showLoader();
    try {
      final response = await apiServices.loginApi(
        mobile,
        loginId,
        true,
      );
      hideLoader();
      if (response == null) Common.showToast("Server Error!");
      if (response != null &&
          response.status == 200 &&
          response.loginData != null) {
        loginModel = response.loginData!;
        appPreferences.saveEmail(loginModel.email);
        appPreferences.saveUserName(loginModel.name);
        appPreferences.saveUserId(loginModel.id.toString());
        appPreferences.saveUserImage(loginModel.img);
        appPreferences.saveMobile(mobile ?? "");
        //appPreferences.saveLoggedIn(true);
        appPreferences.saveReferralCode(loginModel.reffralCode);
        appPreferences.saveUserExit(loginModel.userExist);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void callVerifyOtpApi({mobile, otp}) async {
    if (otp.isEmpty) {
      Common.showToast("Please enter otp");
      return;
    }
    showLoader();
    final response = await apiServices.otpApi(
        mobile: mobile, otp: otp, refferalCode: referralCodeController.text);
    hideLoader();

    if (response == null) Common.showToast("Network Error!");
    if (response != null &&
        response.status == 200 &&
        response.loginData != null) {
      loginModel = response.loginData!;
      appPreferences.saveEmail(loginModel.email);
      //appPreferences.saveAddress(loginModel.address);
      appPreferences.saveUserName(loginModel.name);
      appPreferences.saveUserId(loginModel.id.toString());
      appPreferences.saveUserImage(loginModel.img);
      appPreferences.saveLoggedIn(true);
      if (response.loginData!.userExist) {
        Home.start();
      } else {
        EditProfile.start(fromTab: "FromLogin");
      }
    }
  }

  bool checkSignUpValidation() {
    if (emailController.text.isEmpty) {
      Common.showToast("Please enter email");
      return false;
    }
    if (userNameController.text.isEmpty) {
      Common.showToast("Please enter user name");
      return false;
    }
    if (mobileController.text.isEmpty) {
      Common.showToast("Please enter mobile");
      return false;
    }
    if (addressController.text.isEmpty) {
      Common.showToast("Please enter address");
      return false;
    }
    return true;
  }
}
