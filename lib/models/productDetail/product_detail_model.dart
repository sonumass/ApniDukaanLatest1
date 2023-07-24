import 'package:mcsofttech/models/home/AllProduct.dart';

class ProductDetailModel {
  String message;
  List<AllProduct> simillarProduct;
  String status;
  List<AllProduct> userProduct;

  ProductDetailModel(
      {required this.message,
      required this.simillarProduct,
      required this.status,
      required this.userProduct});

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailModel(
      message: json['message'] ?? "",
      simillarProduct: json['simillarProduct'] != null
          ? (json['simillarProduct'] as List)
              .map((i) => AllProduct.fromJson(i))
              .toList()
          : [],
      status: json['status'] ?? "OK",
      userProduct: json['userProduct'] != null
          ? (json['userProduct'] as List)
              .map((i) => AllProduct.fromJson(i))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['message'] = message;
    data['status'] = status;
    data['simillarProduct'] = simillarProduct.map((v) => v.toJson()).toList();
    if (userProduct != null) {
      data['userProduct'] = userProduct.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
