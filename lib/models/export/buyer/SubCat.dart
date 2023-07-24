class SubCat {
  SubCat({
      required this.subCategoryName,
    required this.subCategoryImg,
    required this.quantity,
    required this.type,});

  SubCat.fromJson(dynamic json) {
    subCategoryName = json['subCategoryName']??"";
    subCategoryImg = json['subCategoryImg']??"";
    quantity = json['quantity']??"";
    type = json['type']??"";
  }
  String subCategoryName="";
  String subCategoryImg="";
  String quantity="";
  String type="";

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['subCategoryName'] = subCategoryName;
    map['subCategoryImg'] = subCategoryImg;
    map['quantity'] = quantity;
    map['type'] = type;
    return map;
  }

}