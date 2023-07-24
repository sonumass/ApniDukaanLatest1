import 'package:mcsofttech/models/home/AllProduct.dart';

import '../../home/RecommdedProduct.dart';
import '../../home/banner.dart';

class ProductByCatIdModel {
  List<BannerData>? bannerList;
  List<AllProduct>? products;
  String message;
  int status;

  ProductByCatIdModel({
    required this.products,
    required this.message,
    required this.status,
    required this.bannerList,
  });

  factory ProductByCatIdModel.fromJson(Map<String, dynamic> json) {
    return ProductByCatIdModel(
      products: json['data'] != null
          ? (json['data'] as List).map((i) => AllProduct.fromJson(i)).toList()
          : [],
      bannerList: json['bannerList'] != null
          ? (json['bannerList'] as List)
              .map((i) => BannerData.fromJson(i))
              .toList()
          : [],
      message: json['message'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    if (bannerList != null) {
      data['bannerList'] = bannerList?.map((v) => v.toJson()).toList();
    }
    data['data'] = products?.map((v) => v.toJson()).toList();
    return data;
  }
}
