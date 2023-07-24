import 'SubCategory.dart';

class CategoryCatData {
  String categoryName;
  String categoryImg;
  int pc_id;
  List<SubCategory>? subCategories;

  CategoryCatData(
      {required this.categoryName,
      required this.categoryImg,
      required this.pc_id,
      required this.subCategories});

  factory CategoryCatData.fromJson(Map<String, dynamic> json) {
    return CategoryCatData(
      categoryName: json['categoryName'] ?? "",
      categoryImg: json['categoryImg'] ?? "",
      pc_id: json['pc_id'] ?? 0,
      subCategories: json['subCategories'] != null
          ? (json['subCategories'] as List)
              .map((i) => SubCategory.fromJson(i))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categoryName'] = categoryName;
    data['categoryImg'] = categoryImg;
    data['pc_id'] = pc_id;
    if (subCategories != null) {
      data['subCategories'] = subCategories?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
