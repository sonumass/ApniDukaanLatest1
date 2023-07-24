import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mcsofttech/constants/Constant.dart';
import 'package:mcsofttech/ui/base/page.dart';
import 'package:mcsofttech/ui/dialog/loader.dart';
import 'package:mcsofttech/ui/module/category/subcategory/subcategory_page.dart';
import '../../../controllers/category/category_controller.dart';
import '../../../models/category/CategoryCatData.dart';
import '../../../models/product_filter_model.dart';
import '../../../services/navigator.dart';
import '../../../theme/my_theme.dart';
import '../../../utils/palette.dart';
import '../../commonwidget/banner_image_carousel.dart';
import '../../commonwidget/data_not_found.dart';
import '../../commonwidget/text_style.dart';
import '../product/product_search_page.dart';

class BrowseCategory extends AppPageWithAppBar {
  static const String routeName = "/browseCategory";

  BrowseCategory({Key? key}) : super(key: key);

  static Future<bool?> start<bool>(String title, {categoryId, banner}) {
    return navigateTo<bool>(routeName,
        currentPageTitle: title,
        arguments: {'categoryId': categoryId, 'banner': banner});
  }

  final List<User> userList = [
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
  final controller = Get.put(CategoryController());
  final _scrollController = ScrollController();

  @override
  Widget get body {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // Bottom poistion
        if (controller.pageOffSet.value) {
          controller.isLoader.value = false;
          controller.callCategoryListApi(page: controller.pageNo.value);
        }
      }
    });
    return Obx(() => controller.isLoader.value
        ? const Loader()
        : SingleChildScrollView(
            child: (controller.categoryDataSetList.isEmpty)
                ? const DataNotFound()
                : Padding(
                    padding: const EdgeInsets.only(
                        left: 12.0, right: 12.0, bottom: 50),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        searchView,
                        const SizedBox(
                          height: 10,
                        ),
                        if (controller.bannerList.isNotEmpty) banner,
                        const SizedBox(
                          height: 10,
                        ),
                        categoryList,
                      ],
                    ),
                  ),
          ));
  }

  Widget get searchView {
    return GestureDetector(
        onTap: () {
          ProductSearchList.start("Products",
              fromPage: "home", banner: controller.bannerList);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: screenWidget / 1.28,
              height: 50,
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                child: Center(
                  child: TextField(
                    enabled: false,
                    textAlign: TextAlign.left,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintStyle: TextStyles.headingTexStyle(
                          color: MyColors.kColorGrey,
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Montserrat'),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12),
                        child: InkWell(
                          onTap: () {
                            ProductSearchList.start("Products",
                                fromPage: "home",
                                banner: controller.bannerList);
                          },
                          child: SvgPicture.asset('assets/svg/icon_search.svg'),
                        ),
                      ),
                      hintText: 'product_category'.tr,
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
            Card(
              elevation: 3,
              child: SvgPicture.asset(height: 40, 'assets/svg/icon_filter.svg'),
            )
          ],
        ));
  }

  Widget get banner {
    return BannerCarousel(bannerList: controller.bannerList);
  }

  Widget get categoryList {
    return SizedBox(
      width: screenWidget,
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Obx(() => Wrap(
                spacing: 10,
                children: list(controller.categoryDataSetList),
              ))
        ],
      ),
    );
  }

  List<Widget> list(List<CategoryCatData> categoryDataList) {
    List<Widget> list = [];
    for (int i = 0; i <= categoryDataList.length - 1; i++) {
      list.add(categoryItem(categoryDataList[i]));
    }

    return list;
  }

  Widget categoryItem(CategoryCatData data) {
    String catImageUrl = "${Constant.baseUrl}${data.categoryImg}";
    return Card(
      child: SizedBox(
        width: screenWidget / 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                SubCagetoryPage.start(data.categoryName.toString(),
                    catId: data.pc_id);
              },
              child: SizedBox(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: FadeInImage.assetNetwork(
                      placeholder: "assets/png/placeholder.png",
                      image: catImageUrl),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  data.categoryName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: TextStyles.headingTexStyle(
                      color: Palette.kColorBlack,
                      fontSize: 10,
                      fontFamily: "assets/font/Oswald-Bold.ttf"),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
