import 'SubCategoryFeatures.dart';

class SubCategory {
  int psc_id;
  List<SubCategoryFeatures>? subCategoryFeatures;
  String subCategoryName;

  SubCategory(
      {required this.psc_id,
      required this.subCategoryFeatures,
      required this.subCategoryName});

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      psc_id: json['psc_id'] ?? 0,
      subCategoryFeatures: json['subCategoryFeatures'] != null
          ? (json['subCategoryFeatures'] as List)
              .map((i) => SubCategoryFeatures.fromJson(i))
              .toList()
          : null,
      subCategoryName: json['subCategoryName'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['psc_id'] = psc_id;
    data['subCategoryName'] = subCategoryName;
    if (subCategoryFeatures != null) {
      data['subCategoryFeatures'] =
          subCategoryFeatures!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
