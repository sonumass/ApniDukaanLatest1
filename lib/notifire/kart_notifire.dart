import 'package:get/get.dart';
import 'package:mcsofttech/models/home/AllProduct.dart';

class NotificationNotifer extends GetxController {
  List<AllProduct> productList = <AllProduct>[].obs;

  add(AllProduct notificationCounter) {
    productList.add(notificationCounter);
    update();
  }

  del() {
    if (productList.isNotEmpty) {
      productList.removeAt(productList.length - 1);
      update();
    }
  }

  clearList() {
    if (productList.isNotEmpty) {
      productList.clear();
    }
  }
}
