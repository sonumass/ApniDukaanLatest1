import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/meridukaan/userdashboard/Equiry.dart';

class CartNotifier extends ChangeNotifier {
  List<Equiry> productList = <Equiry>[].obs;

  void addCart(Equiry allProduct) {
    productList
        .removeWhere((element) => element.product_id == allProduct.product_id);
    productList.add(allProduct);
    notifyListeners();
  }

  void removeFromCart(int id) {
    productList.removeWhere((product) => product.product_id == id);
    notifyListeners();
  }

  void clearCart() {
    productList.clear();
    notifyListeners();
  }
}
