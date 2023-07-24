import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:mcsofttech/models/meridukaan/userdashboard/training_data.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../data/network/apiservices/meridukaan_api_services.dart';
import '../../data/preferences/AppPreferences.dart';
import '../../models/home/AllProduct.dart';
import '../../models/meridukaan/userdashboard/Equiry.dart';
import '../../notifire/cart_notifire.dart';
import '../../utils/common_util.dart';
import '../base_getx_controller.dart';

class AddUserActionController extends BaseController {
  final apiServices = Get.put(MeriDukaanApiServices());
  final appPreferences = Get.find<AppPreferences>();
  List<TrainingData> trainingList = [];
  final isLoader = false.obs;
  final fabProduct = false.obs;

  void userActionApi(String productName,
      String price,
      String subCategory,
      int product_id,
      String type,
      String productMobile,
      clickType,
      String product_user_id,
      String productImg,
      String updateDate,
      String qunatity) async {
    showLoader();
    final response = await apiServices.addUserActionData(
        productImg,
        appPreferences.email,
        0,
        appPreferences.mobile,
        price,
        productName,
        product_id,
        int.parse(product_user_id),
        product_user_id,
        subCategory,
        type,
        updateDate,
        appPreferences.userName,
        int.parse(appPreferences.userId),
        int.parse(qunatity));
    hideLoader();
    if (response == null) {
      Common.showToast("Server Error!");
      Provider.of<CartNotifier>(Get.context!, listen: false)
          .removeFromCart(product_id);
    }
    if (response != null && response.status == 200) {
      if (type != "Enquiry") {
        Common.showToast(response.message);
      }
      if (clickType == "fab") {
        fabProduct.toggle();
      }
      if (type == "Enquiry" && clickType == "call") {
        await FlutterPhoneDirectCaller.callNumber(productMobile);
        return;
      }
      if (type == "Enquiry" || clickType == "whatsApp") {
        await launchUrl(
            Uri.parse("whatsapp://send?phone=+91$productMobile&text=https://www.f2df.com/product/details?id=$product_id \nFor Enquiry on app ‘I am interested in this product "));

    return;
      }
    }
  }
}


