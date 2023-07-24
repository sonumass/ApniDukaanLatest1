import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcsofttech/controllers/base_getx_controller.dart';
import 'package:mcsofttech/data/network/apiservices/banking_api_service.dart';
import 'package:mcsofttech/data/network/apiservices/login_api_service.dart';
import 'package:mcsofttech/data/preferences/AppPreferences.dart';
import 'package:mcsofttech/models/login/LoginData.dart';
import 'package:mcsofttech/ui/module/home/home.dart';
import 'package:mcsofttech/ui/module/login/otp_page.dart';
import 'package:mcsofttech/ui/module/profile/profile_page.dart';
import '../../utils/common_util.dart';
class BankingController extends BaseController {
  final apiServices = Get.put(BankingApiServices());
  final appPreferences = Get.find<AppPreferences>();
  final userNameController = TextEditingController();
  final userEmailController = TextEditingController();
  final cropAmountController = TextEditingController();
  final userLoanController = TextEditingController();
  final userMobileController = TextEditingController();
  final userAddressController = TextEditingController();
  final userMessageController = TextEditingController();
  final isLoader = false.obs;
  late LoginData loginModel;

  void callApplyLoanApi() async {
    if(userMobileController.text.isEmpty){
      Common.showToast("mobile_validation".tr);
      return;
    }
    if(userNameController.text.isEmpty){
      Common.showToast("name_validation".tr);
      return;
    }
    if(userLoanController.text.isEmpty){
      Common.showToast("loan_amount".tr);
      return;
    }
    /*if(cropAmountController.text.isEmpty){
      Common.showToast("crop_insurance_amount".tr);
      return;
    }
*/
    showLoader();
    try {
      final response = await apiServices.applyLoanApi(
        name: userNameController.text.toString(),
        mobile: userMobileController.text.toString(),
        loanAmount:userLoanController.text.toString(),
        cropAmount:cropAmountController.text.toString(),
        email: userEmailController.text.toString(),
        address: userAddressController.text.toString(),
        message: userMessageController.text.toString(),
      );
      hideLoader();
      if (response == null) Common.showToast("Server Error!");
      if (response != null && response.status == 200) {
        userNameController.text = "";
        userEmailController.text = "";
        userMobileController.text = "";
        userAddressController.text = "";
        userMessageController.text = "";
        Common.showToast(response.message);
        return;
      }
      Common.showToast("something_went_wrong".tr);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void callApplyInsauranceApi({mobile, loginId, username, email, type}) async {
    if(userMobileController.text.isEmpty){
      Common.showToast("mobile_validation".tr);
      return;
    }
    if(userNameController.text.isEmpty){
      Common.showToast("name_validation".tr);
      return;
    }
    /*if(userLoanController.text.isEmpty){
      Common.showToast("loan_amount".tr);
      return;
    }*/
    if(cropAmountController.text.isEmpty){
      Common.showToast("crop_insurance_amount".tr);
      return;
    }
    showLoader();
    try {
      final response = await apiServices.applyInsuranceApi(
        name: userNameController.text.toString(),
        mobile: userMobileController.text.toString(),
        email: userEmailController.text.toString(),
        loanAmount: userLoanController.text.toString(),
        cropAmount: cropAmountController.text.toString(),
        address: userAddressController.text.toString(),
        message: userMessageController.text.toString(),
      );
      hideLoader();
      if (response == null) Common.showToast("Server Error!");
      if (response != null && response.status == 200) {
        userNameController.text = "";
        userEmailController.text = "";
        userMobileController.text = "";
        userAddressController.text = "";
        userMessageController.text = "";
        userLoanController.text = "";
        cropAmountController.text ="";
        Common.showToast(response.message);
        return;
      }
      Common.showToast("something_went_wrong".tr);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
