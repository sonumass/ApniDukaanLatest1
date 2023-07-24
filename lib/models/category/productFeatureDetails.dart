class ProductFeatureDetails {
  String item;

  ProductFeatureDetails({required this.item});

  factory ProductFeatureDetails.fromJson(Map<String, dynamic> json) {
    return ProductFeatureDetails(
      item: json['item'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['item'] = item;

    return data;
  }
}
