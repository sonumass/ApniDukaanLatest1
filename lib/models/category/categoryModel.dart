import '../home/banner.dart';
import 'CategoryCatData.dart';

class CategoryModel {
  List<CategoryCatData>? categoryData;
  List<BannerData>? bannerList;
  String message;
  int status;

  CategoryModel(
      {required this.categoryData,
      required this.bannerList,
      required this.message,
      required this.status});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      categoryData: json['data'] != null
          ? (json['data'] as List)
              .map((i) => CategoryCatData.fromJson(i))
              .toList()
          : null,
      bannerList: json['bannerList'] != null
          ? (json['bannerList'] as List)
              .map((i) => BannerData.fromJson(i))
              .toList()
          : null,
      message: json['message'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    if (categoryData != null && categoryData!.isNotEmpty) {
      data['data'] = categoryData?.map((v) => v.toJson()).toList();
    }
    if (bannerList != null && bannerList!.isNotEmpty) {
      data['banner'] = bannerList?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
