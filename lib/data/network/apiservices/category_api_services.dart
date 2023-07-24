import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:mcsofttech/models/category/categoryModel.dart';
import 'package:mcsofttech/models/category/subcategory/sub_Category.dart';
import 'package:mcsofttech/models/category/subcategory/subcat_drowse_model.dart';
import '../../../constants/Constant.dart';
import '../../../models/category/product_by_cat_id/product_by_cat_id.dart';
import '../dio_client.dart';

class CategoryApiServices extends DioClient {
  final client = DioClient.client;

  Future<CategoryModel?> categoryListApi({size = 100, page = 0}) async {
    var inputData = {"productType": "All"};
    CategoryModel? categoryModel;
    try {
      final response = await client.post(
        "${Constant.baseUrl}/home/getAllCategory",
        data: jsonEncode(inputData),
      );
      if (kDebugMode) {
        print('inputData: $inputData');
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

  Future<SubCategoryModel?> subCategoryListApi({catId}) async {
    var inputData = {"pc_id": catId};
    SubCategoryModel? subCategoryModel;
    try {
      final response = await client.post(
        "${Constant.baseUrl}/product-category/getCategory",
        data: jsonEncode(inputData),
      );
      if (kDebugMode) {
        print('inputData: $inputData');
        print('outPut: ${response.data}');
      }
      try {
        subCategoryModel = SubCategoryModel.fromJson(response.data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return subCategoryModel;
  }

  Future<ProductByCatIdModel?> categoryProductListApi(
      {catId, page, size}) async {
    var inputData = {"pc_id": catId};
    ProductByCatIdModel? productByCatIdModel;
    try {
      final response = await client.post(
        "${Constant.baseUrl}/product/products-category",
        data: jsonEncode(inputData),
      );
      if (kDebugMode) {
        print('inputData: $inputData');
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

  Future<SubCatBrowseModel?> subCategoryBrowseListApi({catId}) async {
    var inputData = {"pc_id": catId};
    SubCatBrowseModel? subCatBrowseModel;
    try {
      final response = await client.post(
        "${Constant.baseUrl}/product-subcategory/getSubcategories",
        data: inputData,
      );
      if (kDebugMode) {
        debugPrint('inputData: $inputData');
        print('outPut: ${response.data}');
      }
      try {
        subCatBrowseModel = SubCatBrowseModel.fromJson(response.data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return subCatBrowseModel;
  }
}
