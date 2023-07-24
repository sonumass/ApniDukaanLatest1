
import 'package:get/get.dart';
import 'package:mcsofttech/controllers/base_getx_controller.dart';
import 'package:mcsofttech/data/network/apiservices/meridukaan_api_services.dart';
import 'package:mcsofttech/models/home/AllProduct.dart';
import 'package:mcsofttech/utils/common_util.dart';
import '../../data/network/apiservices/testimonial_api_service.dart';
import '../../data/preferences/AppPreferences.dart';
import '../../models/home/banner.dart';
import '../../models/meridukaan/meri_dukaan_model.dart';
import '../../models/testimonial/Tesiminial_model.dart';
import '../../models/testimonial/Testimonial.dart';

class TestimonialController extends BaseController {
  final apiServices = Get.put(TestimonialApiServices());
  final isProductLoader = false.obs;
   List<Testimonial> list=[];
  List<BannerData> banner=[];
  final isLoader=true.obs;
  @override
  void onInit() {

    super.onInit();
    callTestimonialApi();
  }

  void callTestimonialApi() async {
    isLoader.value=true;
    final response =
    await apiServices.testimonialApi();
    isLoader.value=false;
    if (response == null) Common.showToast("Server Error!");
    if (response != null && response.status == 200) {
      list=response.testimonial!;
      banner=response.bannerList!;
    } else {
      Common.showToast(response?.message??"Something went wrong");
    }
  }
  void callSearchTestimonialApi() async {
    showLoader();
    final response =
    await apiServices.testimonialApi();
   hideLoader();
    if (response == null) Common.showToast("Server Error!");
    if (response != null && response.status == 200) {
      list=response.testimonial!;
      banner=response.bannerList!;
    } else {
      Common.showToast(response?.message??"Something went wrong");
    }
  }
}
