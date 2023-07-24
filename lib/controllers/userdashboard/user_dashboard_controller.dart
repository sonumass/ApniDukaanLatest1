import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcsofttech/controllers/base_getx_controller.dart';
import 'package:mcsofttech/data/network/apiservices/user_api_service.dart';
import 'package:mcsofttech/data/preferences/AppPreferences.dart';
import 'package:mcsofttech/models/login/LoginData.dart';
import '../../utils/common_util.dart';

class LoginController extends BaseController {
  final apiServices = Get.put(UserDashboardApiServices());
  final appPreferences = Get.find<AppPreferences>();
  final isLoader = false.obs;
  late LoginData loginModel;

  void callDashBoardApi({userId}) async {
    showLoader();
    try {
      final response = await apiServices.loginApi(userId);
      hideLoader();
      if (response == null) Common.showToast("Server Error!");
      if (response != null &&
          response.status == 200 &&
          response.loginData != null) {
        loginModel = response.loginData!;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
