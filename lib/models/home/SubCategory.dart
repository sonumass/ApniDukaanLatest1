class SubCategory {
  int psc_id;
  String subCategoryName;

  SubCategory({required this.psc_id, required this.subCategoryName});

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      psc_id: json['psc_id'] ?? 0,
      subCategoryName: json['subCategoryName'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['psc_id'] = psc_id;
    data['subCategoryName'] = subCategoryName;
    return data;
  }
}
