import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcsofttech/controllers/base_getx_controller.dart';
import 'package:mcsofttech/data/network/apiservices/category_api_services.dart';
import 'package:mcsofttech/data/network/apiservices/product_api_services.dart';
import 'package:mcsofttech/models/category/CategoryCatData.dart';
import 'package:mcsofttech/models/home/AllProduct.dart';
import 'package:mcsofttech/utils/common_util.dart';
import 'package:provider/provider.dart';
import 'package:store_redirect/store_redirect.dart';

import '../../data/network/apiservices/meridukaan_api_services.dart';
import '../../data/network/apiservices/splash_api_service.dart';
import '../../data/preferences/AppPreferences.dart';
import '../../models/product_filter_model.dart';
import '../../notifire/cart_notifire.dart';
import '../../ui/commonwidget/text_style.dart';

class SplashController extends BaseController {
  final apiServices = Get.put(SplashApiServices());
  final cartApiServices = Get.put(MeriDukaanApiServices());
  final appPreferences = Get.find<AppPreferences>();
  final isLoader = false.obs;

  Future<bool> callForceUpdateApi() async {
    String currentAppVersion = "36";
    isLoader.value = true;
    await Common.getAppCurrentVersion()
        .then((value) => currentAppVersion = value);
    final response =
        await apiServices.forceUpdateApi(appVersion: currentAppVersion);
    isLoader.value = false;
    if (response == null) Common.showToast("Server Error!");
    if (response as bool) {
      showAlertDialog();
      return true;
    } else {
      return true;
    }
  }

  void callUserDashboardCardCall(String dataType) async {
    final response = await cartApiServices.totalVisitor(
        userId: appPreferences.userId, dataType: dataType);

    if (response == null) return;
    if (response.status == 200) {
      if (response.equiryList.isNotEmpty) {
        for (int i = 0; i < response.equiryList.length; i++) {
          Provider.of<CartNotifier>(Get.context!, listen: false)
              .addCart(response.equiryList[i]);
        }
      }
    }
  }

  showAlertDialog() {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("Update"),
      onPressed: () {
        StoreRedirect.redirect(androidAppId: "com.f2df.mcsofttech");
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Please update app!"),
      content: Text(
        "We have many more features for you. Unlock the revised content by Updating your app.",
        style: TextStyles.headingTexStyle(color: Colors.black),
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      barrierDismissible: false,
      useSafeArea: true,
      context: Get.context!,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
