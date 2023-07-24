class ProductFeatureDetailsValue {
  int id;
  String productFeatureKey;
  String productFeatureValue;

  ProductFeatureDetailsValue(
      {required this.id,
      required this.productFeatureKey,
      required this.productFeatureValue});

  factory ProductFeatureDetailsValue.fromJson(Map<String, dynamic> json) {
    return ProductFeatureDetailsValue(
      id: json['id'] ?? 0,
      productFeatureKey: json['productFeatureKey'] ?? "",
      productFeatureValue: json['productFeatureValue'] ?? "-",
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['productFeatureKey'] = productFeatureKey;
    data['productFeatureValue'] = productFeatureValue;
    return data;
  }
}
