class ProductFeature {
  String productFeatureKey;
  String productFeatureValue;

  ProductFeature(
      {required this.productFeatureKey, required this.productFeatureValue});

  Map toJson() => {
        'productFeatureKey': productFeatureKey,
        'productFeatureValue': productFeatureValue,
      };
}
