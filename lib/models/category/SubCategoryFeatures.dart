class SubCategoryFeatures {
  int scf_id;
  String subCategoryFeatureName;
  String featureType;
  List<dynamic> productFeatureDetailsList;

  SubCategoryFeatures(
      {required this.scf_id,
      required this.subCategoryFeatureName,
      required this.featureType,
      required this.productFeatureDetailsList});

  factory SubCategoryFeatures.fromJson(Map<String, dynamic> json) {
    return SubCategoryFeatures(
      scf_id: json['scf_id'] ?? 0,
      productFeatureDetailsList: json['productFeatureDetailsList'] != null
          ? (json['productFeatureDetailsList']).toList()
          : [],
      featureType: json['featureType'] ?? "",
      subCategoryFeatureName: json['subCategoryFeatureName'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['scf_id'] = scf_id;
    data['subCategoryName'] = subCategoryFeatureName;
    data['featureType'] = featureType;
    data['productFeatureDetailsList'] = productFeatureDetailsList;

    return data;
  }
}
