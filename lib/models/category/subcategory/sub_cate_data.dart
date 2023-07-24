import 'package:mcsofttech/models/category/SubCategory.dart';

class SubCatListData {
  String categoryImg;
  String categoryName;
  int pc_id;
  List<SubCategory>? subCategories;

  SubCatListData(
      {required this.categoryImg,
      required this.categoryName,
      required this.pc_id,
      required this.subCategories});

  factory SubCatListData.fromJson(Map<String, dynamic> json) {
    return SubCatListData(
      categoryImg: json['categoryImg'],
      categoryName: json['categoryName'],
      pc_id: json['pc_id'],
      subCategories: json['subCategories'] != null
          ? (json['subCategories'] as List)
              .map((i) => SubCategory.fromJson(i))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categoryImg'] = categoryImg;
    data['categoryName'] = categoryName;
    data['pc_id'] = pc_id;
    if (subCategories != null) {
      data['subCategories'] = subCategories?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
