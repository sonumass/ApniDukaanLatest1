import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mcsofttech/controllers/base_getx_controller.dart';
import 'package:mcsofttech/data/network/apiservices/cart_api_services.dart';
import 'package:mcsofttech/models/order/Delivary_addrs_model.dart';
import '../../data/preferences/AppPreferences.dart';
import '../../utils/common_util.dart';

class DeliveryController extends BaseController {
  final apiServices = Get.put(CartApiServices());
  final isLoader = false.obs;
  final isClickedAddedAddress = false.obs;
  final placeAtValue = 0.obs;
  final appPreferences = Get.find<AppPreferences>();
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final flatController = TextEditingController();
  final streetController = TextEditingController();
  final areaController = TextEditingController();
  final landmarkController = TextEditingController();
  final pinCodeController = TextEditingController();
  final countryController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final placeAtController = TextEditingController();
  RxList<DelivaryAddrsModel> dataList =<DelivaryAddrsModel>[].obs;
  @override
  void onInit() {
    super.onInit();
    getDelivaryAddressList();
  }



  void callDelivaryAddressCreate() async {
    if(nameController.text.isEmpty){
      Common.showToast("Please enter name");
      return;
    }
    if(mobileController.text.isEmpty){
      Common.showToast("Please enter mobile");
      return;
    }
    if(flatController.text.isEmpty){
      Common.showToast("Please enter flat no/house no.");
      return;
    }
    if(streetController.text.isEmpty){
      Common.showToast("Please enter street");
      return;
    }
    if(areaController.text.isEmpty){
      Common.showToast("Please enter area");
      return;
    }
    if(landmarkController.text.isEmpty){
      Common.showToast("Please enter landmark");
      return;
    }
    if(pinCodeController.text.isEmpty){
      Common.showToast("Please enter pin Code");
      return;
    }
    if(cityController.text.isEmpty){
      Common.showToast("Please enter city");
      return;
    }
    if(stateController.text.isEmpty){
      Common.showToast("Please enter state");
      return;
    }


    showLoader();
    try {
      final response = await apiServices.createDeliveryAddress(name:nameController.text, mobile:mobileController.text, houseNo:flatController.text, street:streetController.text, area:areaController.text, landmark:landmarkController.text, state:streetController.text, city:cityController.text, country:"India", pincode:pinCodeController.text, userId:appPreferences.userId, type:placeAtValue.value);
      hideLoader();
      if (response == null) Common.showToast("Server Error!");
      if (response != null && response.status == 200) {
        Common.showToast(response.message);
        return;
      }
      Common.showToast("something_went_wrong".tr);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
  void getDelivaryAddressList() async {
    isLoader.value=true;
    try {
      final response = await apiServices.getDelivaryAddrs(userId:appPreferences.userId);
      isLoader.value=false;
      if (response == null) Common.showToast("Server Error!");

      if (response != null && response.status == 200) {
        if(response.listData!.isNotEmpty){
          dataList.value=response.listData!;
        }
        return;
      }
      Common.showToast("something_went_wrong".tr);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
  void setDelivaryAddress(DelivaryAddrsModel data) async {
    showLoader();
    try {
      final response = await apiServices.setDeliveryAddress(name:data.name, mobile:data.mobile, houseNo:data.houseNo, street:data.street, area:data.area, landmark:data.landmark, state:data.state, city:data.city, country:"India", pincode:data.pincode, userId:appPreferences.userId,type:data.getPlaceAt,id:data.id);
      hideLoader();
      if (response == null) Common.showToast("Server Error!");
      if (response != null && response.status == 200) {
        Common.showToast(response.message);
        return;
      }
      Common.showToast("something_went_wrong".tr);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
