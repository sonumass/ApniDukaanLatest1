import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:mcsofttech/models/productDetail/product_detail_model.dart';
import '../../../constants/Constant.dart';
import '../../../models/category/product_by_cat_id/product_by_cat_id.dart';
import '../dio_client.dart';

class ProductApiServices extends DioClient {
  final client = DioClient.client;

  Future<ProductDetailModel?> productListDetailApi({productId}) async {
    var inputData = {"productId": productId};
    debugPrint('inputData: $inputData');
    ProductDetailModel? productByCatIdModel;
    try {
      final response = await client.post(
        "${Constant.baseUrl}/product/getProductDetails",
        data: jsonEncode(inputData),
      );
      if (kDebugMode) {
        print('outPut: ${response.data}');
      }
      try {
        productByCatIdModel = ProductDetailModel.fromJson(response.data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return productByCatIdModel;
  }

  Future<ProductByCatIdModel?> productListFromSubCatApi(
      {size = 10, page = 0, pscId}) async {
    var inputData = {
      "psc_id": pscId,
      "minCost": 0,
      "maxCost": 200000,
      "page": page,
      "size": size
    };
    print('inputData: $inputData');
    ProductByCatIdModel? productByCatIdModel;
    try {
      final response = await client.post(
        "${Constant.baseUrl}/product/products-subcategory",
        data: jsonEncode(inputData),
      );
      if (kDebugMode) {
        print('outPut: ${response.data}');
      }
      try {
        productByCatIdModel = ProductByCatIdModel.fromJson(response.data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return productByCatIdModel;
  }

  Future<ProductByCatIdModel?> productListFromHomeApi(
      {size = 10, page = 0, type}) async {
    var inputData = {"size": size, "page": page, type: type};
    ProductByCatIdModel? productByCatIdModel;
    print('inputData: $inputData');
    try {
      final response = await client.post(
        "${Constant.baseUrl}/product/products",
        data: jsonEncode(inputData),
      );
      if (kDebugMode) {
        print('outPut: ${response.data}');
      }
      try {
        productByCatIdModel = ProductByCatIdModel.fromJson(response.data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return productByCatIdModel;
  }
  Future<ProductByCatIdModel?> productSearchApi(
      {size = 10, page = 0, search}) async {
    var inputData = {"searchKeyword": search,"pageNo":page,"size":size};
    ProductByCatIdModel? productByCatIdModel;
    debugPrint('inputData: $inputData');
    try {
      final response = await client.post(
        "${Constant.baseUrl}/product/getProductsByFilter",
        data: jsonEncode(inputData),
      );
      if (kDebugMode) {
        debugPrint('outPut: ${response.data}');
      }
      try {
        productByCatIdModel = ProductByCatIdModel.fromJson(response.data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return productByCatIdModel;
  }

  Future<ProductByCatIdModel?> productListFromCateIdApi(
      {size = 10, page = 0, catId}) async {
    var inputData = {"pc_id": catId};
    ProductByCatIdModel? productByCatIdModel;
    debugPrint('inputData: $inputData');
    try {
      final response = await client.post(
        "${Constant.baseUrl}/product/products-category",
        data: jsonEncode(inputData),
      );
      if (kDebugMode) {
        debugPrint('outPut: ${response.data}');
      }
      try {
        productByCatIdModel = ProductByCatIdModel.fromJson(response.data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return productByCatIdModel;
  }

  Future<ProductByCatIdModel?> categoryProductListApi(
      {catId, page, size}) async {
    var inputData = {"pc_id": catId};
    ProductByCatIdModel? productByCatIdModel;
    debugPrint('inputData: $inputData');
    try {
      final response = await client.post(
        "${Constant.baseUrl}/product/products-category",
        data: jsonEncode(inputData),
      );
      if (kDebugMode) {
        debugPrint('outPut: ${response.data}');
      }
      try {
        productByCatIdModel = ProductByCatIdModel.fromJson(response.data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return productByCatIdModel;
  }
}
