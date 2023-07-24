import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcsofttech/constants/Constant.dart';
import 'package:mcsofttech/controllers/meridhukaan/meri_dukaan_controller.dart';
import 'package:mcsofttech/ui/dialog/loader.dart';
import '../../../../utils/palette.dart';
import '../../../commonwidget/text_style.dart';

class ProductStatefulWidget extends StatefulWidget {
  const ProductStatefulWidget({Key? key}) : super(key: key);

  @override
  State<ProductStatefulWidget> createState() => _ProductStatefulWidgetState();
}

class _ProductStatefulWidgetState extends State<ProductStatefulWidget> {
  double width = 0.0;
  final controller = Get.find<MeriDukaanController>();

  @override
  void initState() {
    super.initState();
    controller.callMeriDukaanProductApi();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
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
            viewDetail,
            productImage(index),
            enquiry,
          ],
        ),
      ),
    );
  }

  Widget get viewDetail {
    return Padding(
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
            padding:
                const EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
            child: Text(
              ">>View Detail",
              style: TextStyles.headingTexStyle(color: Colors.white),
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
