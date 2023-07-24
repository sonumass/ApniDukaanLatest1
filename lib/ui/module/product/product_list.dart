import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mcsofttech/models/home/banner.dart';
import 'package:mcsofttech/ui/dialog/loader.dart';
import 'package:mcsofttech/ui/module/product/product_search_page.dart';
import '../../../controllers/product/product_list_controller.dart';
import '../../../controllers/product/product_search_controller.dart';
import '../../../data/preferences/AppPreferences.dart';
import '../../../services/navigator.dart';
import '../../../theme/my_theme.dart';
import '../../../utils/ad_helper.dart';
import '../../../utils/analytics.dart';
import '../../../utils/palette.dart';
import '../../base/page.dart';
import '../../commonwidget/banner_image_carousel.dart';
import '../../commonwidget/range_bar_widget.dart';
import '../../commonwidget/text_style.dart';
import '../../search/NavigationView.dart';
import '../category/browse_category.dart';
import '../category/subcategory/widget/sub_category_card.dart';

class ProductList extends AppPageWithAppBar {
  static String routeName = "/productList";

  ProductList({Key? key}) : super(key: key);

  static Future<bool?> start<bool>(String title, {pscId, fromPage, banner}) {
    return navigateTo<bool>(routeName,
        currentPageTitle: title,
        arguments: {'pscId': pscId, 'fromPage': fromPage, 'banner': banner});
  }
  final controller = Get.put(ProductSearchController());
  final appPreferences = Get.find<AppPreferences>();
  final _scrollController = ScrollController();
  void setAtScroll() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // Bottom poistion
        if (controller.pageOffSet.value) {
          controller.isLoaderForProduct.value = false;

            controller.productSearch(search: controller.searchController.text);

        }
      }
    });
  }

  @override
  Widget get body {
   // Analytics.sendCurrentScreen("ProductList");
    setAtScroll();


    return Obx(() => controller.isLoaderForProduct.value
        ? const Loader()
        : SingleChildScrollView(
            controller: _scrollController,
            child: Container(
              color: MyColors.coloPageBg,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child:  searchView,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  banner,
                  const SizedBox(
                    height: 10,
                  ),
                  recomendedProduct(),
                ],
              ),
            )));
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

  Widget get searchView {
    return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: screenWidget/1.07,
              height: 45,
              child: Card(
                elevation: 3,
                margin: const EdgeInsets.only(left: 10,right: 15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                child: Center(
                  child: TextField(
                    controller: controller.searchController,
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 20,top: 10),
                      hintStyle: TextStyles.headingTexStyle(
                          color: MyColors.kColorGrey,
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Montserrat'),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(12),
                        child: InkWell(
                          onTap: () {
                            controller.onSearch();
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
            /*InkWell(
              onTap: () {
                _modalBottomSheetMenu();
              },
              child: Card(
                elevation: 3,
                child:
                    SvgPicture.asset(height: 40, 'assets/svg/icon_search.svg'),
              ),
            )*/
          ],
        );
  }

  Widget recomendedProduct() {
    return SizedBox(
      width: screenWidget,
      child: Column(
        children: [
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
    );
  }

  Widget allProduct() {
    return SizedBox(
      width: screenWidget,
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 5),
            child: gridviewWidget(),
          ),
        ],
      ),
    );
  }

  Widget gridviewWidget() {
    return Center(
      child: GridView.builder(
        controller: _scrollController,
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemCount: controller.productSetList.length,
        itemBuilder: (ctx, i) {
          return SubCatProductCard(controller.productSetList[i]);
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.0,
          crossAxisSpacing: 0.0,
          mainAxisSpacing: 5,
          mainAxisExtent: 264,
        ),
      ),
    );
  }

  List<Widget> allProductList() {
    List<Widget> list = [];
    for (int i = 0; i <= controller.productSetList.length - 1; i++) {
      list.add(SizedBox(
        width: screenWidget / 2.2,
        child: SubCatProductCard(controller.productSetList[i]),
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
            "All Product",
            style: TextStyles.headingTexStyle(
                color: Palette.colorTextBlack,
                fontFamily: "assets/font/Oswald-Regular.ttf"),
          ),
          InkWell(
            onTap: () {
              BrowseCategory.start("All CATEGORY");
            },
            child: Text(
              "See All >>",
              style: TextStyles.labelTextStyle(
                  color: Palette.appColor,
                  fontFamily: "assets/font/Oswald-Bold.ttf"),
            ),
          )
        ],
      ),
    );
  }

  void showPriceSheet(context) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        context: context,
        builder: (BuildContext c) {
          return RangeWidget(productController: controller);
        });
  }

  void _modalBottomSheetMenu() {
    List<String> filterType = ["Category", "SubCategory", "Price"];
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        context: Get.context!,
        builder: (builder) {
          return Container(
              color: Colors.transparent,
              //could change this to Color(0xFF737373),
              child: Container(
                  height: 250,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0))),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Filter",
                        style: TextStyles.headingTexStyle(
                            color: Palette.colorTextBlack,
                            fontFamily: "assets/font/Oswald-Regular.ttf"),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: filterType.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            onTap: () {
                              Get.back();
                              filterSelection(filterType[index]);
                            },
                            title: Text(filterType[index]),
                          );
                        },
                      ),
                    ],
                  )));
        });
  }

  Widget setupAlertDialogContainer() {
    List<String> filterType = ["Category", "SubCategory", "Price"];
    return SizedBox(
      height: 200.0, // Change as per your requirement
      width: 200.0, // Change as per your requirement
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: filterType.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            onTap: () {
              Get.back();
              filterSelection(filterType[index]);
            },
            title: Text(filterType[index]),
          );
        },
      ),
    );
  }

  void filterSelection(String filterTpe) {
    switch (filterTpe) {
      case "Category":
        controller.categoryList([]);
        break;
      case "SubCategory":
        controller.subCategoryList([]);
        break;
      case "Price":
        showPriceSheet(Get.context);
        break;
    }
  }
}
