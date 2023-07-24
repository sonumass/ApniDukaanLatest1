import 'package:filter_list/filter_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:mcsofttech/controllers/base_getx_controller.dart';
import 'package:mcsofttech/data/network/apiservices/category_api_services.dart';
import 'package:mcsofttech/data/network/apiservices/product_api_services.dart';
import 'package:mcsofttech/models/category/CategoryCatData.dart';
import 'package:mcsofttech/models/category/SubCategory.dart';
import 'package:mcsofttech/models/category/categoryModel.dart';
import 'package:mcsofttech/models/home/AllProduct.dart';
import 'package:mcsofttech/utils/common_util.dart';

import '../../data/preferences/AppPreferences.dart';
import '../../models/product_filter_model.dart';

class ProductController extends BaseController {
  final apiServices = Get.put(ProductApiServices());
  final appPreferences = Get.find<AppPreferences>();
  final productDataList = <AllProduct>[].obs;
  final productSetList = <AllProduct>[].obs;
  final productUserDetailList = <AllProduct>[].obs;
  final productSimilerDetailList = <AllProduct>[].obs;
  final pageOffSet = true.obs;
  final pageNo = 0.obs;
  final isLoader = false.obs;
  final isLoaderForProduct = false.obs;
  final searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  void callProductDetailApi({productId}) async {
    isLoader.value = true;
    final response =
        await apiServices.productListDetailApi(productId: productId);
    isLoader.value = false;
    if (response == null) Common.showToast("Server Error!");
    if (response != null && response.status == "OK") {
      productSimilerDetailList.value = response.simillarProduct;
      productUserDetailList.value = response.userProduct;
    }
  }

  void callProductListApi({page, pscIdValue}) async {
    pageNo.value == 0 ? isLoader.value = true : isLoader.value = false;
    final response = await apiServices.productListFromSubCatApi(
        size: 10, page: page, pscId: pscIdValue);
    isLoader.value = false;
    if (response == null) Common.showToast("Server Error!");
    if (response != null &&
        response.status == 200 &&
        response.products!.isNotEmpty) {
      pageNo.value += 1;
      if (response.products != null && response.products!.isNotEmpty) ;
      productDataList.addAll(response.products!);
      productSetList.addAll(response.products!);
    } else {
      pageOffSet.value = false;
    }
  }

  void callProductListFromHomeApi({page, paramValue}) async {
    pageNo.value == 0
        ? isLoaderForProduct.value = true
        : isLoaderForProduct.value = false;
    final response = await apiServices.productListFromHomeApi(
        size: 10, page: pageNo.value, type: paramValue);
    isLoaderForProduct.value = false;
    if (response == null) Common.showToast("Server Error!");
    if (response != null &&
        response.status == 200 &&
        response.products!.isNotEmpty) {
      pageNo.value += 1;
      if (response.products != null && response.products!.isNotEmpty) {
        productDataList.addAll(response.products!);
        productSetList.addAll(response.products!);
      }

    } else {
      pageOffSet.value = false;
    }
  }

  void callProductListFromCategoryApi({page, catId}) async {
    pageNo.value == 0 ? isLoader.value = true : isLoader.value = false;
    final response = await apiServices.productListFromCateIdApi(
        size: 10, page: pageNo.value, catId: catId);
    isLoader.value = false;
    if (response == null) Common.showToast("Server Error!");
    if (response != null &&
        response.status == 200 &&
        response.products!.isNotEmpty) {
      pageNo.value += 1;
      if (response.products != null && response.products!.isNotEmpty) {
        productDataList.addAll(response.products!);
        productSetList.addAll(response.products!);
      }

    } else {
      pageOffSet.value = false;
    }
  }

  void productSearch({search}) async {
    isLoaderForProduct.value=true;
    final response = await apiServices.productSearchApi(
        size: 10, page: pageNo.value, search: search);
    isLoaderForProduct.value=false;
    if (response == null) Common.showToast("Server Error!");
    if (response != null &&
        response.status == 200 &&
        response.products!.isNotEmpty) {
      productDataList.clear();
      productSetList.clear();
      pageNo.value += 1;
      if (response.products != null && response.products!.isNotEmpty) {
        print("test");
        productDataList.addAll(response.products!);
        productSetList.addAll(response.products!);
        print("test${productDataList.length}");
      }else{
        productDataList.clear();
        productSetList.clear();
      }

    } else {
      pageOffSet.value = false;
    }
  }

  void onSearch(String name) {
    if (searchController.text.length > 2) {
      productSearch(search: name);
    }
  }

  void categoryList(List<CategoryCatData> list) async {
    List<CategoryCatData> selectedUserList = [];
    await FilterListDialog.display<CategoryCatData>(
      Get.context!,
      listData: list,
      selectedListData: selectedUserList,
      choiceChipLabel: (data) => data!.categoryName,
      validateSelectedItem: (list, val) => list!.contains(val),
      onItemSearch: (data, query) {
        return data!.categoryName!.toLowerCase().contains(query.toLowerCase());
      },
      onApplyButtonClick: (list) {
        selectedUserList = List.from(list!);

        Get.back();
      },
    );
  }

  void subCategoryList(List<SubCategory> list) async {
    List<SubCategory> selectedUserList = [];
    await FilterListDialog.display<SubCategory>(
      Get.context!,
      listData: list,
      selectedListData: selectedUserList,
      choiceChipLabel: (data) => data!.subCategoryName,
      validateSelectedItem: (list, val) => list!.contains(val),
      onItemSearch: (data, query) {
        return data.subCategoryName.toLowerCase().contains(query.toLowerCase());
      },
      onApplyButtonClick: (list) {
        selectedUserList = List.from(list!);
        Get.back();
      },
    );
  }
}
