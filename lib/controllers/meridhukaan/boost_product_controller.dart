
import 'package:get/get.dart';
import 'package:mcsofttech/controllers/base_getx_controller.dart';
import 'package:mcsofttech/data/network/apiservices/meridukaan_api_services.dart';
import 'package:mcsofttech/models/home/AllProduct.dart';
import 'package:mcsofttech/utils/common_util.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../data/preferences/AppPreferences.dart';
import '../../models/meridukaan/meri_dukaan_model.dart';

class BoostProductController extends BaseController {
  final apiServices = Get.put(MeriDukaanApiServices());
  final appPreferences=Get.find<AppPreferences>();
  final isProductLoader = false.obs;

  void callProductBoostApi(String productId,PaymentSuccessResponse paymentSuccessResponse) async {
    showLoader();
    final response =
    await apiServices.boostApi(productId,paymentSuccessResponse,appPreferences.userId);
    hideLoader();
    if (response == null) Common.showToast("Server Error!");
    if (response != null && response.status == 200) {
      Common.showToast(response.message);
    } else {
      Common.showToast(response?.message??"Something went wrong");
    }
  }
}
