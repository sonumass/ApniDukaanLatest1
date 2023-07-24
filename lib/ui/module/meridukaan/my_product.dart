import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcsofttech/ui/base/page.dart';
import 'package:mcsofttech/ui/module/product/product_detail.dart';

import '../../../constants/Constant.dart';
import '../../../controllers/meridhukaan/meri_dukaan_controller.dart';
import '../../../controllers/meridhukaan/my_product_controller.dart';
import '../../../services/navigator.dart';
import '../../../utils/palette.dart';
import '../../commonwidget/text_style.dart';
import '../../dialog/loader.dart';

class MyProductPage extends AppPageWithAppBar {
  static const String routeName = "/myProductPage";

  MyProductPage({Key? key}) : super(key: key);

  static Future<bool?> start<bool>(
    String title, {
    allProduct,
  }) {
    return navigateTo<bool>(routeName, currentPageTitle: title);
  }

  double width = 0.0;
  final controller = Get.put(MyProductController());

  @override
  Widget get body {
    width = screenWidget;
    return Obx(() => controller.isProductLoader.value
        ? const Loader()
        : controller.productSetList!.isNotEmpty
            ? Container(
                height: double.maxFinite,
                color: Colors.green,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Container(
                      height: double.maxFinite,
                      color: Colors.white,
                      child: SingleChildScrollView(
                          child: Column(
                        children: [
                          aboutUsText,
                          const SizedBox(
                            width: 140,
                            child: Divider(
                                color: Colors.red, height: 20.0, thickness: 5),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Wrap(
                              spacing: 5,
                              children: productList(),
                            ),
                          ),
                        ],
                      ))),
                ),
              )
            : Center(
                child: Text(
                  "Data not found!",
                  style: TextStyles.headingTexStyle(color: Colors.red),
                ),
              ));
  }

  Widget get aboutUsText {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 10),
        child: Text(
          "Product",
          style: TextStyles.headingTexStyle(color: Colors.green),
        ),
      ),
    );
  }

  List<Widget> productList() {
    List<Widget> list = [];
    for (int i = 0; i <= controller.productSetList!.length - 1; i++) {
      list.add(SizedBox(
        width: width,
        child: productCard(i),
      ));
    }
    return list;
  }

  Widget productCard(int index) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        color: Palette.kColorLightGreen,
        child: Column(
          children: [
            productName(controller.productSetList![index].productName),
            viewDetail(index),
            productImage(index),
            enquiry,
          ],
        ),
      ),
    );
  }

  Widget viewDetail(int index) {
    return InkWell(
      onTap: () {
        ProductDetail.start(title,
            allProduct: controller.productSetList![index]);
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 10, top: 20),
        child: Align(
          alignment: Alignment.centerRight,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 1, color: Colors.white),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 10, top: 10, right: 10, bottom: 10),
              child: Text(
                ">>View Detail",
                style: TextStyles.headingTexStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget productName(String productName) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
        child: Text(
          productName,
          style: TextStyles.headingTexStyle(color: Colors.black),
        ),
      ),
    );
  }

  Widget productImage(int index) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: FadeInImage.assetNetwork(
            width: width,
            height: 200,
            placeholder: "assets/png/placeholder.png",
            image:
                "${Constant.baseUrl}${controller.productSetList![index].img1}"),
      ),
    );
  }

  Widget get enquiry {
    return Padding(
      padding: const EdgeInsets.only(right: 10, top: 10, bottom: 30),
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1, color: Colors.white),
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
            child: Text(
              "Enquiry",
              style: TextStyles.headingTexStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
