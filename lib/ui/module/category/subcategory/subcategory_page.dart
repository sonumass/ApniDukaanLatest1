import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mcsofttech/models/category/SubCategory.dart';
import 'package:mcsofttech/ui/base/page.dart';
import 'package:mcsofttech/ui/dialog/loader.dart';
import 'package:mcsofttech/ui/module/category/subcategory/widget/sub_category_card.dart';
import '../../../../controllers/category/sub_category_controller.dart';
import '../../../../services/navigator.dart';
import '../../../../theme/my_theme.dart';
import '../../../../utils/ad_helper.dart';
import '../../../../utils/palette.dart';
import '../../../commonwidget/banner_image_carousel.dart';
import '../../../commonwidget/primary_elevated_button.dart';
import '../../../commonwidget/text_style.dart';
import '../../product/product_list.dart';
import '../../product/product_search_page.dart';
import 'browse_all_sub_category_page.dart';

class SubCagetoryPage extends AppPageWithAppBar {
  static String routeName = "/subCategory";

  SubCagetoryPage({Key? key}) : super(key: key);

  static Future<bool?> start<bool>(
    String title, {
    catId,
  }) {
    return navigateTo<bool>(routeName,
        currentPageTitle: title, arguments: {'catId': catId});
  }

  late SubCategoryController controller;

  final _scrollController = ScrollController();

  void setAtScroll() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // Bottom poistion
        if (controller.pageOffSet.value) {
          controller.isLoader.value = false;
          controller.callCategoryProductListApi(
              catId: arguments['catId'], page: controller.pageNo.value);
        }
      }
    });
  }

  @override
  Widget get body {
    controller = Get.put(SubCategoryController(catId: arguments["catId"]));
    setAtScroll();
    return Obx(() => controller.isLoader.value
        ? const Loader()
        : SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: searchView,
                ),
                const SizedBox(
                  height: 10,
                ),
                if (controller.bannerList.isNotEmpty) banner,
                const SizedBox(
                  height: 10,
                ),
                categoryList,
                const SizedBox(
                  height: 10,
                ),
                allProduct(),
              ],
            ),
          ));
  }

  Widget get banner {
    return BannerCarousel(bannerList: controller.bannerList);
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

  Widget get browseAll {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "browse_sub_categories".tr,
            style: TextStyles.headingTexStyle(
                color: Palette.colorTextBlack,
                fontFamily: "assets/font/Oswald-Regular.ttf"),
          ),
          InkWell(
            onTap: () {
              BrowseSubCategory.start("all_sub_cat".tr,
                  banner: controller.bannerList, catId: arguments['catId']);
            },
            child: Text(
              "see_all".tr,
              style: TextStyles.labelTextStyle(
                  color: Palette.appColor,
                  fontFamily: "assets/font/Oswald-Bold.ttf"),
            ),
          )
        ],
      ),
    );
  }

  Widget browserAllNavigation(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyles.headingTexStyle(
              color: Palette.colorTextBlack,
              fontWeight: FontWeight.bold,
              fontSize: 14,
              fontFamily: 'Montserrat',
            ),
          ),
          GestureDetector(
            onTap: () {
              BrowseSubCategory.start("all_sub_cat".tr,
                  banner: controller.bannerList, catId: arguments['catId']);
            },
            child: SvgPicture.asset(
                width: 28, height: 28, 'assets/svg/icon_left_arrow.svg'),
          )
        ],
      ),
    );
  }

  Widget get categoryList {
    return Card(
      color: Palette.colorWhite,
      child: SizedBox(
        width: screenWidget,
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            browserAllNavigation("browse_sub_categories".tr),
            const SizedBox(
              height: 10,
            ),
            subCategory,
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(controller.subCategoryDataList.length,
                    (i) => categoryCard(i)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget categoryCard(int index) {
    return categoryItem(controller.subCategoryDataList[index]);
  }

  Widget subCateText(String subCatName, int pscId) {
    return SizedBox(
      height: 45,
      child: PrimaryElevatedBtn(
          subCatName,
          () async => {
                ProductList.start(
                  subCatName,
                  pscId: pscId,
                  fromPage: "SubCat",
                  banner: controller.bannerList,
                )
              },
          borderRadius: 10.0),
    );
  }

  Widget categoryItem(SubCategory subCategory) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 10),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              ProductList.start(
                subCategory.subCategoryName,
                banner: controller.bannerList,
              );
            },
            child: subCateText(subCategory.subCategoryName, subCategory.psc_id),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget browserProductAllNavigation(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyles.headingTexStyle(
              color: Palette.colorTextBlack,
              fontWeight: FontWeight.bold,
              fontSize: 14,
              fontFamily: 'Montserrat',
            ),
          ),
          GestureDetector(
            onTap: () {
              ProductList.start(
                "all_product".tr,
                fromPage: "Category",
                pscId: arguments['catId'],
                banner: controller.bannerList,
              );
            },
            child: SvgPicture.asset(
                width: 28, height: 28, 'assets/svg/icon_left_arrow.svg'),
          )
        ],
      ),
    );
  }

  Widget allProduct() {
    return Card(
      color: Palette.colorWhite,
      child: SizedBox(
        width: screenWidget,
        child: Column(
          children: [
            browserProductAllNavigation("all_product".tr),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 5),
              child: Wrap(
                spacing: 5,
                children: allProductList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> allProductList() {
    List<Widget> list = [];
    for (int i = 0;
        i <= controller.categoryProductSetDataList.length - 1;
        i++) {
      list.add(SizedBox(
        width: screenWidget / 2.2,
        child: SubCatProductCard(controller.categoryProductSetDataList[i]),
      ));
      if ((i + 1) % 6 == 0) {
        list.add(SizedBox(
          height: 150,
          child: AdWidget(
            ad: AdHelper.getBannerAd()..load(),
            key: UniqueKey(),
          ),
        ));
      }
    }
    return list;
  }

  Widget get allProductText {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "all_product".tr,
            style: TextStyles.headingTexStyle(
                color: Palette.colorTextBlack,
                fontFamily: "assets/font/Oswald-Regular.ttf"),
          ),
          InkWell(
            onTap: () {
              ProductList.start(
                "all_product".tr,
                fromPage: "Category",
                pscId: arguments['catId'],
                banner: controller.bannerList,
              );
            },
            child: Text(
              "see_all".tr,
              style: TextStyles.labelTextStyle(
                  color: Palette.appColor,
                  fontFamily: "assets/font/Oswald-Bold.ttf"),
            ),
          )
        ],
      ),
    );
  }

  Widget get subCategory {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "sub_category".tr,
            style: TextStyles.headingTexStyle(
                color: Palette.colorTextBlack,
                fontFamily: "assets/font/Oswald-Regular.ttf"),
          ),
        ],
      ),
    );
  }
}
