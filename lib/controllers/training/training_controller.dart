import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcsofttech/controllers/base_getx_controller.dart';
import 'package:mcsofttech/data/network/apiservices/banking_api_service.dart';
import 'package:mcsofttech/data/network/apiservices/login_api_service.dart';
import 'package:mcsofttech/data/network/apiservices/training_api_service.dart';
import 'package:mcsofttech/data/preferences/AppPreferences.dart';
import 'package:mcsofttech/models/login/LoginData.dart';
import 'package:mcsofttech/models/training/UpcomingEvents.dart';
import 'package:mcsofttech/models/training/post_event.dart';
import 'package:mcsofttech/models/training/trainingDropdown/TrainingType.dart';
import 'package:mcsofttech/ui/module/home/home.dart';
import 'package:mcsofttech/ui/module/login/otp_page.dart';
import 'package:mcsofttech/ui/module/profile/profile_page.dart';
import '../../models/training/trainingDropdown/Venue.dart';
import '../../models/training/trainingDropdown/Venue.dart';
import '../../utils/common_util.dart';

class TrainingController extends BaseController {
  final apiServices = Get.put(TrainingApiServices());
  final appPreferences = Get.find<AppPreferences>();
  final userNameController = TextEditingController();
  final userEmailController = TextEditingController();
  final userMobileController = TextEditingController();
  final userDescriptionController = TextEditingController();
  final trainingDateController = TextEditingController();
  final trainingTypeList = <TrainingType>[].obs;
  final trainingVenue = <Venue>[].obs;
    List<UpcomingEvents> upcomingEventList=<UpcomingEvents>[];
    List<PostEvent> postEventList=<PostEvent>[];
  late TrainingType trainingTypeSelected;
  late Venue venueSelected;
  final trainingType = "".obs;
  final trainingMode = "".obs;
  final trainingVenueValue = "".obs;
  final timeDate = "".obs;
  final isLoader = false.obs;
  final isEventLoader = false.obs;
  final isPostEventLoader = false.obs;
  late LoginData loginModel;

  void applyTrainingDropDownApiApi() async {
    isLoader.value = true;
    try {
      final response = await apiServices.applyTrainingDropDownApi();
      isLoader.value = false;
      if (response == null) Common.showToast("Server Error!");
      if (response != null &&
          response.status == 200 &&
          response.trainingType.isNotEmpty) {
        trainingTypeList.clear();
        trainingVenue.clear();
        trainingTypeList.addAll(response.trainingType);
        trainingTypeSelected = trainingTypeList.first;
        trainingVenue.addAll(trainingTypeList.first.venue);
        venueSelected = trainingVenue.first;
        return;
      }
      Common.showToast("something_went_wrong".tr);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void callApplyTrainingApi(int trainingId) async {
    //showLoader();
    debugPrint("sonu::$trainingId");
    try {
      final response = await apiServices.applyTrainingApi(
        id: trainingId,
        name: userNameController.text.toString(),
        phone: userMobileController.text.toString(),
        email: userEmailController.text.toString(),
        trainingType: trainingType.value,
        trainingMode: trainingMode.value,
        trainingVenue: trainingVenue[0].name,
        trainingDate: trainingDateController.text.toString(),
        discription: userDescriptionController.text.toString(),
      );
      //hideLoader();
      if (response == null) Common.showToast("Server Error!");
      if (response != null && response.status == 200) {
        userNameController.text = "";
        userEmailController.text = "";
        userMobileController.text = "";
        userDescriptionController.text = "";
        Common.showToast(response.message);
        return;
      }
      Common.showToast("something_went_wrong".tr);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
  void trainingEventsList() async {
    isEventLoader.value = true;
    try {
      final response = await apiServices.eventApi();
      isEventLoader.value = false;
      if (response == null) Common.showToast("Server Error!");
      if (response != null &&
          response.status == 200 ) {
        upcomingEventList=response.upcomingEvents;
        postEventList=response.pastEvents;
        return;
      }
      Common.showToast("something_went_wrong".tr);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
  void trainingPostEventsList() async {
    isPostEventLoader.value = true;
    try {
      final response = await apiServices.eventApi();
      isPostEventLoader.value = false;
      if (response == null) Common.showToast("Server Error!");
      if (response != null &&
          response.status == 200 ) {
        upcomingEventList=response.upcomingEvents;
        postEventList=response.pastEvents;
        return;
      }
      Common.showToast("something_went_wrong".tr);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
