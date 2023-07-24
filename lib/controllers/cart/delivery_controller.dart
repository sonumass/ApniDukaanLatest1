import 'package:get/get.dart';
import 'package:mcsofttech/controllers/base_getx_controller.dart';
import 'package:mcsofttech/data/network/apiservices/cart_api_services.dart';
import 'package:mcsofttech/notifire/cart_notifire.dart';
import 'package:provider/provider.dart';

class DeliveryController extends BaseController {
  final apiServices = Get.put(CartApiServices());
  final isLoader = false.obs;
  final isClickedAddedAddress = false.obs;
  final placeAtValue = 0.obs;

}
