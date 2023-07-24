import 'package:mcsofttech/models/home/banner.dart';

import 'AllProduct.dart';
import 'BestSellingProduct.dart';

import 'CategoryHomeData.dart';
import 'RecommdedProduct.dart';

class HomeModel {
  List<AllProduct>? allProducts;
  List<BannerData>? bannerList;
  List<AllProduct>? bestSellingProducts;
  List<CategoryHomeData>? categoryList;
  String message;
  List<AllProduct>? recommdedProducts;
  int status;

  HomeModel(
      {required this.allProducts,
      required this.bannerList,
      required this.bestSellingProducts,
      required this.categoryList,
      required this.message,
      required this.recommdedProducts,
      required this.status});

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      allProducts: json['allProducts'] != null
          ? (json['allProducts'] as List)
              .map((i) => AllProduct.fromJson(i))
              .toList()
          : null,
      bannerList: json['bannerList'] != null
          ? (json['bannerList'] as List)
              .map((i) => BannerData.fromJson(i))
              .toList()
          : null,
      bestSellingProducts: json['bestSellingProducts'] != null
          ? (json['bestSellingProducts'] as List)
              .map((i) => AllProduct.fromJson(i))
              .toList()
          : null,
      categoryList: json['categoryList'] != null
          ? (json['categoryList'] as List)
              .map((i) => CategoryHomeData.fromJson(i))
              .toList()
          : null,
      message: json['message'],
      recommdedProducts: json['recommdedProducts'] != null
          ? (json['recommdedProducts'] as List)
              .map((i) => AllProduct.fromJson(i))
              .toList()
          : null,
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    if (allProducts != null) {
      data['allProducts'] = allProducts?.map((v) => v.toJson()).toList();
    }
    if (bannerList != null) {
      data['bannerList'] = bannerList?.map((v) => v.toJson()).toList();
    }
    if (bestSellingProducts != null) {
      data['bestSellingProducts'] =
          bestSellingProducts?.map((v) => v.toJson()).toList();
    }
    if (categoryList != null) {
      data['categoryList'] = categoryList?.map((v) => v.toJson()).toList();
    }
    if (recommdedProducts != null) {
      data['recommdedProducts'] =
          recommdedProducts?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
