class SubCatBrowse {
  int psc_id;

  String subCategoryImg;
  String subCategoryName;

  SubCatBrowse(
      {required this.psc_id,
      required this.subCategoryImg,
      required this.subCategoryName});

  factory SubCatBrowse.fromJson(Map<String, dynamic> json) {
    return SubCatBrowse(
      psc_id: json['psc_id'],
      subCategoryImg: json['subCategoryImg'],
      subCategoryName: json['subCategoryName'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['psc_id'] = psc_id;
    data['subCategoryImg'] = subCategoryImg;
    data['subCategoryName'] = subCategoryName;

    return data;
  }
}
