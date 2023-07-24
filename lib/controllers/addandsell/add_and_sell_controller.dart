import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mcsofttech/controllers/base_getx_controller.dart';
import 'package:mcsofttech/data/network/apiservices/add_and_sell_api_service.dart';
import 'package:mcsofttech/models/add_sell_product_add_model.dart';
import 'package:mcsofttech/ui/module/home/home.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../data/preferences/AppPreferences.dart';
import '../../models/category/CategoryCatData.dart';
import '../../models/category/SubCategory.dart';
import '../../models/category/SubCategoryFeatures.dart';
import '../../models/home/banner.dart';
import '../../utils/common_util.dart';
import '../../utils/permission_file.dart';

class AddAndSellController extends BaseController {
  final apiServices = Get.put(AddSellApiServices());
  final appPreferences = Get.find<AppPreferences>();
  final categoryDataList = <CategoryCatData>[];
  final bannerList = <BannerData>[].obs;
  final priceCheck = false.obs;
  late final Rx<CategoryCatData> categoryCatData = CategoryCatData(
      categoryName: "", categoryImg: "", pc_id: 1, subCategories: []).obs;

  RxList<SubCategory> subCatList = <SubCategory>[].obs;
  List<ProductFeature> productFeatureList = [];
  bool buy = false;
  RxBool rent = false.obs;
  RxBool sell = true.obs;
  String latitude = "0";
  String longitude = "0";
  late final Rx<SubCategory> subCategoryData = subCatList.first.obs;
  RxList<SubCategoryFeatures> subCategoryFeaturesList =
      <SubCategoryFeatures>[].obs;

  final isSubCatEnable = false.obs;
  final isFeatureEnable = false.obs;
  final isLoader = false.obs;
  final productImage1 = "".obs;
  final productImage2 = "".obs;
  late Rx<Uint8List> bytesImage1 =
      const Base64Decoder().convert(productImage1.value).obs;
  late Rx<Uint8List> bytesImage2 =
      const Base64Decoder().convert(productImage2.value).obs;

  @override
  void onInit() {
    // callCategoryAddProductListApi();

    bytesImage1.value = const Base64Decoder().convert(productImage1.value);
    bytesImage2.value = const Base64Decoder().convert(productImage2.value);
    _getGeoLocationPosition();
    super.onInit();
  }

  void callCategoryAddProductListApi({page = 0, type}) async {
    isLoader.value = true;
    final response =
        await apiServices.categoryListApi(productType: type ?? "Sell");

    if (response == null) Common.showToast("Server Error!");
    if (response != null &&
        response.status == 200 &&
        response.categoryData!.isNotEmpty) {
      bannerList.clear();
      if (response.bannerList != null && response.bannerList!.isNotEmpty) {
        bannerList.addAll(response.bannerList!);
      }
      if (response.categoryData != null && response.categoryData!.isNotEmpty) {
        categoryDataList.clear();

        categoryDataList.addAll(response.categoryData!);
        categoryCatData.value = categoryDataList.first;
        isLoader.value = false;
      }
      if (categoryDataList.first.subCategories != null &&
          categoryDataList.first.subCategories!.isNotEmpty) {
        subCatList.value = categoryDataList.first.subCategories!;
        subCategoryData.value = categoryDataList.first.subCategories!.first;
      }
    }
  }

  void callAddProductApi(
      List<ProductFeature> list,
      String catID,
      String subCatId,
      String productName,
      String productFee,
      String productOldFee,
      String productType,
      String latitude,
      String longitude,
      String userId) async {
    if (productName.isEmpty) {
      Common.showToast("product_name_validation".tr);
      return;
    }
    /*if(productFee.isEmpty || productFee=="0"){
      Common.showToast("product_name_price_validation".tr);
      return;
    }*/
    if (catID.isEmpty) {
      Common.showToast("product_car_id_validation".tr);
      return;
    }
    if (subCatId.isEmpty) {
      Common.showToast("product_sub_id_validation".tr);
      return;
    }
    isLoader.value = true;
    final response = await apiServices.addProductApi(
        list,
        catID,
        subCatId,
        productName,
        productFee,
        productFee,
        productType,
        latitude,
        longitude,
        productImage1.value,
        productImage2.value,
        userId);
    isLoader.value = false;
    if (response == null) Common.showToast("Server Error!");
    if (response != null && response.status == 200) {
      Common.showToast(response.message);
      Home.start();
    }
  }
  void getFromCamera(String type) async {
    final image  = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      if(type=='1'){
        productImage1.value = (await readToBytes(image.path.toString()))!;
        bytesImage1.value =
            const Base64Decoder().convert(productImage1.value);
      }else{
        productImage2.value = (await readToBytes(image.path.toString()))!;
        bytesImage2.value =
            const Base64Decoder().convert(productImage2.value);
      }

    }
  }
  void getImage1(String type) async {
    var statusStorage = await Permission.storage.status;
    if (statusStorage.isGranted) {
      if(type=='1'){
        try {
          final image =
          await ImagePicker().pickImage(source: ImageSource.gallery);
          if (image != null) {
            productImage1.value = (await readToBytes(image.path.toString()))!;
            bytesImage1.value =
                const Base64Decoder().convert(productImage1.value);
          }
        } on PlatformException catch (e) {
          Common.showToast('Failed to pick image: $e');
        }
      }

    } else {
      if (await requestPermission(Permission.storage, 'Storage') == false) {
        return;
      }
      if(type=='1'){
        try {
          final image =
          await ImagePicker().pickImage(source: ImageSource.gallery);
          if (image != null) {
            productImage2.value = (await readToBytes(image.path.toString()))!;
            bytesImage2.value =
                const Base64Decoder().convert(productImage1.value);
          }
        } on PlatformException catch (e) {
          Common.showToast('Failed to pick image: $e');
        }
      }else{
        if(type=='1'){
          try {
            final image =
            await ImagePicker().pickImage(source: ImageSource.gallery);
            if (image != null) {
              productImage2.value = (await readToBytes(image.path.toString()))!;
              bytesImage2.value =
                  const Base64Decoder().convert(productImage2.value);
            }
          } on PlatformException catch (e) {
            Common.showToast('Failed to pick image: $e');
          }
        }
      }
    }
  }

  void getImage2() async {
    var statusStorage = await Permission.storage.status;
    if (statusStorage.isGranted) {
      try {
        final image =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        if (image != null) {
          productImage2.value = (await readToBytes(image.path.toString()))!;
          bytesImage2.value =
              const Base64Decoder().convert(productImage2.value);
        }
      } on PlatformException catch (e) {
        Common.showToast('Failed to pick image: $e');
      }
    } else {
      if (await requestPermission(Permission.storage, 'Storage') == false) {
        return;
      }
      try {
        final image =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        if (image != null) {
          productImage2.value =
              await readToBytes(image.path.toString()) as String;
          bytesImage2.value =
              const Base64Decoder().convert(productImage2.value);
        }
      } on PlatformException catch (e) {
        Common.showToast('Failed to pick image: $e');
      }
    }
  }

  Future<String?> readToBytes(String path) async {
    try {
      var file = File.fromUri(Uri.parse(path));
      List<int> bytes = file.readAsBytesSync();
      return base64Encode(bytes);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  void uploadPostClick(String catID, String subCatID, String productName,
      String productFee, String productOldFee) {
    String productType = "";
    if (buy) {
      productType = "${productType}Buy/";
    }
    if (rent.value) {
      productType = "${productType}Rent/";
    }
    if (sell.value) {
      productType = "${productType}Sell/";
    }

    callAddProductApi(
        productFeatureList,
        catID,
        subCatID,
        productName,
        productFee,
        productOldFee,
        productType,
        latitude,
        longitude,
        appPreferences.userId);
  }

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    latitude = position.latitude.toString();
    longitude = position.longitude.toString();
    return position;
  }
}
