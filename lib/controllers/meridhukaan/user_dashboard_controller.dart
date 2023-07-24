import 'dart:ui';

import 'package:get/get.dart';
import '../../data/network/apiservices/meridukaan_api_services.dart';
import '../../data/preferences/AppPreferences.dart';
import '../../models/meridukaan/userdashboard/userDynamicDashboard.dart';
import '../../ui/module/enquiry/enquiry_screen.dart';
import '../../ui/module/meridukaan/create_shop.dart';
import '../../ui/module/meridukaan/internal_page/total_visiter.dart';
import '../../ui/module/meridukaan/meri_dukaan.dart';
import '../../utils/common_util.dart';
import '../base_getx_controller.dart';

class UserDashboardController extends BaseController {
  final apiServices = Get.put(MeriDukaanApiServices());
  final appPreferences = Get.find<AppPreferences>();
  final isLoader = false.obs;
  final admin=false.obs;
  UserDynamicDashboard? userDashboard;

  @override
  void onInit() {
    super.onInit();
    callUserDashboard();
  }

  void callUserDashboard() async {
    isLoader.value = true;
    final response =
        await apiServices.userDashboard(userId: appPreferences.userId);
    isLoader.value = false;
    if (response == null) Common.showToast("Server Error!");
    if (response != null && response.status == 200) {
      userDashboard = response;
      admin.value=response.admin;
    }
  }

  void deleteProduct(int productId, int index,String action) async {
    isLoader.value = true;
    final response = await apiServices.deleteProductApi(productId: productId,action:action);
    isLoader.value = false;
    if (response == null) Common.showToast("Server Error!");
    if (response != null && response.status == 200) {
      if(!(action=="BUSS DONE" || action=="PARTIAL DONE" )){
        userDashboard!.userProduct.removeAt(index);
      }
      Common.showToast(response.message);
    }
  }
  VoidCallback getCallBack(String navigate,String title){
    if(navigate=="Create Show"){
      return () {
        CreateShop.start(title);
      };
    }
    if(navigate=="Total Enquiry"){
      return () {
        EnquiryScreen.start();
      };
    }
    if(navigate=="Public view"){
      return () {
        MeriDukaan.start(title,
           userDashboard?.mereDukanLink ?? "meri_dukaan".tr);
      };
    }
    return () {
      TotalVisitor.start(
          title, "Order");
    };

  }
}
