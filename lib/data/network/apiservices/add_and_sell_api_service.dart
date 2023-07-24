import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:mcsofttech/models/message_status_model.dart';
import '../../../constants/Constant.dart';
import '../../../models/add_product_model.dart';
import '../../../models/add_sell_product_add_model.dart';
import '../../../models/category/categoryModel.dart';

import '../dio_client.dart';

class AddSellApiServices extends DioClient {
  final client = DioClient.client;

  Future<CategoryModel?> categoryListApi({productType = "Sell"}) async {
    var inputData = {"productType": productType ?? ""};
    CategoryModel? categoryModel;
    debugPrint('inputData: $inputData');
    try {
      final response = await client.post(
        "${Constant.baseUrl}/home/getAllCategory",
        data: jsonEncode(inputData),
      );
      if (kDebugMode) {
        print('outPut: ${response.data}');
      }
      try {
        categoryModel = CategoryModel.fromJson(response.data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return categoryModel;
  }

  Future<CommonModel?> addProductApi(
      List<ProductFeature> list,
      String catID,
      String subCatId,
      String productName,
      String productFee,
      String productOldFee,
      String productType,
      String latitude,
      String longitude,
      String image1,
      String image2,
      String userId) async {
    String addProductDetail = jsonEncode(AddProductDetailModel(
        pc_id: int.parse(catID),
        psc_id: int.parse(subCatId),
        productName: productName,
        productFee: int.parse(productFee),
        oldFee: int.parse(productOldFee),
        typeOfProduct: productType,
        lognitude: longitude,
        latitude: latitude,
        img1: image1,
        img2: image2,
        userId: userId,
        productFeature: list));
    //String jsonTags = jsonEncode(list);
    var inputData = {addProductDetail};
    debugPrint('inputData: $inputData');

    CommonModel? commonModel;
    try {
      final response = await client.post(
        "${Constant.baseUrl}/product/addProduct",
        data: addProductDetail,
      );
      if (kDebugMode) {
        debugPrint('outPut: ${response.data}');
      }
      try {
        commonModel = CommonModel.fromJson(response.data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return commonModel;
  }
}
