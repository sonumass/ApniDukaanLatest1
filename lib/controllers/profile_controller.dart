import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:mcsofttech/constants/Constant.dart';
import 'package:mcsofttech/controllers/base_getx_controller.dart';
import 'package:mcsofttech/data/network/apiservices/profile_api_service.dart';
import '../data/preferences/AppPreferences.dart';
import '../models/login/LoginData.dart';
import '../ui/module/home/home.dart';
import '../utils/common_util.dart';
import '../utils/permission_file.dart';

class ProfileController extends BaseController {
  final _apiService = Get.put(ProfileApiServices());
  final appPreferences = Get.find<AppPreferences>();
  late Uint8List _bytesImage;
  final userNameController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final addressController = TextEditingController();
  final addressLine1Controller = TextEditingController();
  final addressLine2Controller = TextEditingController();
  final addressLinePinCodeController = TextEditingController();
  final addressDistrictCodeController = TextEditingController();
  final addressStateCodeController = TextEditingController();
  final profilePicUrl = "".obs;
  final imageUrl = "".obs;
  final isLoader = true.obs;
  RxList<String> userTypeList = ["Farmer","FPO","Business Entity"
  ].obs;
  late final Rx<String> selectTypeValue = userTypeList.first.obs;

  bool get isProfilePicPresent => profilePicUrl.value.isNotEmpty;

  @override
  void onInit() {
    userNameController.text = appPreferences.userName;
    mobileController.text = appPreferences.mobile;
    addressController.text = appPreferences.mobile;
    emailController.text = appPreferences.email;
    callGetProfile();
    profilePicUrl.value = Constant.baseUrl + appPreferences.userImage;
    imageUrl.value = Constant.baseUrl + appPreferences.userImage;
    super.onInit();
  }

  void getImage() async {
    var statusStorage = await Permission.storage.status;
    if (statusStorage.isGranted) {
      try {
        final image =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        if (image != null) {
          profilePicUrl.value = (await readToBytes(image.path.toString()))!;
          _bytesImage = const Base64Decoder().convert(profilePicUrl.value);
          callUpLoadUserImageApi();
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
          _bytesImage = const Base64Decoder().convert(profilePicUrl.value);
          callUpLoadUserImageApi();
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

  checkSignUpValidation(String userType,{fromTab}) {
    /*if (emailController.text.toString().isEmpty) {
      Common.showToast("Please enter email");
      return ;
    }*/
    if (userNameController.text.toString().isEmpty) {
      Common.showToast("Please enter user name");
      return;
    }
    if (mobileController.text.toString().isEmpty) {
      Common.showToast("Please enter mobile");
      return;
    }
    if (addressLine1Controller.text.toString().isEmpty) {
      Common.showToast("Please enter line1");
      return;
    }
    if (addressLinePinCodeController.text.toString().isEmpty) {
      Common.showToast("Please enter pin code");
      return;
    }
    if (addressDistrictCodeController.text.toString().isEmpty) {
      Common.showToast("Please enter city");
      return;
    }
    if (addressStateCodeController.text.toString().isEmpty) {
      Common.showToast("Please enter state");
      return;
    }
    callSignUpApi(fromTab: fromTab,userType:userType);
  }

  void callSignUpApi({fromTab,userType}) async {
    showLoader();
    final response = await _apiService.profileApi(
        userId: appPreferences.userId,
        mobile: mobileController.text,
        email: emailController.text,
        username: userNameController.text,
        userType:userType,
        address1: addressLine1Controller.text,
        address2: addressLine2Controller.text,
        state: addressStateCodeController.text,
        city: addressDistrictCodeController.text,
        pincode: addressLinePinCodeController.text);
    hideLoader();
    if (response == null) Common.showToast("Server Error!");
    if (response!.status == 200) {
      appPreferences.saveAddress(
          "${userNameController.text}, ${addressLine1Controller.text} ${addressLine2Controller.text} ${addressDistrictCodeController.text} ${addressStateCodeController.text} ${addressLinePinCodeController.text} ${addressStateCodeController.text}");
      if (fromTab == "FromLogin") {
        Home.start();
      } else {
        Get.back();
      }
    }
  }

  void callUpLoadUserImageApi() async {
    showLoader();
    final response = await _apiService.uploadImage(
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

  void callGetProfile() async {
    isLoader.value = true;
    final response = await _apiService.getProfileApi(id: appPreferences.userId);
    isLoader.value = false;
    if (response == null) Common.showToast("Server Error!");
    if (response != null &&
        response.status == 200 &&
        response.loginData != null) {
      LoginData loginModel = response.loginData!;
      appPreferences.saveEmail(loginModel.email);
      appPreferences.saveUserName(loginModel.name);
      appPreferences.saveUserId(loginModel.id.toString());
      appPreferences.saveUserImage(loginModel.img);
      appPreferences.saveLoggedIn(true);
      userNameController.text = loginModel.name;
      imageUrl.value = loginModel.img;
      emailController.text = loginModel.email;
      addressController.text = loginModel.mobile.toString();
      selectTypeValue.value=userTypeList.lastWhere((element) => element==loginModel.userType);
      if (loginModel.address != null) {
        addressLine1Controller.text = loginModel.address!.address1;
        addressLine2Controller.text = loginModel.address!.address2;
        addressLinePinCodeController.text = loginModel.address!.pincode;
        addressDistrictCodeController.text = loginModel.address!.city;
        addressStateCodeController.text = loginModel.address!.state;
      }
      mobileController.text = loginModel.mobile.toString();
    }
  }
}
