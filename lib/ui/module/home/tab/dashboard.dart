import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mcsofttech/controllers/home/home_controller.dart';
import 'package:mcsofttech/models/home/CategoryHomeData.dart';
import 'package:mcsofttech/theme/my_theme.dart';
import 'package:mcsofttech/ui/base/page.dart';
import 'package:mcsofttech/ui/commonwidget/banner_image_carousel.dart';
import 'package:mcsofttech/ui/dialog/loader.dart';
import 'package:mcsofttech/ui/module/category/browse_category.dart';
import 'package:mcsofttech/ui/module/category/subcategory/subcategory_page.dart';
import 'package:mcsofttech/ui/module/product/product_list.dart';
import 'package:mcsofttech/ui/module/product/product_search_page.dart';
import '../../../../constants/Constant.dart';
import '../../../../controllers/product/product_list_controller.dart';
import '../../../../utils/ad_helper.dart';
import '../../../../utils/analytics.dart';
import '../../../../utils/analytics_constant.dart';
import '../../../../utils/palette.dart';
import '../../../commonwidget/text_style.dart';
import '../../category/subcategory/widget/sub_best_sellar_card.dart';
import '../../category/subcategory/widget/sub_category_card.dart';

class Dashboard extends AppPageWithAppBar {
  final controller = Get.put(HomeController());

  Dashboard({Key? key}) : super(key: key);

  @override
  double? get toolbarHeight => 0;
  final _scrollController = ScrollController();
  final productController = Get.put(ProductController());
  RxBool adShow = false.obs;

  void setAtScroll() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        controller.isLoader.value = false;
        controller.callProductListFromHomeApi(
            page: controller.pageNo.value, paramValue: "Home");
      }
    });
  }

  @override
  Widget get body {
    //Analytics.sendCurrentScreen(AnalyticsConstants.screenDashboard);
    setAtScroll();
    return Obx(() => controller.isLoader.value
        ? const Loader()
        : SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: searchView,
                ),
                const SizedBox(
                  height: 5,
                ),
                if (controller.bannerList.isNotEmpty) banner,
                const SizedBox(
                  height: 10,
                ),
                productSeeAll,
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 150,
                  child: setCategoryView,
                ),
                const SizedBox(
                  height: 10,
                ),
                recommendedProduct(),
                const SizedBox(
                  height: 10,
                ),
                bestSellerProduct(),
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
          ProductList.start("Products",
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
                            ProductList.start("Products",
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

  Widget get categoryList {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: Column(
        children: [
          productSeeAll,
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget get setCategoryView {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      primary: false,
      mainAxisSpacing: 2,
      childAspectRatio: (1 / .5),
      crossAxisCount: 3,
      children: List.generate(controller.categoryList.length, (index) {
        return GestureDetector(
          onTap: () {
            SubCagetoryPage.start(
                controller.categoryList[index].categoryName.toString(),
                catId: controller.categoryList[index].pc_id);
          },
          child: SizedBox(
            height: 30,
            child: Card(
              elevation: 3,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    FadeInImage.assetNetwork(
                      height: 26,
                      width: 26,
                      placeholder: 'assets/png/placeholder.png',
                      image: Constant.baseUrl +
                          controller.categoryList[index].categoryImg,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Text(
                      maxLines: 2,
                      controller.categoryList[index].categoryName,
                      style: TextStyles.headingTexStyle(
                        color: Palette.colorTextBlack,
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Montserrat',
                      ),
                    )),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget get categoryHorizontallyList {
    return ListView.builder(itemBuilder: (context, index) {
      return listHorizontally;
    });
  }

  Widget get listHorizontally {
    return SizedBox(
      height: 100.0,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Card(child: categoryItem(controller.categoryList[index]));
        },
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Widget categoryItem(CategoryHomeData categoryHomeData) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 10),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              SubCagetoryPage.start(categoryHomeData.categoryName.toString(),
                  catId: categoryHomeData.pc_id);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: SizedBox(
                height: 80,
                width: 80,
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/png/placeholder.png',
                  image: Constant.baseUrl + categoryHomeData.categoryImg,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            categoryHomeData.categoryName,
            style: TextStyles.headingTexStyle(
                color: Palette.kColorBlack,
                fontFamily: "assets/font/Oswald-Bold.ttf"),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget categoryCard(CategoryHomeData categoryHomeData) {
    return categoryItem(categoryHomeData);
  }

  Widget get productSeeAll {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "browse_categories".tr,
            style: TextStyles.headingTexStyle(
              color: Palette.colorTextBlack,
              fontWeight: FontWeight.bold,
              fontSize: 14,
              fontFamily: 'Montserrat',
            ),
          ),
          InkWell(
            onTap: () {
              BrowseCategory.start("All_ATEGORY".tr,
                  banner: controller.bannerList);
            },
            child: SvgPicture.asset(
                width: 28, height: 28, 'assets/svg/icon_left_arrow.svg'),
          )
        ],
      ),
    );
  }

  Widget get recommendedProductText {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "recommended_product".tr,
            style: TextStyles.headingTexStyle(
                color: Palette.colorTextBlack,
                fontWeight: FontWeight.bold,
                fontSize: 14,
                fontFamily: 'Montserrat'),
          ),
          InkWell(
            onTap: () {
              ProductList.start("recommended_product".tr,
                  fromPage: "home", banner: controller.bannerList);
            },
            child: SvgPicture.asset(
                width: 28, height: 28, 'assets/svg/icon_left_arrow.svg'),
          )
        ],
      ),
    );
  }

  Widget recommendedProduct() {
    return Card(
      color: Palette.colorWhite,
      child: SizedBox(
        width: screenWidget,
        child: Column(
          children: [
            recommendedProductText,
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 5),
              child: Wrap(
                spacing: 5,
                children: product(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> product() {
    List<Widget> list = [];
    for (int i = 0; i <= controller.recommdedProductList.length - 1; i++) {
      list.add(SizedBox(
        width: screenWidget / 2.2,
        child: SubCatProductCard(controller.recommdedProductList[i]),
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

  Widget get bestSellerProductText {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "best_seller_product".tr,
            style: TextStyles.headingTexStyle(
                color: Palette.colorTextBlack,
                fontWeight: FontWeight.bold,
                fontSize: 14,
                fontFamily: 'Montserrat'),
          ),
          InkWell(
            onTap: () {
              ProductList.start(
                "best_seller_product".tr,
                fromPage: "home",
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

  Widget bestSellerProduct() {
    return Card(
      color: Palette.colorWhite,
      child: SizedBox(
        width: screenWidget,
        child: Column(
          children: [
            bestSellerProductText,
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 5),
              child: Wrap(
                spacing: 5,
                children: bestSellerproduct(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> bestSellerproduct() {
    List<Widget> list = [];
    for (int i = 0; i <= controller.bestSellingProductList.length - 1; i++) {
      list.add(SizedBox(
        height: 110,
        child: BestSellarCard(controller.bestSellingProductList[i]),
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
                fontSize: 14,
                fontFamily: "Montserrat"),
          ),
          InkWell(
            onTap: () {
              ProductList.start(
                "all_product".tr,
                fromPage: "home",
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
            allProductText,
            const SizedBox(
              height: 10,
            ),
            Obx(() => controller.pageNo.value >= 1
                ? Padding(
                    padding: const EdgeInsets.only(left: 10, right: 5),
                    child: Wrap(
                      spacing: 5,
                      children: allproduct(),
                    ),
                  )
                : const SizedBox.shrink())
          ],
        ),
      ),
    );
  }

  Widget get allProductGridview {
    return Center(
        child: GridView.extent(
            shrinkWrap: true,
            primary: false,
            padding: const EdgeInsets.all(16),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            maxCrossAxisExtent: 200.0,
            children: allproduct()));
  }

  List<Widget> allproduct() {
    List<Widget> list = [];
    for (int i = 0; i <= controller.allProductList.length - 1; i++) {
      list.add(SizedBox(
        width: screenWidget / 2.2,
        child: SubCatProductCard(controller.allProductList[i]),
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

  Widget get addCard {
    return Card(
        child: Padding(
            padding:
                const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
            child: Container(
                width: screenWidget,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(30.0)),
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/png/placeholder.png',
                  image:
                      "https://fiverr-res.cloudinary.com/images/t_main1,q_auto,f_auto,q_auto,f_auto/gigs/123679141/original/a93946ecc9205e8f5eac353dfd88ca12f3d8d86a/create-shopping-sales-banners.jpg",
                  fit: BoxFit.fill,
                ))));
  }

  Widget get productName {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Text("Tractor",
          style: TextStyles.labelTextStyle(
              color: Palette.colorTextBlack,
              fontFamily: "assets/font/Oswald-Regular.ttf")),
    );
  }

/*Widget  gridviewWidget(RxList<String> list){
    return Center(
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: false,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemCount: 4,
        itemBuilder: (ctx, i) {
          return ProductCard();
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
  }*/
}
