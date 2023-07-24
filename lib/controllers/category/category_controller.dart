import 'package:filter_list/filter_list.dart';
import 'package:get/get.dart';
import 'package:mcsofttech/controllers/base_getx_controller.dart';
import 'package:mcsofttech/data/network/apiservices/category_api_services.dart';
import 'package:mcsofttech/models/category/CategoryCatData.dart';
import 'package:mcsofttech/models/home/banner.dart';
import 'package:mcsofttech/utils/common_util.dart';

import '../../data/preferences/AppPreferences.dart';
import '../../models/product_filter_model.dart';

class CategoryController extends BaseController {
  final apiServices = Get.put(CategoryApiServices());
  final appPreferences = Get.find<AppPreferences>();
  final categoryDataList = <CategoryCatData>[].obs;
  final bannerList = <BannerData>[].obs;
  final categoryDataSetList = <CategoryCatData>[].obs;
  final subCatEnable = false.obs;
  final pageOffSet = true.obs;
  final pageNo = 0.obs;
  final isLoader = false.obs;

  @override
  void onInit() {
    callCategoryListApi(page: "0");
    super.onInit();
  }

  void callCategoryListApi({page}) async {
    pageNo.value == 0 ? isLoader.value = true : isLoader.value = false;
    final response = await apiServices.categoryListApi(size: 30, page: page);
    isLoader.value = false;
    if (response == null) Common.showToast("Server Error!");
    if (response != null &&
        response.status == 200 &&
        response.categoryData!.isNotEmpty) {
      pageNo.value += 1;
      if (response.bannerList != null && response.bannerList!.isNotEmpty) {
        bannerList.addAll(response.bannerList!);
      }
      if (response.categoryData != null && response.categoryData!.isNotEmpty) ;
      categoryDataList.addAll(response.categoryData!);
      categoryDataSetList.addAll(response.categoryData!);
    } else {
      pageOffSet.value = false;
    }
  }

  void onSearch(String name) {
    categoryDataSetList.clear();
    if (name.isNotEmpty) {
      categoryDataSetList.addAll(categoryDataList
          .where((i) => i.categoryName.toLowerCase().contains(name))
          .toList());
    } else {
      categoryDataSetList.addAll(categoryDataList);
    }
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
