import '../category/SubCategory.dart';
import '../product_featureDetailsValue.dart';
import 'FeatureDetail.dart';
import 'ProductCategory.dart';

class RecommdedProduct {
  bool bestSeller;
  String brandOfProduct;
  List<FeatureDetail>? featureDetails;
  String? img1;
  String? img2;
  String? img3;
  String? img4;
  String? latitude;
  String? lognitude;
  int oldFee;
  int p_id;
  ProductCategory? productCategory;

  int productFee;
  String? productName;
  bool recommended;
  SubCategory? subCategory;
  int userId;
  List<ProductFeatureDetailsValue>? featureDetailsValue;
  String productDesc;

  RecommdedProduct(
      {required this.bestSeller,
      required this.brandOfProduct,
      this.featureDetails,
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
      required this.featureDetailsValue,
      required this.productDesc});

  factory RecommdedProduct.fromJson(Map<String, dynamic> json) {
    return RecommdedProduct(
        bestSeller: json['bestSeller'],
        brandOfProduct: json['brandOfProduct'],
        featureDetails: json['featureDetails'] != null
            ? (json['featureDetails'] as List)
                .map((i) => FeatureDetail.fromJson(i))
                .toList()
            : null,
        img1: json['img1'],
        img2: json['img2'],
        img3: json['img3'],
        img4: json['img4'],
        latitude: json['latitude'] ?? "",
        lognitude: json['lognitude'] ?? "",
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
        featureDetailsValue: json['featureDetailsValue'] != null
            ? (json['featureDetailsValue'] as List)
                .map((i) => ProductFeatureDetailsValue.fromJson(i))
                .toList()
            : [],
        productDesc: json['productDesc'] ?? "");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bestSeller'] = bestSeller;
    data['brandOfProduct'] = brandOfProduct;
    data['img1'] = img1;
    data['img2'] = img2;
    data['img3'] = img3;
    data['img4'] = img4;
    data['oldFee'] = oldFee;
    data['p_id'] = p_id;
    data['productFee'] = productFee;
    data['productName'] = productName;
    data['recommended'] = recommended;
    data['userId'] = userId;
    if (featureDetails != null) {
      data['featureDetails'] = featureDetails?.map((v) => v.toJson()).toList();
    }

    data['latitude'] = latitude;

    data['lognitude'] = lognitude;
    data['productCategory'] = productCategory?.toJson();
    data['subCategory'] = subCategory?.toJson();
    if (featureDetailsValue != null) {
      data['featureDetailsValue'] =
          featureDetailsValue?.map((v) => v.toJson()).toList();
    }
    data['productDesc'] = productDesc;
    return data;
  }
}
