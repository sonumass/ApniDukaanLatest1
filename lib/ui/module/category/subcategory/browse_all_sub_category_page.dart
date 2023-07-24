import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mcsofttech/constants/Constant.dart';
import 'package:mcsofttech/models/category/subcategory/Subcatdrowse.dart';
import 'package:mcsofttech/ui/base/page.dart';
import 'package:mcsofttech/ui/dialog/loader.dart';
import 'package:mcsofttech/ui/module/product/product_list.dart';
import '../../../../controllers/category/sub_cat_brwse_controller.dart';
import '../../../../data/preferences/AppPreferences.dart';
import '../../../../models/home/banner.dart';
import '../../../../models/product_filter_model.dart';
import '../../../../services/navigator.dart';
import '../../../../theme/my_theme.dart';
import '../../../../utils/palette.dart';
import '../../../commonwidget/banner_image_carousel.dart';
import '../../../commonwidget/data_not_found.dart';
import '../../../commonwidget/text_style.dart';
import '../../product/product_search_page.dart';

class BrowseSubCategory extends AppPageWithAppBar {
  static const String routeName = "/browseSubCategory";

  BrowseSubCategory({Key? key}) : super(key: key);

  static Future<bool?> start<bool>(String title, {catId, banner}) {
    return navigateTo<bool>(routeName,
        currentPageTitle: "all_sub_cat".tr,
        arguments: {'catId': catId, 'banner': banner});
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

  final controller = Get.put(SubCatBrowseController());
  final appPreferences = Get.find<AppPreferences>();

  @override
  Widget get body {
    controller.callSubCategoryBrowseListApi(catId: arguments['catId']);
    return Obx(() => controller.isSubCatListLoader.value
        ? const Loader()
        : SingleChildScrollView(
            child: (arguments['banner'].isEmpty)
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
                        banner,
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
              fromPage: "home", banner: appPreferences.banner);
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
                                banner: appPreferences.banner);
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
    List<String> banner = appPreferences.banner;
    List<BannerData> bannerData = <BannerData>[];
    for (String item in banner) {
      bannerData.add(BannerData(bannerId: 1, img: item));
    }
    return bannerData.isNotEmpty
        ? BannerCarousel(bannerList: bannerData)
        : const SizedBox.shrink();
  }

  Widget get categoryList {
    return SizedBox(
      width: screenWidget,
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Wrap(
            spacing: 10,
            children: list(controller.subCatBrowseList),
          )
        ],
      ),
    );
  }

  List<Widget> list(List<SubCatBrowse> dataList) {
    List<Widget> list = [];
    for (int i = 0; i <= dataList.length - 1; i++) {
      list.add(categoryItem(dataList[i]));
    }

    return list;
  }

  Widget categoryItem(SubCatBrowse data) {
    return Card(
      child: SizedBox(
        width: screenWidget / 4,
        child: InkWell(
          onTap: () {
            ProductList.start(data.subCategoryName.toString(),
                pscId: data.psc_id, fromPage: "SubCat");
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  ProductList.start(data.subCategoryName.toString(),
                      pscId: data.psc_id, fromPage: "SubCat");
                },
                child: SizedBox(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: FadeInImage.assetNetwork(
                        placeholder: "assets/png/placeholder.png",
                        image: Constant.baseUrl + data.subCategoryImg),
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
                    data.subCategoryName,
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
      ),
    );
  }
}
