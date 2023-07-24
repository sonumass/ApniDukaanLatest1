import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mcsofttech/constants/Constant.dart';
import 'package:mcsofttech/controllers/meridhukaan/add_user_action_controller.dart';
import 'package:mcsofttech/controllers/product/product_Detail_controller.dart';
import 'package:mcsofttech/data/preferences/AppPreferences.dart';
import 'package:mcsofttech/models/home/AllProduct.dart';
import 'package:mcsofttech/ui/base/page.dart';
import 'package:mcsofttech/ui/dialog/loader.dart';
import 'package:mcsofttech/ui/module/login/login_page.dart';
import 'package:mcsofttech/ui/module/product/product_list.dart';
import 'package:mcsofttech/ui/module/product/widget/image_carousel.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../controllers/meridhukaan/total_visitor_controller.dart';
import '../../../controllers/product/product_list_controller.dart';
import '../../../models/product_featureDetailsValue.dart';
import '../../../notifire/cart_notifire.dart';
import '../../../services/navigator.dart';
import '../../../theme/my_theme.dart';
import '../../../utils/analytics.dart';
import '../../../utils/common_util.dart';
import '../../../utils/palette.dart';
import '../../commonwidget/kart_counter.dart';
import '../../commonwidget/outline_elevated_button.dart';
import '../../commonwidget/primary_elevated_button.dart';
import '../../commonwidget/text_style.dart';
import '../cart/cart_list_page.dart';
import '../category/subcategory/widget/sub_category_similler_card.dart';
import '../home/home.dart';

class ProductDetail extends AppPageWithAppBar {
  static const String routeName = "/productDetail";

  ProductDetail({Key? key}) : super(key: key);

  static Future<bool?> start<bool>(
    String title, {
    comingFrom,
    allProduct,
  }) {
    if (comingFrom == "Similar") {
      return navigatePlacementNamedl(routeName,
          currentPageTitle: title,
          arguments: {
            'allProduct': allProduct,
          });
    }
    return navigateTo<bool>(routeName, currentPageTitle: title, arguments: {
      'allProduct': allProduct,
    });
  }

  final controller = Get.put(ProductDetailController());
  final userActionController = Get.put(AddUserActionController());
  final controllerProduct = Get.put(ProductController());
  final appPreferences = Get.find<AppPreferences>();
  final wishController = Get.put(TotalVisitorController());
  late AllProduct allProduct;
  final quantity = 1.obs;

  @override
  List<Widget>? get action => [
        InkWell(
          onTap: () {
            showDialog(
                context: Get.context!,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Select Language'),
                    content: Common.languageAlertDialoagContainer(),
                  );
                });
          },
          child: Padding(
            padding:
                const EdgeInsets.only(left: 0, right: 15, top: 8, bottom: 8),
            child: Stack(
              children: [
                Align(
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                        width: 25, height: 25, 'assets/png/icon_lang.svg')),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () async => await launchUrl(Uri.parse(
              "whatsapp://send?phone=+91${allProduct.mobile}&text=https://www.f2df.com/product/details?id=${allProduct.p_id} \n For Enquiry on app ‘I am interested in this product")),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 0, right: 15, top: 8, bottom: 8),
            child: Stack(
              children: [
                Align(
                    alignment: Alignment.center,
                    child: SvgPicture.asset("assets/png/icon_chat_app.svg")),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            CartListPage.start("my_cart".tr);
            if (appPreferences.isLoggedIn) {
              // KartStorePage.start();
            } else {
              //  LogInScreen.start();
            }
          },
          child: Padding(
            padding:
                const EdgeInsets.only(left: 0, right: 15, top: 8, bottom: 8),
            child: Stack(
              children: [
                Align(
                    alignment: Alignment.center,
                    child: SvgPicture.asset('assets/png/icon_cart.svg')),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Obx(() => KartCounter(
                        count: Provider.of<CartNotifier>(Get.context!)
                            .productList
                            .length,
                      )),
                )
              ],
            ),
          ),
        ),
      ];

  @override
  Widget get body {
    //  Analytics.sendCurrentScreen("ProductDetail");
    allProduct = arguments['allProduct'];
    quantity.value = allProduct.quantity < 1 ? 1 : 1;
    controllerProduct.callProductDetailApi(productId: allProduct.p_id);
    return Obx(
        () => controllerProduct.isLoader.value ? const Loader() : container);
  }

  Widget get container {
    return Container(
      color: MyColors.coloPageBg,
      width: screenWidget,
      margin: const EdgeInsets.symmetric(vertical: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Stack(
              children: [
                imageCarousel,
                Positioned(
                  top: 190,
                  bottom: 20,
                  child: Container(
                    color: Colors.transparent,
                    width: screenWidget,
                    height: screenHeight,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: productTypeAndDetailCard,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          /* allProduct.productDesc.isNotEmpty
                              ? descriptionData
                              : const SizedBox.shrink(),*/
                          cartAndBuy,
                          const SizedBox(
                            height: 10,
                          ),
                          if (!(allProduct.featureDetailsValue!.isNotEmpty &&
                              allProduct.featureDetailsValue!
                                  .where((element) =>
                                      element.productFeatureKey.toLowerCase().contains("mrp"))
                                  .isNotEmpty))
                            whatsAppAndCall,
                          const SizedBox(
                            height: 10,
                          ),
                          if (controllerProduct
                              .productUserDetailList.isNotEmpty)
                            Card(
                              elevation: 2,
                              child: Center(
                                child: Obx(() => userProductList),
                              ),
                            ),
                          const SizedBox(
                            height: 10,
                          ),
                          divider,
                          const SizedBox(
                            height: 10,
                          ),
                          if (controllerProduct
                              .productSimilerDetailList.isNotEmpty)
                            similerProductList(),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget get productTypeAndDetailCard {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          productTye,
          const SizedBox(
            height: 10,
          ),
          categoryDetail,
          const SizedBox(
            height: 10,
          ),
          if (allProduct.assured)
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: SvgPicture.asset('assets/svg/icon_assured.svg'),
            ),
          const SizedBox(
            height: 10,
          ),
          productPriceAndFav,
          const SizedBox(
            height: 10,
          ),
          divider,
          const SizedBox(
            height: 10,
          ),
          itemDetail,
          const SizedBox(
            height: 10,
          ),
          (allProduct.featureDetailsValue != null &&
                  allProduct.featureDetailsValue!.isNotEmpty)
              ? detailList
              : const SizedBox.shrink(),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  ButtonStyle get checkOutButtonStyle {
    return ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(1.0))),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> state) {
          if (state.contains(MaterialState.pressed)) {
            return Palette.buttonsColor;
          } else if (state.contains(MaterialState.disabled)) {
            return Palette.buttonsColor;
          }
          return Palette.buttonsColor;
        }));
  }

  Widget get imageCarousel {
    AllProduct allProduct = arguments['allProduct'];
    List<String> imageList = [
      Constant.baseUrl + allProduct.img1,
      Constant.baseUrl + allProduct.img2,
      Constant.baseUrl + allProduct.img3,
      Constant.baseUrl + allProduct.img4
    ];
    return Carousel(imageList: imageList);
  }

  Widget get userProductList {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: Column(
        children: [
          productAllNavigation("Same Seller Products"),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 210,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(
                  controllerProduct.productUserDetailList.length,
                  (i) => controllerProduct.productUserDetailList[i].p_id==allProduct.p_id?const SizedBox.shrink():SizedBox(
                  width: screenWidget / 2.2,
                  child: SubCatProductSimillerCard(
                      controllerProduct.productUserDetailList[i],
                      "detail"))),
            ),
          )
        ],
      ),
    );
  }

  Widget productAllNavigation(String text) {
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
              ProductList.start("recommended_product".tr,
                  fromPage: "home", banner: appPreferences.banner);
            },
            child: SvgPicture.asset(
                width: 28, height: 28, 'assets/svg/icon_left_arrow.svg'),
          )
        ],
      ),
    );
  }

  Widget similerProductList() {
    return Card(
      color: Palette.colorWhite,
      child: SizedBox(
        width: screenWidget,
        child: Column(
          children: [
            similerProductText,
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 5),
              child: Wrap(
                spacing: 5,
                children: similerProduct(),
              ),
            ),
          ],
        ),
      ),
    );
  }
  List<Widget> similerProduct() {
    List<Widget> list = [];
    for (int i = 0;
    i <= controllerProduct.productSimilerDetailList.length - 1;
    i++) {
      if(controllerProduct.productSimilerDetailList[i].p_id!=allProduct.p_id) {
        list.add(SizedBox(
          width: screenWidget / 2.2,
          child: SubCatProductSimillerCard(
              controllerProduct.productSimilerDetailList[i], "detail"),
        ));
      }
    }
    return list;
  }


  Widget get sellerProductText {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Same Seller Products",
            style: TextStyles.headingTexStyle(
                color: Palette.colorTextBlack,
                fontFamily: "assets/font/Oswald-Regular.ttf"),
          ),
        ],
      ),
    );
  }

  Widget get similerProductText {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Similar Products",
            style: TextStyles.headingTexStyle(
                color: Palette.colorTextBlack,
                fontFamily: "assets/font/Oswald-Regular.ttf"),
          ),
        ],
      ),
    );
  }

  Widget get productPriceAndFav {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          price,
          Obx(() => InkWell(
                onTap: () {
                  userActionController.userActionApi(
                      allProduct.productName,
                      allProduct.productFee.toString(),
                      allProduct.subCategory?.subCategoryName ?? "",
                      allProduct.p_id,
                      "Wish",
                      allProduct.mobile,
                      "fab",
                      allProduct.userId.toString(),
                      allProduct.img1,
                      "",
                      "1");
                },
                child: Icon(
                  Icons.favorite,
                  color: userActionController.fabProduct.value
                      ? Palette.kColorRed
                      : Palette.kColorGrey,
                ),
              ))
        ],
      ),
    );
  }

  Widget get productTye {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: screenWidget / 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Card(
                margin: const EdgeInsets.only(left: 12, right: 12),
                color: Colors.red,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, bottom: 5, top: 5),
                  child: Text("For : ${allProduct.typeOfProduct}",
                      textAlign: TextAlign.right,
                      style: TextStyles.headingTexStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Montserrat')),
                ),
              ),
              if (allProduct.organic)
                SvgPicture.asset("assets/svg/icon_organic.svg"),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            Common.share(
                linkUrl:
                    "https://www.f2df.com/product/details?id=${allProduct.p_id}",
                title: allProduct.productName);
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: SvgPicture.asset("assets/svg/icon_share.svg"),
          ),
        )
      ],
    );
  }

  Widget get categoryDetail {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(allProduct.productName,
              style: TextStyles.headingTexStyle(
                  fontSize: 18,
                  color: Palette.kColorBlack,
                  fontFamily: "Montserrat")),
          const SizedBox(
            height: 10,
          ),
          Text(
            "${allProduct.productCategory?.categoryName}> ${allProduct.subCategory?.subCategoryName}> ${allProduct.productName}",
            maxLines: 2,
            style: TextStyles.headingTexStyle(
                fontSize: 12,
                color: Palette.kColorGrey,
                fontWeight: FontWeight.normal,
                fontFamily: "Montserrat"),
          ),
        ],
      ),
    );
  }

  Widget get price {
    return Row(
      children: [
        Text("\u{20B9} ${allProduct.productFee}",
            style: TextStyles.headingTexStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat')),
        const SizedBox(
          width: 5,
        ),
        Text("\u{20B9} ${allProduct.oldFee}",
            style: TextStyles.headingTexStyle(
                fontSize: 14,
                decoration: TextDecoration.lineThrough,
                color: Palette.kColorRed,
                fontWeight: FontWeight.normal,
                fontFamily: 'Montserrat'))
      ],
    );
  }

  Widget get itemName {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: Text(allProduct.productName,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          softWrap: false,
          style: TextStyles.labelTextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat')),
    );
  }

  Widget get itemAddressAndTime {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: screenWidget / 1.3,
            child: Row(
              children: [
                SizedBox(
                  width: screenWidget / 9,
                  child: const Icon(Icons.pin_drop_outlined),
                ),
                SizedBox(
                  width: screenWidget / 1.8,
                  child: itemAddress,
                )
              ],
            ),
          ),
          dateTime
        ],
      ),
    );
  }

  Widget get itemAddress {
    //String address=Common.getAddress(allProduct.latitude??"", allProduct.lognitude??"") as String;
    return Text("Address to founded",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        softWrap: false,
        style: TextStyles.labelTextStyle(
            color: Palette.colorTextGrey,
            fontSize: 14,
            fontFamily: "assets/font/Oswald-Regular.ttf"));
  }

  Widget get dateTime {
    return Text("9 Aug",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        softWrap: false,
        style: TextStyles.labelTextStyle(
            fontSize: 14,
            color: Palette.colorTextGrey,
            fontFamily: "assets/font/Oswald-Regular.ttf"));
  }

  Widget get divider {
    return const Divider(
      color: Palette.kColorGrey,
    );
  }

  Widget get itemDetail {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: Text("Detail",
          style: TextStyles.headingTexStyle(
              color: Palette.colorTextBlack,
              fontFamily: "assets/font/Oswald-Regular.ttf")),
    );
  }

  Widget get detailList {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: List.generate(allProduct.featureDetailsValue!.length,
            (i) => categoryText(allProduct.featureDetailsValue![i])),
      ),
    );
  }

  Widget categoryText(ProductFeatureDetailsValue data) {
    if(data.productFeatureKey.isEmpty){
      return const SizedBox.shrink();
    }
    if(data.productFeatureKey=="AGGREMENT"){
      return const SizedBox.shrink();
    }
    if(data.productFeatureKey=="DELIVERY AVAILABLE"){
      return const SizedBox.shrink();
    }
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: screenWidget / 2.5,
                  child: Text(data.productFeatureKey,
                      style: TextStyles.labelTextStyle(
                          fontSize: 15,
                          color: Palette.colorTextGrey,
                          fontFamily: "assets/font/Oswald-Regular.ttf")),
                ),
                SizedBox(
                  width: screenWidget / 2.5,
                  child: Center(
                    child: Text(
                        data.productFeatureValue.isEmpty
                            ? "-"
                            : data.productFeatureValue,
                        textAlign: TextAlign.left,
                        style: TextStyles.labelTextStyle(
                            fontSize: 14,
                            color: Palette.colorTextBlack,
                            fontFamily: "assets/font/Oswald-Regular.ttf")),
                  ),
                ),
              ],
            )),
        const SizedBox(height: 10,),
        const Divider(
          height: 1,
          color: MyColors.colorTextGrey,
        ),
       const  SizedBox(height: 10,),
      ],
    );
  }

  Widget get description {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: Text("Description",
          style: TextStyles.headingTexStyle(
              color: Palette.colorTextBlack, fontFamily: "Montserrat")),
    );
  }

  Widget get descriptionData {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Card(
        elevation: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 10,
            ),
            description,
            Padding(
                padding: const EdgeInsets.only(left: 12, right: 12, top: 10),
                child: Text(allProduct.productDesc,
                    style: TextStyles.labelTextStyle(
                        color: Palette.colorTextBlack,
                        fontWeight: FontWeight.normal,
                        fontFamily: "Montserrat"))),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }

  Widget buildImage() {
    const image = NetworkImage(
        "https://w7.pngwing.com/pngs/754/2/png-transparent-samsung-galaxy-a8-a8-user-login-telephone-avatar-pawn-blue-angle-sphere-thumbnail.png");

    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: ClipOval(
        child: Material(
          color: Colors.transparent,
          child: Ink.image(
            image: image,
            fit: BoxFit.cover,
            width: 50,
            height: 50,
            child: InkWell(onTap: () {}),
          ),
        ),
      ),
    );
  }

  share() {
    final RenderBox? box = Get.context!.findRenderObject() as RenderBox?;
    Share.share("F2DF App- https://f2df.page.link/F2DFApp",
        subject: "Nice",
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }

  Widget get whatsAppAndCall {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: MyColors.themeColor),
              height: 40,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: MaterialButton(
                  onPressed: () {
                    userActionController.userActionApi(
                        allProduct.productName,
                        allProduct.productFee.toString(),
                        allProduct.subCategory?.subCategoryName ?? "",
                        allProduct.p_id,
                        "Enquiry",
                        allProduct.mobile,
                        "whatsApp",
                        allProduct.userId.toString(),
                        allProduct.img1,
                        "",
                        "1");
                  },
                  color: MyColors.themeColor,
                  textColor: Colors.white,
                  shape: const CircleBorder(),
                  child: const Icon(
                    Icons.whatsapp,
                  ),
                ),
              ),
            )),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1, color: MyColors.themeColor)),
              height: 40,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: InkWell(
                  onTap: () {
                    userActionController.userActionApi(
                        allProduct.productName,
                        allProduct.productFee.toString(),
                        allProduct.subCategory?.subCategoryName ?? "",
                        allProduct.p_id,
                        "Enquiry",
                        allProduct.mobile,
                        "call",
                        allProduct.userId.toString(),
                        allProduct.img1,
                        "",
                        "1");
                  },
                  child: const Icon(
                    Icons.call,
                  ),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget get incrementCount {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      width: 130,
      height: 40,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Palette.colorWhite),
          borderRadius: BorderRadius.circular(10),
          color: Palette.kColorExtraLightBlack),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            width: 7,
          ),
          InkWell(
              onTap: () {
                if (quantity.value >= 1) {
                  Provider.of<CartNotifier>(Get.context!, listen: false)
                      .removeFromCart(allProduct.p_id);
                  quantity.value -= 1;
                }
              },
              child: const Icon(
                Icons.delete_outline_rounded,
                color: Palette.kColorDarkGrey,
                size: 20,
              )),
          const SizedBox(
            width: 7,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 3),
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3), color: Colors.white),
            child: SizedBox(
              width: 40,
              child: Obx(() => Text(
                    quantity.value.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyles.headingTexStyle(color: Palette.appColor),
                  )),
            ),
          ),
          const SizedBox(
            width: 7,
          ),
          InkWell(
              onTap: () {
                quantity.value += 1;
              },
              child: Text(
                "+",
                textAlign: TextAlign.center,
                style: TextStyles.headingTexStyle(
                    color: Palette.appColor, fontWeight: FontWeight.w900),
              )),
          const SizedBox(
            width: 7,
          ),
        ],
      ),
    );
  }

  /* Widget get incrementCount {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      width: 130,
      height: 40,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Palette.colorWhite),
          borderRadius: BorderRadius.circular(10),
          color: Palette.kColorExtraLightBlack),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            width: 7,
          ),
          InkWell(
              onTap: () {
                if (quantity.value <= 1) {
                  Provider.of<CartNotifier>(Get.context!, listen: false)
                      .removeFromCart(allProduct.p_id);
                }
                quantity.value -= 1;
              },
              child: const Icon(
                Icons.delete_outline_rounded,
                color: Palette.kColorDarkGrey,
                size: 20,
              )),
          const SizedBox(
            width: 7,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 3),
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3), color: Colors.white),
            child: SizedBox(
              width: 40,
              child: Obx(() => Text(
                    quantity.value.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyles.headingTexStyle(color: Palette.appColor),
                  )),
            ),
          ),
          const SizedBox(
            width: 7,
          ),
          InkWell(
              onTap: () {
                quantity.value += 1;
              },
              child: Text(
                "+",
                textAlign: TextAlign.center,
                style: TextStyles.headingTexStyle(
                    color: Palette.appColor, fontWeight: FontWeight.w900),
              )),
          const SizedBox(
            width: 7,
          ),
        ],
      ),
    );
  }*/

  Widget get cartAndBuy {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      child: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                incrementCount,
                Row(
                  children: [
                    Text("Total",
                        style: TextStyles.headingTexStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Montserrat')),
                    const SizedBox(
                      width: 10,
                    ),
                    Obx(() => Text(
                        "\u{20B9} ${allProduct.productFee * quantity.value}",
                        style: TextStyles.headingTexStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat'))),
                  ],
                )
              ],
            ),
            if (allProduct.featureDetailsValue!.isNotEmpty &&
                allProduct.featureDetailsValue!
                    .where((element) => element.productFeatureKey.toLowerCase().contains("mrp"))
                    .isNotEmpty)
              Row(
                children: [
                  Expanded(
                      child: PrimaryElevatedBtn("Enquiry on lead", () {
                    userActionController.userActionApi(
                        allProduct.productName,
                        allProduct.productFee.toString(),
                        allProduct.subCategory?.subCategoryName ?? "",
                        allProduct.p_id,
                        "Enquiry",
                        "9138111860",
                        "whatsApp",
                        allProduct.userId.toString(),
                        allProduct.img1,
                        "",
                        "1");
                  })),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: OutLineElevatedBtn("BUY NOW", () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(8.0),
                                topLeft: Radius.circular(15.0)),
                            side: BorderSide(color: Colors.white)),
                        context: Get.context!,
                        builder: (BuildContext c) {
                          return Padding(
                              padding: MediaQuery.of(Get.context!).viewInsets,
                              child: Container(
                                  child: Wrap(
                                children: <Widget>[
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Divider(
                                    height: 1,
                                    color: MyColors.themeColor,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        payFullPayment,
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        if((allProduct.productFee* quantity.value)>1000)payPartial,
                                        const SizedBox(height: 50),
                                      ],
                                    ),
                                  ),
                                ],
                              )));
                        });
                    // Common.showToast("Coming soon");
                    //buyNow();
                  })),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget get payFullPayment {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: SizedBox(
        width: screenWidget,
        height: 45,
        child: PrimaryElevatedBtn(
            "Pay Full Payment",
            () async => {
                  wishController
                      .createOrderId(allProduct.productFee*quantity.value)
                },
            borderRadius: 10.0),
      ),
    );
  }

  Widget get payPartial {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: SizedBox(
        width: screenWidget,
        height: 45,
        child: PrimaryElevatedBtn("Book @ 10%", () async {
          int price = allProduct.productFee * quantity.value;
          double data = (price / 10);
          wishController.createOrderIdForBook(data.toInt());
        }, borderRadius: 10.0),
      ),
    );
  }

  Widget get callAndChat {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      child: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                incrementCount,
                Row(
                  children: [
                    Text("Total",
                        style: TextStyles.headingTexStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Montserrat')),
                    const SizedBox(
                      width: 10,
                    ),
                    Obx(() => Text(
                        "\u{20B9} ${allProduct.productFee * quantity.value}",
                        style: TextStyles.headingTexStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat'))),
                  ],
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: PrimaryElevatedBtn("ADD TO CART", () {
                  Get.delete<ProductDetailController>();
                  CartListPage.start("CHAT NOW");
                })),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: OutLineElevatedBtn("CALL NOW", () {
                  Common.showToast("Coming soon");
                })),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget get buyNowAndAddToCartBottomUi {
    return Row(
      children: [
        SizedBox(
          width: screenWidget / 2,
          height: screenHeight / 15,
          child: PrimaryElevatedBtn(buttonStyle: checkOutButtonStyle, "Buy now",
              () {
            Get.delete<ProductDetailController>();
            CartListPage.start("My Cart");
          }, borderRadius: 1.0),
        ),
        SizedBox(
          width: screenWidget / 2,
          height: screenHeight / 15,
          child: PrimaryElevatedBtn(
              "Add to cart",
              () async => {
                    if (appPreferences.isLoggedIn)
                      {controller.addToCart(allProduct)}
                    else
                      {LoginPage.start()}
                  },
              borderRadius: 1.0),
        ),
        Obx(() => similerProductList()),
        whatsAppAndCall,
        const SizedBox(
          height: 10,
        ),
        divider,
      ],
    );
  }

  void buyNow() {
    Razorpay razorpay = Razorpay();
    var options = {
      'key': Constant.razorPayKey,
      'amount': allProduct.productFee * 100,
      'name': 'F2DF.',
      'orderId': '${appPreferences.userId}${Common.currentDateTimeStamp}',
      'description': allProduct.productName,
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {
        'contact': appPreferences.mobile,
        'email': appPreferences.email
      },
      'external': {}
    };
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
    razorpay.open(options);
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    wishController.saveTransaction(
        0,
        response.code ?? 0,
        response.error.toString(),
        response.message ?? "",
        "",
        wishController.totalPrice.value,
        "",
        "",
        false);
    showAlertDialog(Get.context!, "Payment Failed",
        "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    Provider.of<CartNotifier>(Get.context!, listen: false).clearCart();
    wishController.saveTransaction(
        0,
        0,
        "",
        "",
        response.orderId ?? "",
        wishController.totalPrice.value,
        response.paymentId ?? "",
        response.signature ?? "",
        false);
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    Home.start();
    showAlertDialog(
        Get.context!, "External Wallet Selected", "${response.walletName}");
  }

  void showAlertDialog(BuildContext context, String title, String message) {
    // set up the buttons
    Widget continueButton = ElevatedButton(
      child: const Text("Continue"),
      onPressed: () {
        Get.back();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
