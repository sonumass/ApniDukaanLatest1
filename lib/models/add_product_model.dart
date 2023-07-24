import 'add_sell_product_add_model.dart';

class AddProductDetailModel {
  int pc_id;
  int psc_id;
  String productName;
  int productFee;
  int oldFee;
  String typeOfProduct;
  String lognitude;
  String latitude;
  String img1;
  String img2;
  String userId;
  List<ProductFeature> productFeature;

  AddProductDetailModel(
      {required this.pc_id,
      required this.psc_id,
      required this.productName,
      required this.productFee,
      required this.oldFee,
      required this.typeOfProduct,
      required this.lognitude,
      required this.latitude,
      required this.img1,
      required this.img2,
      required this.userId,
      required this.productFeature});

  Map toJson() => {
        'pc_id': pc_id,
        'psc_id': psc_id,
        'productName': productName,
        'productFee': productFee,
        'productFee': productFee,
        'oldFee': oldFee,
        'typeOfProduct': typeOfProduct,
        'lognitude': lognitude,
        'latitude': latitude,
        'img1': img1,
        'img2': img2,
        'userId': userId,
        'featureDetailsValue': productFeature
      };
}
