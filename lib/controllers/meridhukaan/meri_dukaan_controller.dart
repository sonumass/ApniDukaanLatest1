import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mcsofttech/constants/Constant.dart';
import 'package:mcsofttech/controllers/base_getx_controller.dart';
import 'package:mcsofttech/data/network/apiservices/meridukaan_api_services.dart';
import 'package:mcsofttech/models/home/AllProduct.dart';
import 'package:mcsofttech/utils/common_util.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../data/preferences/AppPreferences.dart';
import '../../models/meridukaan/meri_dukaan_model.dart';
import '../../utils/permission_file.dart';

class MeriDukaanController extends BaseController {
  final apiServices = Get.put(MeriDukaanApiServices());
  final appPreferences = Get.find<AppPreferences>();
  MeriDukaanModel? meriDukaanModel;
  List<AllProduct>? productSetList;

  final companyNameController = TextEditingController();
  final shopTagLineController = TextEditingController();
  final yearOfEstController = TextEditingController();
  final natureOfBusinessController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final companyAddressController = TextEditingController();
  final whatsAppNumberController = TextEditingController();
  final gstNumberController = TextEditingController();
  final myCompanyUrlController = TextEditingController();
  final faceBookLinkController = TextEditingController();
  final linkdinLinkController = TextEditingController();
  final twitterLinkController = TextEditingController();
  final instagramLinkController = TextEditingController();
  final youTubeLinkController = TextEditingController();
  final githubLinkController = TextEditingController();
  final aboutUsController = TextEditingController();

  final isLoader = false.obs;
  final isProductLoader = false.obs;
  final profilePicUrl = "".obs;
  final imageUrl = "".obs;
  late Rx<Uint8List> bytesImage =
      const Base64Decoder().convert(profilePicUrl.value).obs;

  @override
  void onInit() {
    callMeriDukaanHomeApi();
    super.onInit();
  }

  void callMeriDukaanHomeApi() async {
    isLoader.value = true;
    final response =
        await apiServices.meriDukaanHomeApi(userId: appPreferences.userId);
    isLoader.value = false;
    if (response == null) Common.showToast("Server Error!");
    if (response != null && response.status == "OK") {
      meriDukaanModel = response;
      companyNameController.text = meriDukaanModel?.dukanDetails?.name ?? "";
      shopTagLineController.text = meriDukaanModel?.dukanDetails?.tagLine ?? "";
      yearOfEstController.text = meriDukaanModel?.dukanDetails?.yrsOfEst ?? "";
      natureOfBusinessController.text =
          meriDukaanModel?.dukanDetails?.natureOfBuss ?? "";
      emailController.text = meriDukaanModel?.dukanDetails?.email ?? "";
      phoneController.text = meriDukaanModel?.dukanDetails?.mobile ?? "";
      companyAddressController.text =
          meriDukaanModel?.dukanDetails?.address ?? "";
      whatsAppNumberController.text =
          meriDukaanModel?.dukanDetails?.mobile ?? "";
      gstNumberController.text = ""; //meriDukaanModel?.dukanDetails?.gst??"";
      myCompanyUrlController.text =
          meriDukaanModel?.dukanDetails?.dukanLink ?? "";
      faceBookLinkController.text = meriDukaanModel?.dukanDetails?.fbLink ?? "";
      linkdinLinkController.text =
          meriDukaanModel?.dukanDetails?.linkdinLink ?? "";
      twitterLinkController.text =
          meriDukaanModel?.dukanDetails?.twitterLink ?? "";
      instagramLinkController.text =
          meriDukaanModel?.dukanDetails?.instaLink ?? "";
      youTubeLinkController.text =
          meriDukaanModel?.dukanDetails?.youTubeLink ?? "";
      githubLinkController.text =
          meriDukaanModel?.dukanDetails?.gitHubLink ?? "";
      aboutUsController.text = meriDukaanModel?.dukanDetails?.aboutUs ?? "";
      imageUrl.value = meriDukaanModel?.dukanDetails?.logo ?? "";
    }
  }

  void callCompanyUrlApi() async {
    if (myCompanyUrlController.text.isEmpty) {
      Common.showToast("please_enter_company_url".tr);
      return;
    }
    showLoader();
    final response = await apiServices.checkApi(
        url:
            "${Constant.webViewBaseUrl}/my-online-dukan/${myCompanyUrlController.text}");
    hideLoader();
    if (response == null) Common.showToast("Server Error!");
    if (response != null && response.status == "200") {
      Common.showToast(response.message);
    } else {
      Common.showToast(response?.message ?? "Server Error!");
    }
  }

  void callCreateShopApi() async {
    if (companyNameController.text.isEmpty) {
      Common.showToast("please_enter_company_name".tr);
      return;
    }
    if (phoneController.text.isEmpty) {
      Common.showToast("please_enter_phone_number".tr);
      return;
    }
    showLoader();
    final response = await apiServices.createShopApi(
        aboutUsController.text,
        companyAddressController.text,
        "${Constant.webViewBaseUrl}/my-online-dukan/${myCompanyUrlController.text}",
        emailController.text,
        faceBookLinkController.text,
        githubLinkController.text,
        instagramLinkController.text,
        linkdinLinkController.text,
        companyNameController.text,
        phoneController.text,
        whatsAppNumberController.text,
        natureOfBusinessController.text,
        true,
        shopTagLineController.text,
        twitterLinkController.text,
        appPreferences.userId,
        meriDukaanModel?.dukanDetails?.id ?? 0,
        youTubeLinkController.text,
        yearOfEstController.text,
        profilePicUrl.value);
    hideLoader();
    if (response == null) Common.showToast("Server Error!");
    if (response != null) {
      Get.back();
      Common.showToast(response.message);
    }
  }

  void callMeriDukaanProductApi() async {
    isProductLoader.value = true;
    final response =
        await apiServices.productListForApi(userId: appPreferences.userId);
    isProductLoader.value = false;
    if (response == null) Common.showToast("Server Error!");
    if (response != null && response.status == 200) {
      if (response.products!.isNotEmpty) {
        productSetList = response.products;
      } else {
        productSetList = [];
      }
    } else {
      productSetList = [];
    }
  }

  void getImage() async {
    var statusStorage = await Permission.storage.status;
    if (statusStorage.isGranted) {
      try {
        final image =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        if (image != null) {
          profilePicUrl.value = (await readToBytes(image.path.toString()))!;
          bytesImage.value = const Base64Decoder().convert(profilePicUrl.value);
          //callUpLoadUserImageApi();
        }
      } on PlatformException catch (e) {
        Common.showToast('Failed to pick image: $e');
      }
    } else {
      if (await requestPermission(Permission.storage, 'Storage') == false)
        return;
      try {
        final image =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        if (image != null) {
          profilePicUrl.value =
              await readToBytes(image.path.toString()) as String;
          bytesImage.value = const Base64Decoder().convert(profilePicUrl.value);
          //callUpLoadUserImageApi();
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

  void callUpLoadUserImageApi() async {
    showLoader();
    final response = await apiServices.uploadImage(
        fileContentBase64: profilePicUrl.value,
        userId: appPreferences.userId,
        fileName: "userImage");
    hideLoader();
    if (response == null) Common.showToast("Server Error!");
    if (response?.status == 200) {
      profilePicUrl.value = response!.data;
      imageUrl.value = response.data;
      Common.showToast(response.message);
    } else {
      Common.showToast(response!.message);
    }
  }
}
