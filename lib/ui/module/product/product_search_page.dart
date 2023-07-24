import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mcsofttech/models/home/banner.dart';
import 'package:mcsofttech/theme/my_theme.dart';
import 'package:mcsofttech/ui/dialog/loader.dart';
import '../../../controllers/product/product_list_controller.dart';
import '../../../controllers/product/product_search_controller.dart';
import '../../../data/preferences/AppPreferences.dart';
import '../../../services/navigator.dart';
import '../../../utils/ad_helper.dart';
import '../../../utils/palette.dart';
import '../../base/page.dart';
import '../../commonwidget/banner_image_carousel.dart';
import '../../commonwidget/range_bar_widget.dart';
import '../../commonwidget/text_style.dart';
import '../../search/NavigationView.dart';
import '../category/browse_category.dart';
import '../category/subcategory/widget/sub_category_card.dart';

class ProductSearchList extends AppPageWithAppBar {
  static String routeName = "/productList";

  ProductSearchList({Key? key}) : super(key: key);

  static Future<bool?> start<bool>(String title, {pscId, fromPage, banner}) {
    return navigateTo<bool>(routeName,
        currentPageTitle: title,
        arguments: {'pscId': pscId, 'fromPage': fromPage, 'banner': banner});
  }

  final controller = Get.put(ProductSearchController());
  final appPreferences = Get.find<AppPreferences>();
  final _scrollController = ScrollController();

  void setAtScroll() {
   /* _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // Bottom poistion
        if (controller.pageOffSet.value) {
          controller.isLoader.value = false;
          if (arguments["fromPage"] == "SubCat") {
            controller.callProductListApi(
                page: controller.pageNo.value, pscIdValue: arguments["pscId"]);
          } else if (arguments["fromPage"] == "Category") {
            controller.callProductListFromCategoryApi(
                page: controller.pageNo.value, catId: arguments['pscId']);
          } else {
            controller.callProductListFromHomeApi(
                page: controller.pageNo.value,
                paramValue: arguments["fromPage"]);
          }
        }
      }
    });*/
  }

  @override
  Widget get body {
    setAtScroll();
    debugPrint("sonu");
    /*if (arguments["fromPage"] == "SubCat") {
      controller.callProductListApi(
          page: controller.pageNo.value, pscIdValue: arguments["pscId"]);
    } else {
      controller.callProductListFromHomeApi(
          page: controller.pageNo, paramValue: arguments["fromPage"]);
    }*/
    return Obx(() => controller.isLoader.value
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
                  const NavigationExample(),
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

  void showPriceSheet(context) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(),
        context: context,
        builder: (BuildContext c) {
          return RangeWidget(productController: controller);
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
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.only(right: 5),
          child: TextField(
            enabled: true,
            textAlign: TextAlign.left,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: Palette.appColor),
                hintText: 'Product,Category',
                border: InputBorder.none,
                suffixIcon: IconButton(
                  onPressed: () {
                    showDialog(
                        context: Get.context!,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Select filter'),
                            content: setupAlertDialogContainer(),
                          );
                        });
                  },
                  icon: const Icon(
                    Icons.filter_alt_sharp,
                    color: Palette.appColor,
                  ),
                )),
          ),
        ),
      ),
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
}
