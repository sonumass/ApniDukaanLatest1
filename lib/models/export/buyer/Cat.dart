import 'SubCat.dart';

class Cat {
  Cat({
      required this.categoryName,
    required this.catId,
    required this.categoryImg,
    required this.quantity,
    required this.type,
    required this.subCat,});

  Cat.fromJson(dynamic json) {
    categoryName = json['categoryName']??"";
    catId = json['catId']??"";
    categoryImg = json['categoryImg'];
    quantity = json['quantity']??"";
    type = json['type']??"";
    if (json['subCat'] != null) {
      subCat = [];
      json['subCat'].forEach((v) {
        subCat.add(SubCat.fromJson(v));
      });
    }
  }
  String categoryName="";
  String catId="";
  String categoryImg="";
  String quantity="";
  String type="";
  List<SubCat> subCat=[];

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['categoryName'] = categoryName;
    map['catId'] = catId;
    map['categoryImg'] = categoryImg;
    map['quantity'] = quantity;
    map['type'] = type;
    if (subCat.isNotEmpty) {
      map['subCat'] = subCat.map((v) => v.toJson()).toList();
    }
    return map;
  }

}