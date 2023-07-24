import '../../home/banner.dart';
import 'Subcatdrowse.dart';

class SubCatBrowseModel {
  String message;
  int status;
  List<SubCatBrowse> subCatBrowse;
  List<BannerData>? bannerList;

  SubCatBrowseModel(
      {required this.message,
      required this.status,
      this.bannerList,
      required this.subCatBrowse});

  factory SubCatBrowseModel.fromJson(Map<String, dynamic> json) {
    return SubCatBrowseModel(
      message: json['message'] ?? "",
      status: json['status'] ?? 404,
      bannerList: json['bannerList'] != null
          ? (json['bannerList'] as List)
              .map((i) => BannerData.fromJson(i))
              .toList()
          : [],
      subCatBrowse: json['data'] != null
          ? (json['data'] as List).map((i) => SubCatBrowse.fromJson(i)).toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    data['data'] = subCatBrowse.map((v) => v.toJson()).toList();
    if (bannerList != null) {
      data['bannerList'] = bannerList?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
