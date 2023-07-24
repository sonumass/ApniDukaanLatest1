import 'package:get/get.dart';
import '../../data/network/apiservices/meridukaan_api_services.dart';
import '../../data/preferences/AppPreferences.dart';
import '../../models/meridukaan/EquiryList.dart';
import '../../utils/common_util.dart';
import '../base_getx_controller.dart';

class EnquiryController extends BaseController {
  final apiServices = Get.put(MeriDukaanApiServices());
  final appPreferences = Get.find<AppPreferences>();
   List<EquiryList> enquiryList=[];
  final isLoader = false.obs;
  final admin=false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void callEnquiryApi() async {
    isLoader.value = true;
    final response =
        await apiServices.enquiryApi(userId: appPreferences.userId,productType:"Enquiry");
    isLoader.value = false;
    if (response == null) Common.showToast("Server Error!");
    if (response != null && response.status == 200) {
      enquiryList=response.equiryList;
    }else{
      Common.showToast(response?.message??"Something went-wrong!");
    }
  }


}
