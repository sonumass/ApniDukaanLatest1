import '../category/SubCategory.dart';
import '../product_featureDetailsValue.dart';
import 'FeatureDetail.dart';
import 'ProductCategory.dart';

class AllProduct {
  bool bestSeller;
  int quantity;
  String? brandOfProduct;
  List<FeatureDetail>? featureDetails;
  String img1;
  String img2;
  String img3;
  String img4;
  String? latitude;
  String? lognitude;
  int oldFee;
  int p_id;
  ProductCategory? productCategory;
  int productFee;
  String productName;
  bool recommended;
  SubCategory? subCategory;
  int userId;
  String mobile;
  List<ProductFeatureDetailsValue>? featureDetailsValue;
  String productDesc;
  String typeOfProduct;
  String showType;
  String productShareLink;
  bool assured;
  bool organic;
  int enquiry;

  AllProduct(
      {this.quantity = 1,
      required this.bestSeller,
      required this.brandOfProduct,
      required this.featureDetails,
      required this.img1,
      required this.img2,
      required this.img3,
      required this.img4,
      required this.latitude,
      required this.lognitude,
      required this.oldFee,
      required this.p_id,
      required this.productCategory,
      required this.productFee,
      required this.productName,
      required this.recommended,
      required this.subCategory,
      required this.userId,
      this.mobile = "",
      required this.featureDetailsValue,
      required this.productDesc,
      this.typeOfProduct = "",
      this.showType = "N",
      this.productShareLink = "",
      this.assured = false,
      this.organic = false,this.enquiry=0,});

  factory AllProduct.fromJson(Map<String, dynamic> json) {
    return AllProduct(
        quantity: json['quantity'] ?? 1,
        bestSeller: json['bestSeller']?? false,
        brandOfProduct: json['brandOfProduct']??"",
        featureDetails: json['featureDetailsValue'] != null
            ? (json['featureDetailsValue'] as List)
                .map((i) => FeatureDetail.fromJson(i))
                .toList()
            : [],
        img1: json['img1'] ?? "",
        img2: json['img2'] ?? "",
        img3: json['img3'] ?? "",
        img4: json['img4'] ?? "",
        latitude: json['latitude'].toString(),
        lognitude: json['lognitude'].toString(),
        oldFee: json['oldFee'] ?? 0,
        p_id: json['p_id'] ?? 0,
        productCategory: json['productCategory'] != null
            ? ProductCategory.fromJson(json['productCategory'])
            : null,
        productFee: json['productFee'] ?? 0,
        productName: json['productName'] ?? "",
        recommended: json['recommended'] ?? false,
        subCategory: json['subCategory'] != null
            ? SubCategory.fromJson(json['subCategory'])
            : null,
        userId: json['userId'] ?? 0,
        mobile: json['mobile'] ?? "0",
        featureDetailsValue: json['featureDetailsValue'] != null
            ? (json['featureDetailsValue'] as List)
                .map((i) => ProductFeatureDetailsValue.fromJson(i))
                .toList()
            : [],
        productDesc: json["productDesc"] ?? "0",
        typeOfProduct: json["typeOfProduct"] ?? "Sell",
        showType: json['showType'] ?? "N",
        productShareLink:json['productShareLink'] ??"",
        assured: json['assured'] ?? false,
        organic: json['organic'] ?? false,
        enquiry:json['enquiry']??0);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['quantity'] = quantity;
    data['bestSeller'] = bestSeller;
    data['brandOfProduct'] = brandOfProduct;
    data['img1'] = img1;
    data['img2'] = img2;
    data['img3'] = img3;
    data['oldFee'] = oldFee;
    data['p_id'] = p_id;
    data['productFee'] = productFee;
    data['productName'] = productName;
    data['recommended'] = recommended;
    data['userId'] = userId;
    data['mobile'] = mobile;
    if (featureDetails != null) {
      data['featureDetails'] = featureDetails?.map((v) => v.toJson()).toList();
    }

    data['img4'] = img4;

    data['latitude'] = latitude;

    data['lognitude'] = lognitude;
    data['productCategory'] = productCategory?.toJson();
    data['subCategory'] = subCategory?.toJson();
    if (featureDetailsValue != null) {
      data['featureDetailsValue'] =
          featureDetailsValue?.map((v) => v.toJson()).toList();
    }
    data['productDesc'] = productDesc;
    data['typeOfProduct'] = typeOfProduct;
    data['showType'] = showType;
    data['productShareLink'] = productShareLink;
    data['assured'] = assured;
    data['organic'] = organic;
    data['enquiry'] = enquiry;

    return data;
  }
}
