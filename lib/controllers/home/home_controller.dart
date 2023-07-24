import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcsofttech/constants/Constant.dart';
import 'package:mcsofttech/controllers/base_getx_controller.dart';
import 'package:mcsofttech/data/network/apiservices/home_api_services.dart';
import 'package:mcsofttech/models/home/AllProduct.dart';
import '../../data/preferences/AppPreferences.dart';
import '../../deeplink/deep_link.dart';
import '../../models/home/CategoryHomeData.dart';
import '../../models/home/banner.dart';
import '../../theme/my_theme.dart';
import '../../ui/commonwidget/outline_elevated_button.dart';
import '../../ui/commonwidget/primary_elevated_button.dart';
import '../../ui/commonwidget/text_style.dart';
import '../../utils/common_util.dart';

class HomeController extends BaseController {
  final appPreferences = Get.find<AppPreferences>();
  final apiServices = Get.put(HomeApiServices());
  late List<BannerData> bannerList = <BannerData>[];
  late List<CategoryHomeData> categoryList = <CategoryHomeData>[];
  late List<AllProduct> recommdedProductList = <AllProduct>[];
  late List<AllProduct> bestSellingProductList = <AllProduct>[];
  late List<AllProduct> allProductList = <AllProduct>[];
  final pageNo = 0.obs;
  final isLoader = false.obs;

  @override
  void onInit() {
    super.onInit();
    callHomeApi();
  }

  void callHomeApi({page}) async {
    isLoader.value = true;
    final response = await apiServices.homeListApi(size: 10, page: page);
    isLoader.value = false;
    if (response == null) {
      return;
    }
    if (response.bannerList!.isNotEmpty) {
      bannerList = response.bannerList!;
      List<String> list = <String>[];
      for (BannerData item in bannerList) {
        list.add(item.img);
      }
      appPreferences.saveBanner(list);
    }
    if (response.categoryList!.isNotEmpty) {
      categoryList = response.categoryList!;
    }
    if (response.recommdedProducts!.isNotEmpty) {
      recommdedProductList = response.recommdedProducts!;
    }
    if (response.bestSellingProducts!.isNotEmpty) {
      bestSellingProductList = response.bestSellingProducts!;
    }
    if (response.allProducts!.isNotEmpty) {
      allProductList = response.allProducts!;
    }
    pageNo.value = 1;
    if(!appPreferences.isShow){
      Future.delayed(const Duration(milliseconds: 500), () {
        showOfferSheet(Get.context!, Get.height, Get.width);
      });

    }

  }

  void callProductListFromHomeApi({page, paramValue}) async {
    showLoader();
    final response = await apiServices.productListFromHomeApi(
        size: 10, page: pageNo.value, type: paramValue);
    hideLoader();
    if (response == null) Common.showToast("Server Error!");
    if (response != null &&
        response.status == 200 &&
        response.products!.isNotEmpty) {
      pageNo.value += 1;
      if (response.products != null && response.products!.isNotEmpty) {
        allProductList.addAll(response.products!);
        response.products?.forEach((element) {DynamicLinksApi.createReferralLink(element.p_id.toString());});
      }
    }
  }

  Widget card(String name, String img, String quantity) {
    return SizedBox(
      width: Get.width,
      child: InkWell(
        onTap: () {
          Get.back();
         // Navigator.pop(Get.context!);
          Future.delayed(const Duration(milliseconds: 500), () {
            showPriceSheet(Get.context!, Get.height, Get.width,name);
          });

        },
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
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 8, bottom: 10),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: FadeInImage.assetNetwork(
                          width: 78,
                          height: 78,
                          fit: BoxFit.fill,
                          placeholder: "assets/png/placeholder.png",
                          image: img)),
                ),
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      header(name),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, right: 20),
                    child: Row(
                      children: [
                        Text("Qty:$quantity Quintal",
                            style: TextStyles.headingTexStyle(
                              color: MyColors.colorTextGrey,
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                              fontFamily: 'Montserrat',
                            )),
                        const SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget header(String header) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 10),
      child: Text(
          maxLines: 1,
          header,
          style: TextStyles.headingTexStyle(
              color: MyColors.themeColor,
              fontWeight: FontWeight.bold,
              fontSize: 14,
              fontFamily: 'Montserrat')),
    );
  }

  void showOfferSheet(context, double screenHeight, double screenWidget) {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(8.0), topLeft: Radius.circular(15.0)),
            side: BorderSide(color: Colors.white)),
        context: context,
        builder: (BuildContext c) {
          return SizedBox(
            height: screenHeight/1.5,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 10,
                  ),

                  enquiaryOfferForm(screenWidget),
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
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      children: [
                        card("BEE KEEPING",
                            "${Constant.baseUrl}/img/BEE_KEEPING.png", "1000"),
                        card("CASH CROPS",
                            "${Constant.baseUrl}/img/CASH_CROPS.png", "5000"),
                        card(
                            "DAIRY PRODUCTS",
                            "${Constant.baseUrl}/img/dairy_Products.png",
                            "250"),
                        card("FOOD GRAINS & EDIBLE OILS",
                            "${Constant.baseUrl}/img/FOOD_GRAINS.png", "3000")
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void showPriceSheet(context, double screenHeight, double screenWidget,String productNameText) {
    final productNameController = TextEditingController();
    final nameController = TextEditingController();
    final mobileController = TextEditingController();
    final locationController = TextEditingController();
    final quantityController = TextEditingController();
    final offerPriceController = TextEditingController();
    final expectedDateController = TextEditingController();
    productNameController.text=productNameText;
    showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(8.0), topLeft: Radius.circular(15.0)),
            side: BorderSide(color: Colors.white)),
        context: context,
        builder: (BuildContext c) {
         return Padding(padding: MediaQuery.of(context).viewInsets,child: Container(child: Wrap(
          children: <Widget>[const SizedBox(
            height: 10,
          ),
            Padding(padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),child: enquiaryForm(screenWidget),),
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
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  productName(productNameController, "Product Name"),
                  productName(nameController, "Name"),
                  productName(mobileController, "Phone Number"),
                  productName(locationController, "Location"),
                  productName(quantityController, "Quantity"),
                  productName(offerPriceController, "Offer Price"),
                  productName(expectedDateController,
                      "Expected Date DD-MM-YYYY"),
                ],
              ),
            ), Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20,top: 10,left: 10,right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: PrimaryElevatedBtn("SUBMIT", () {
                          addRequirementApi(
                              "App",
                              productNameController.text.toString(),
                              nameController.text.toString(),
                              mobileController.text.toString(),
                              locationController.text.toString(),
                              quantityController.text.toString(),
                              offerPriceController.text.toString(),
                              expectedDateController.text.toString());
                          Get.back();
                          //Navigator.of(Get.context!).pop();
                          appPreferences.savePopUp(true);
                        })),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: OutLineElevatedBtn("CANCEL", () {
                          Get.back();
                          //Navigator.of(Get.context!).pop();
                        })),
                  ],
                ),
              ),
            ),],)));
       
        });
  }

  Widget productName(TextEditingController controller, label) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: label,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
              width: 1, color: MyColors.colorTextGrey), //<-- SEE HERE
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: MyColors.themeColor), //<-- SEE HERE
        ),
      ),
    );
  }
  Widget enquiaryOfferForm(double screenWidget) {
    return Text("urgent_requirement".tr,
        textAlign: TextAlign.center,
        style: TextStyles.headingTexStyle(
            color: MyColors.kColorRed,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat'));
  }
  Widget enquiaryForm(double screenWidget) {
    return Center(child: Text("ENQUIRY FORM",
        textAlign: TextAlign.center,
        style: TextStyles.headingTexStyle(
            color: MyColors.themeColor,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat')),);
  }

  void addRequirementApi(
      String show,
      String productName,
      String name,
      String phoneNumber,
      String location,
      String offerPrice,
      String quantity,
      String expectedDate) async {
    showLoader();
    final response = await apiServices.addRequirementApi(show, productName,
        name, phoneNumber, location, offerPrice, quantity, expectedDate);
    hideLoader();
    if (response == null) Common.showToast("Server Error!");
    if (response != null && response.status == 200) {
      // Common.showToast(response.message);
      showSuccessConnectDialog();
    } else {
      Common.showToast(response?.message ?? "");
    }
  }

  void showSuccessConnectDialog() {
    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      //this right here
      child: SizedBox(
        height: 300.0,
        width: 300.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 0, right: 10),
              child: Text(
                  maxLines: 1,
                  "Successfully!",
                  style: TextStyles.headingTexStyle(
                      color: MyColors.themeColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      fontFamily: 'Montserrat')),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 0, right: 10),
              child: Text(
                  maxLines: 4,
                  "Information has been submit successfully,one of our customer care executive will connect with you soon.",
                  textAlign: TextAlign.center,
                  style: TextStyles.headingTexStyle(
                      color: MyColors.colorTextGrey,
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      fontFamily: 'Montserrat')),
            ),
            const Padding(padding: EdgeInsets.only(top: 50.0)),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: SizedBox(
                width: 200,
                height: 45,
                child: PrimaryElevatedBtn("Back to home",
                    () async => {Get.back()},
                    borderRadius: 10.0),
              ),
            )
          ],
        ),
      ),
    );
    showDialog(
        context: Get.context!, builder: (BuildContext context) => errorDialog);
  }
}
