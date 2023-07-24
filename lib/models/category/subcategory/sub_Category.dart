import 'package:mcsofttech/models/category/subcategory/sub_cate_data.dart';
import 'package:mcsofttech/models/home/banner.dart';

class SubCategoryModel {
  SubCatListData? data;
  List<BannerData>? bannerList;
  String message;
  int status;

  SubCategoryModel(
      {required this.data,
      this.bannerList,
      required this.message,
      required this.status});

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) {
    return SubCategoryModel(
      data: json['data'] != null ? SubCatListData.fromJson(json['data']) : null,
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
    data['data'] = data;
    if (bannerList != null) {
      data['bannerList'] = bannerList?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
