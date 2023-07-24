
import 'package:get/get.dart';
import 'package:mcsofttech/controllers/base_getx_controller.dart';
import 'package:mcsofttech/data/network/apiservices/meridukaan_api_services.dart';
import 'package:mcsofttech/models/home/AllProduct.dart';
import 'package:mcsofttech/utils/common_util.dart';
import '../../data/preferences/AppPreferences.dart';
import '../../models/meridukaan/meri_dukaan_model.dart';

class MyProductController extends BaseController {
  final apiServices = Get.put(MeriDukaanApiServices());
  final appPreferences = Get.find<AppPreferences>();
  MeriDukaanModel? meriDukaanModel;
  List<AllProduct>? productSetList;
  final isProductLoader = false.obs;

  @override
  void onInit() {
    callMeriDukaanProductApi();
    super.onInit();
  }

  void callMeriDukaanProductApi() async {
    isProductLoader.value = true;
    final response =
        await apiServices.productListForApi(userId: appPreferences.userId);
    isProductLoader.value = false;
    if (response == null) Common.showToast("Server Error!");
    if (response != null && response.status == 200) {
      if (response.products!.isNotEmpty) {
        productSetList = response.products;
      } else {
        productSetList = [];
      }
    } else {
      productSetList = [];
    }
  }

}
