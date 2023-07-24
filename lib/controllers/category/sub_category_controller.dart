import 'package:filter_list/filter_list.dart';
import 'package:get/get.dart';
import 'package:mcsofttech/controllers/base_getx_controller.dart';
import 'package:mcsofttech/data/network/apiservices/category_api_services.dart';
import 'package:mcsofttech/models/category/CategoryCatData.dart';
import 'package:mcsofttech/models/category/SubCategory.dart';
import 'package:mcsofttech/models/category/subcategory/sub_cate_data.dart';
import 'package:mcsofttech/models/home/AllProduct.dart';
import 'package:mcsofttech/models/home/RecommdedProduct.dart';
import 'package:mcsofttech/utils/common_util.dart';

import '../../data/preferences/AppPreferences.dart';
import '../../models/home/banner.dart';
import '../../models/product_filter_model.dart';

class SubCategoryController extends BaseController {
  SubCategoryController({required this.catId});

  final apiServices = Get.put(CategoryApiServices());
  final appPreferences = Get.find<AppPreferences>();
  final subCategoryDataList = <SubCategory>[].obs;
  final categoryProductDataList = <AllProduct>[].obs;
  final categoryProductSetDataList = <AllProduct>[].obs;
  late List<BannerData> bannerList = <BannerData>[];
  final pageOffSet = true.obs;
  final pageNo = 0.obs;
  final isLoader = false.obs;
  final catId;

  @override
  void onInit() {
    callSubCategoryListApi(catId: catId);
    super.onInit();
  }

  void callSubCategoryListApi({catId}) async {
    isLoader.value = true;
    final response = await apiServices.subCategoryListApi(catId: catId);
    isLoader.value = false;
    if (response == null) Common.showToast("Server Error!");
    if (response != null && response.status == 200) {
      subCategoryDataList.clear();
      if (response.data != null) {
        if (response.data!.subCategories != null &&
            response.data!.subCategories!.isNotEmpty) {
          subCategoryDataList.addAll(response.data!.subCategories!);
        }
      }
      if (response.bannerList != null) {
        bannerList.addAll(response.bannerList!);
      }

      callCategoryProductListApi(catId: catId, page: pageNo.value);
    }
  }

  void callCategoryProductListApi({catId, page}) async {
    showLoader();
    final response = await apiServices.categoryProductListApi(
        catId: catId, page: pageNo, size: 10);
    hideLoader();
    if (response == null) Common.showToast("Server Error!");
    if (response != null &&
        response.status == 200 &&
        response.products!.isNotEmpty) {
      pageNo.value += 1;
      if (response.products != null && response.products!.isNotEmpty) ;
      categoryProductDataList.addAll(response.products!);
      categoryProductSetDataList.addAll(response.products!);
    } else {
      pageOffSet.value = false;
    }
  }

  void onSearch(String name) {
    /*  categoryDataSetList.clear();
    if(name.isNotEmpty){
      categoryDataSetList.addAll(categoryDataList.where((i) => i.categoryName.toLowerCase().contains(name)).toList());

    }else{
      categoryDataSetList.addAll(categoryDataList);
    }*/
  }

  void openFilterDialog() async {
    List<User> userList = [
      User(name: "Agriculture tool", avatar: ""),
      User(name: "Animal ", avatar: ""),
      User(name: "Animal Feed ", avatar: ""),
      User(name: "Crop nutrition ", avatar: ""),
      User(name: "Fruit ", avatar: ""),
      User(name: "Handicraft Item ", avatar: ""),
      User(name: "Poultry and meat ", avatar: ""),
      User(name: "Combine and harvester  ", avatar: ""),
      User(name: "Crop Protection ", avatar: ""),
      User(name: "Food grain and editable oil  ", avatar: ""),
      User(name: "Vegetable ", avatar: ""),
      User(name: "Seeds ", avatar: ""),
      User(name: "Tractor ", avatar: ""),
    ];

    List<User> selectedUserList = [];
    await FilterListDialog.display<User>(
      Get.context!,
      listData: userList,
      selectedListData: selectedUserList,
      choiceChipLabel: (user) => user!.name,
      validateSelectedItem: (list, val) => list!.contains(val),
      onItemSearch: (user, query) {
        return user.name!.toLowerCase().contains(query.toLowerCase());
      },
      onApplyButtonClick: (list) {
        selectedUserList = List.from(list!);

        Get.back();
      },
    );
  }

  void openHomeFilterDialog() async {
    List<User> userList = [
      User(name: "Agriculture tool", avatar: ""),
      User(name: "Buy  ", avatar: ""),
      User(name: "Give On Rent", avatar: ""),
      User(name: "Take on rent ", avatar: ""),
    ];

    List<User> selectedUserList = [];
    await FilterListDialog.display<User>(
      Get.context!,
      listData: userList,
      selectedListData: selectedUserList,
      choiceChipLabel: (user) => user!.name,
      validateSelectedItem: (list, val) => list!.contains(val),
      onItemSearch: (user, query) {
        return user.name!.toLowerCase().contains(query.toLowerCase());
      },
      onApplyButtonClick: (list) {
        selectedUserList = List.from(list!);

        Get.back();
      },
    );
  }
}
