class ProductCategory {
  String categoryImg;
  String categoryName;
  int pc_id;

  ProductCategory(
      {required this.categoryImg,
      required this.categoryName,
      required this.pc_id});

  factory ProductCategory.fromJson(Map<String, dynamic> json) {
    return ProductCategory(
      categoryImg: json['categoryImg'] ?? "",
      categoryName: json['categoryName'] ?? "",
      pc_id: json['pc_id'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['categoryImg'] = categoryImg;
    data['categoryName'] = categoryName;
    data['pc_id'] = pc_id;
    return data;
  }
}
