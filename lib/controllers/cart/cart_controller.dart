import 'package:get/get.dart';
import 'package:mcsofttech/controllers/base_getx_controller.dart';
import 'package:mcsofttech/data/network/apiservices/cart_api_services.dart';
import 'package:mcsofttech/notifire/cart_notifire.dart';
import 'package:provider/provider.dart';

class CartController extends BaseController {
  final apiServices = Get.put(CartApiServices());
  final isLoader = false.obs;
  final cartCount = 0.obs;

  @override
  void onInit() {
    cartCount.value = Provider.of<CartNotifier>(Get.context!, listen: false)
        .productList
        .length;
    super.onInit();
  }
}
