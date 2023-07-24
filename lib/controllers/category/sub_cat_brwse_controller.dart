import 'package:get/get.dart';
import 'package:mcsofttech/controllers/base_getx_controller.dart';
import 'package:mcsofttech/models/category/subcategory/Subcatdrowse.dart';
import '../../data/network/apiservices/category_api_services.dart';
import '../../utils/common_util.dart';

class SubCatBrowseController extends BaseController {
  final apiServices = Get.put(CategoryApiServices());
  late List<SubCatBrowse> subCatBrowseList = <SubCatBrowse>[];
  final isSubCatListLoader = false.obs;

  void callSubCategoryBrowseListApi({catId}) async {
    isSubCatListLoader.value = true;
    final response = await apiServices.subCategoryBrowseListApi(catId: catId);
    isSubCatListLoader.value = false;
    if (response == null) Common.showToast("Server Error!");
    if (response != null && response.status == 200) {
      //  subCatBrowseList.clear();

      if (response.subCatBrowse.isNotEmpty) {
        subCatBrowseList = response.subCatBrowse;
      }
    } else {
      Common.showToast(response!.message);
    }
  }
}
