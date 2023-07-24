import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mcsofttech/constants/Constant.dart';
import 'package:mcsofttech/controllers/meridhukaan/user_dashboard_controller.dart';
import 'package:mcsofttech/models/home/AllProduct.dart';
import 'package:mcsofttech/ui/module/meridukaan/create_shop.dart';
import 'package:mcsofttech/ui/module/meridukaan/meri_dukaan.dart';
import 'package:mcsofttech/ui/module/meridukaan/my_shop_order.dart';
import 'package:mcsofttech/utils/common_util.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../../../data/preferences/AppPreferences.dart';
import '../../../../models/home/banner.dart';
import '../../../../theme/my_theme.dart';
import '../../../../utils/ad_helper.dart';
import '../../../../utils/palette.dart';
import '../../../commonwidget/banner_image_carousel.dart';
import '../../../commonwidget/text_style.dart';
import '../../../dialog/loader.dart';
import '../../meridukaan/internal_page/boost_your_product.dart';
import '../../product/product_detail.dart';
import '../../product/product_list.dart';

class MeriDukaanTabTabs extends StatefulWidget {
  const MeriDukaanTabTabs({Key? key}) : super(key: key);

  @override
  State<MeriDukaanTabTabs> createState() => _MeriDukaanTabTabsState();
}

class _MeriDukaanTabTabsState extends State<MeriDukaanTabTabs> {
  final appPreferences = Get.find<AppPreferences>();
  final controller = Get.put(UserDashboardController());
  double screenWidth = 0.0;

  @override
  Widget build(BuildContext context) {
    //Analytics.sendCurrentScreen(AnalyticsConstants.screenUserDashboard);
    controller.callUserDashboard();
    screenWidth = MediaQuery.of(context).size.width;
    return Obx(() => controller.isLoader.value
        ? const Loader()
        : SafeArea(
            child: Container(
            color: MyColors.coloPageBg,
            child: Padding(
                padding: const EdgeInsets.only(left: 12, right: 12),
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    banner,
                    if (!controller.admin.value)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          cardWidget(() {
                            CreateShop.start("create_shop".tr);
                          }, "assets/svg/icon_meri_dukaan_icon.svg",
                              "Meri Dukaan Settings", "", ""),
                          cardWidget(() {
                            MeriDukaan.start("meri_dukaan".tr,
                                controller.userDashboard?.mereDukanLink ?? "");
                          }, "assets/svg/icon_public_view.svg", "Public View",
                              "", "")
                        ],
                      ),
                    gridView(),

                    /*Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        cardWidget(() {
                          TotalVisitor.start(
                              "Total Interested Visitors", "All");
                        },
                            "assets/svg/icon_visitor.svg",
                            "Total Interested Visitors",
                            "${controller.userDashboard?.totalInterested}"),
                        cardWidget(() {
                          TotalVisitor.start(
                              "Total Interested Visitors", "Order");
                        },
                            "assets/svg/icon_order_received.svg",
                            "Total Order Received",
                            controller.userDashboard?.totalOrder.toString() ??
                                "0")
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        cardWidget(() {
                          TotalVisitor.start(
                              "Total Interested Visitors", "Order");
                        },
                            "assets/svg/icon_value_received.svg",
                            "Total Value of Order received",
                            "${controller.userDashboard?.totalValueOfOrderRecieved}"),
                        cardWidget(() {
                          TotalTraining.start(
                            "Total Training",
                          );
                        },
                            "assets/svg/icon_traning_attend.svg",
                            "Total Traning attended",
                            "${controller.userDashboard?.totalTrainingAttended}")
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        cardWidget(
                            () {},
                            "assets/svg/icon_ads_runnig.svg",
                            "Total No. Of Ads Running",
                            "${controller.userDashboard?.totalNumbersOdAdd}"),
                        cardWidget(
                            () {},
                            "assets/svg/icon_ads_expire.svg",
                            "Total No.Of Ads Expire in next 7 Days",
                            "${controller.userDashboard?.addExpiry}")
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        cardWidget(() {
                          TotalVisitor.start(
                              "Total Interested Visitors", "EnquiryUnSeen");
                        },
                            "assets/svg/icon_unseen_enquiry.svg",
                            "Total No. Of unseen enquiries",
                            "${controller.userDashboard?.totalUnseenEnquiry}"),
                        cardWidget(() {
                          TotalVisitor.start(
                              "Total Interested Visitors", "Enquiry");
                        },
                            "assets/svg/icon_enquiry.svg",
                            "Total No.Of enquiries",
                            "${controller.userDashboard?.totalEnquiry}")
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        cardWidget(
                            () {},
                            "assets/svg/icon_msg_box.svg",
                            "Message box",
                            "${controller.userDashboard?.messageCount}"),
                        cardWidget(() {
                          WishListPage.start("Wish List");
                        }, "assets/svg/icon_notification.svg", "Wish List",
                            "${controller.userDashboard?.totalEnquiry}")
                      ],
                    ),*/
                    ourProductText,
                    controller.userDashboard!.userProduct.isNotEmpty
                        ? ourProductWidget()
                        : const SizedBox.shrink(),
                  ],
                ))),
          )));
  }

  Widget get banner {
    List<String> banner = appPreferences.banner;
    List<BannerData> bannerData = <BannerData>[];
    for (String item in banner) {
      bannerData.add(BannerData(bannerId: 1, img: item));
    }
    return BannerCarousel(bannerList: bannerData);
  }

  Widget gridView() {
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
        ),
        itemCount: controller.userDashboard?.cardData.length,
        itemBuilder: (BuildContext context, int index) {
          return cardWidget(() {
            if ((controller.userDashboard?.cardData[index].name ?? "Report") =="Total Order") {
              MyShopOrder.start();
            } else {
              MeriDukaan.start(
                  controller.userDashboard?.cardData[index].name ?? "Report",
                  controller.userDashboard?.cardData[index].reportLink ?? "");
            }
          },
              "assets/svg/icon_msg_box.svg",
              "${controller.userDashboard?.cardData[index].name}",
              Common.numberDigitParseInk(
                  controller.userDashboard?.cardData[index].intvalue ?? 0),
              "${controller.userDashboard?.cardData[index].reportLink}");
        });
    /* return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
        primary: false,
        padding: const EdgeInsets.all(20),
    crossAxisSpacing: 10,
    mainAxisSpacing: 10,
    crossAxisCount: 2,
    children: <Widget>[
      cardWidget(
              () {},
          "assets/svg/icon_msg_box.svg",
          "Message box",
          "${controller.userDashboard?.messageCount}"),
      cardWidget(
              () {},
          "assets/svg/icon_msg_box.svg",
          "Message box",
          "${controller.userDashboard?.messageCount}"),
      cardWidget(
              () {},
          "assets/svg/icon_msg_box.svg",
          "Message box",
          "${controller.userDashboard?.messageCount}"),

    ]);*/
  }

  Widget cardWidget(
    VoidCallback onPress,
    String assetName,
    String cardLabel,
    String count,
    String link,
  ) {
    return InkWell(
      onTap: onPress,
      child: Card(
        child: SizedBox(
          width: screenWidth / 2.3,
          height: screenWidth / 2.3,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: screenWidth / 5,
                      child: Text(count,
                          maxLines: 2,
                          style: TextStyles.headingTexStyle(
                              color: MyColors.kColorBlack,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat')),
                    ),
                    ClipOval(
                      child: Container(
                        color: MyColors.lineColor,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: SizedBox(
                            height: 20,
                            width: 20,
                            child: SvgPicture.asset(assetName),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Positioned(
                    bottom: 20,
                    child: SizedBox(
                      width: screenWidth / 2.3,
                      child: Text(cardLabel,
                          maxLines: 2,
                          textAlign: TextAlign.left,
                          style: TextStyles.headingTexStyle(
                              color: MyColors.kColorGrey,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Montserrat')),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget get ourProductText {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "our_product".tr,
            style: TextStyles.headingTexStyle(
                color: Palette.colorTextBlack,
                fontWeight: FontWeight.bold,
                fontSize: 14,
                fontFamily: 'Montserrat'),
          ),
          InkWell(
            onTap: () {
              ProductList.start(
                "our_product".tr,
                fromPage: "home",
                banner: appPreferences.banner,
              );
            },
            child: SvgPicture.asset(
                width: 28, height: 28, 'assets/svg/icon_left_arrow.svg'),
          )
        ],
      ),
    );
  }

  Widget ourProductWidget() {
    return SizedBox(
      width: screenWidth,
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Wrap(
            spacing: 5,
            children: ourProductList(),
          ),
        ],
      ),
    );
  }

  List<Widget> ourProductList() {
    List<Widget> list = [];
    for (int i = 0;
        i <= controller.userDashboard!.userProduct.length - 1;
        i++) {
      list.add(SizedBox(
        height: 150,
        child: productCard(controller.userDashboard!.userProduct[i], i),
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

  Widget productCard(AllProduct product, int index) {
    return SizedBox(
      width: screenWidth,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: .5, color: MyColors.kColorGrey),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                ProductDetail.start("Product Detail", allProduct: null);
              },
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 10, top: 8, bottom: 10),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: FadeInImage.assetNetwork(
                        width: 100,
                        height: 100,
                        fit: BoxFit.fill,
                        placeholder: "assets/png/placeholder.png",
                        image: "${Constant.baseUrl}${product.img1}")),
              ),
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 47,
                ),
                productName(product.productName),
                Padding(
                  padding: const EdgeInsets.only(left: 0, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: SizedBox(
                        width: screenWidth / 4,
                        child: Row(
                          children: [
                            Text("\u{20B9} ${product.productFee}",
                                style: TextStyles.headingTexStyle(
                                    fontSize: 10,
                                    color: Palette.appColor,
                                    fontFamily:
                                        "assets/font/Oswald-Regular.ttf")),
                            const SizedBox(
                              width: 7,
                            ),
                            Text("\u{20B9} ${product.productDesc}",
                                style: TextStyles.headingTexStyle(
                                    fontSize: 10,
                                    decoration: TextDecoration.lineThrough,
                                    color: Palette.kColorRed,
                                    fontFamily:
                                        "assets/font/Oswald-Regular.ttf")),
                          ],
                        ),
                      )),
                      /*InkWell(
                        onTap: () {
                          EnquiryScreen.start();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            "${"enquiry".tr}:${product.enquiry}",
                            style: TextStyles.labelTextStyle(
                                decoration: TextDecoration.underline,
                                color: MyColors.themeColor,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat',
                                fontSize: 10),
                          ),
                        ),
                      )*/
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Razorpay razorpay = Razorpay();
                        razorpay.clear();
                        BoostYourProduct.start(
                            "Boost your product", product.p_id.toString());
                      },
                      child: Card(
                          elevation: 3,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: MyColors.themeColor),
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Text(
                                "boost_your_product".tr,
                                style: TextStyles.labelTextStyle(
                                    color: MyColors.kColorWhite,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Montserrat',
                                    fontSize: 10),
                              ),
                            ),
                          )),
                    ),
                    InkWell(
                      onTap: () {
                        clickOnAction(Get.context, product.p_id, index);
                        // deleteDialog(product.p_id, index);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 22),
                        child: Text(
                          "Action",
                          style: TextStyles.labelTextStyle(
                              decoration: TextDecoration.underline,
                              color: MyColors.themeColor,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                              fontSize: 10),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }

  Widget productName(String productName) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 10),
      child: Text(
          maxLines: 1,
          productName,
          style: TextStyles.headingTexStyle(
              color: Palette.colorTextBlack,
              fontWeight: FontWeight.normal,
              fontSize: 14,
              fontFamily: 'Montserrat')),
    );
  }

  Widget favouriteRow() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Card(
              color: Palette.appColor,
              margin: const EdgeInsets.all(5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: const Padding(
                padding: EdgeInsets.all(3),
                child: Text(
                  " Featured",
                  style: TextStyle(color: Palette.colorWhite),
                ),
              )),
          const Icon(
            Icons.favorite,
            color: Palette.kColorRed,
          )
        ],
      ),
    );
  }

  Future<void> deleteDialog(int productId, int index) async {
    return showDialog<void>(
      context: Get.context!,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('delete_title'.tr),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text('delete_msg'.tr),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('yes'.tr),
              onPressed: () {
                Navigator.of(context).pop();
                controller.deleteProduct(productId, index, "DELETED");
              },
            ),
            TextButton(
              child: Text('no'.tr),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void clickOnAction(context, int productId, int index) {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(8.0), topLeft: Radius.circular(15.0)),
            side: BorderSide(color: Colors.white)),
        context: context,
        builder: (BuildContext c) {
          return SizedBox(
            height: Get.height / 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  header(Get.width),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    height: 2,
                    color: MyColors.themeColor,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                          deleteDialog(productId, index);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Text(
                              maxLines: 1,
                              "Delete this Product",
                              style: TextStyles.headingTexStyle(
                                  color: MyColors.themeColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  fontFamily: 'Montserrat')),
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: MyColors.themeColor,
                      )
                    ],
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                          controller.deleteProduct(
                              productId, index, "PARTIAL DONE");
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Text(
                              maxLines: 1,
                              "Partial Business Done!",
                              style: TextStyles.headingTexStyle(
                                  color: MyColors.themeColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  fontFamily: 'Montserrat')),
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: MyColors.themeColor,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    height: 1,
                    color: MyColors.themeColor,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                          controller.deleteProduct(
                              productId, index, "BUSS DONE");
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Text(
                              maxLines: 1,
                              "Business done!",
                              style: TextStyles.headingTexStyle(
                                  color: MyColors.themeColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  fontFamily: 'Montserrat')),
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: MyColors.themeColor,
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget header(double screenWidget) {
    return Text("Business Actions",
        textAlign: TextAlign.center,
        style: TextStyles.headingTexStyle(
            color: MyColors.kColorRed,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat'));
  }
}
