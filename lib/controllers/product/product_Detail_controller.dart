import 'package:get/get.dart';
import 'package:mcsofttech/controllers/base_getx_controller.dart';
import 'package:mcsofttech/data/preferences/AppPreferences.dart';
import 'package:mcsofttech/models/home/AllProduct.dart';
import 'package:mcsofttech/models/meridukaan/userdashboard/Equiry.dart';
import 'package:provider/provider.dart';
import '../../notifire/cart_notifire.dart';

class ProductDetailController extends BaseController {
  final cartCount = 0.obs;
  final totalPrice = 0.obs;
  late List<Equiry> dataList;
  final appPreferences = Get.find<AppPreferences>();

  @override
  void onInit() {
    super.onInit();
    cartCount.value = Provider.of<CartNotifier>(Get.context!, listen: false)
        .productList
        .length;
    dataList =
        Provider.of<CartNotifier>(Get.context!, listen: false).productList;
    getTotalPrice;
  }

  void addToCart(AllProduct product) {
    Equiry cartData = Equiry(
        productImg: product.img1,
        email: appPreferences.email,
        id: 1,
        mobile: appPreferences.mobile,
        price: product.productFee,
        productName: product.productName,
        product_id: product.p_id,
        product_user_id: product.userId,
        status: "Active",
        subCategory: product.subCategory?.subCategoryName ?? "",
        type: "Cart",
        updateDate: "",
        userName: appPreferences.userName,
        user_id: int.parse(appPreferences.userId),
        qunatity: 1,
        actualPrice: product.productFee);
    Provider.of<CartNotifier>(Get.context!, listen: false).addCart(cartData);
  }

  void removeCart(Equiry product) {
    totalPrice.value = 0;
    Provider.of<CartNotifier>(Get.context!, listen: false)
        .removeFromCart(product.product_id);
    getTotalPrice;
  }

  void productAdd(Equiry product, int quantity) {
    Equiry cartData = Equiry(
        productImg: product.productImg,
        email: appPreferences.email,
        id: 1,
        mobile: appPreferences.mobile,
        price: product.price,
        productName: product.productName,
        product_id: product.product_id,
        product_user_id: product.product_user_id,
        status: "Active",
        subCategory: product.subCategory,
        type: "Cart",
        updateDate: "",
        userName: appPreferences.userName,
        user_id: int.parse(appPreferences.userId),
        qunatity: quantity,
        actualPrice: product.actualPrice);
    Provider.of<CartNotifier>(Get.context!, listen: false).addCart(cartData);
  }

  void deleteCart(Equiry product) {
    totalPrice.value = 0;
    Provider.of<CartNotifier>(Get.context!, listen: false).clearCart();
    getTotalPrice;
  }

  void get getTotalPrice {
    if (Provider.of<CartNotifier>(Get.context!, listen: false)
        .productList
        .isNotEmpty) {
      for (var element in Provider.of<CartNotifier>(Get.context!, listen: false)
          .productList) {
        totalPrice.value += element.price;
      }
    }
  }
}
