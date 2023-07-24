import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcsofttech/models/add_sell_product_add_model.dart';
import 'package:mcsofttech/ui/base/page.dart';
import 'package:mcsofttech/ui/commonwidget/primary_elevated_button.dart';
import 'package:mcsofttech/ui/dialog/loader.dart';
import 'package:mcsofttech/utils/common_util.dart';
import 'package:mcsofttech/utils/palette.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../../controllers/addandsell/add_and_sell_controller.dart';

import '../../../models/category/CategoryCatData.dart';
import '../../../models/category/SubCategory.dart';
import '../../../models/category/SubCategoryFeatures.dart';
import '../../../services/navigator.dart';
import '../../../theme/my_theme.dart';
import '../../commonwidget/banner_image_carousel.dart';
import '../../commonwidget/text_style.dart';

class RentSell extends AppPageWithAppBar {
  static String routeName = "/rentSell";

  RentSell({Key? key}) : super(key: key);

  static Future<bool?> start<bool>(String title) {
    return navigateTo<bool>(routeName, currentPageTitle: title);
  }

  final controller = Get.put(AddAndSellController());
  final litterKgValue = "".obs;
  final yesNo = true.obs;
  final subCatList = <SubCategory>[].obs;
  String catId = "";
  String subCatId = "";
  String productFee = "0";
  String productOldFee = "0";
  String productName = "";
  final isTermCondition=false.obs;

  // List of items in our dropdown menu

  @override
  Widget get body {
    controller.callCategoryAddProductListApi();
    return Obx(() => controller.isLoader.value
        ? const Loader()
        : SafeArea(
            child: SingleChildScrollView(
            child: Container(
              color: Palette.backgroundBg,
              padding: const EdgeInsets.only(
                  left: 12, right: 12, top: 20, bottom: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (controller.bannerList.isNotEmpty) banner,
                    const SizedBox(
                      height: 10,
                    ),
                    labelText("type_of_product".tr),
                    const SizedBox(
                      height: 10,
                    ),
                    productTypeRow,
                    const SizedBox(
                      height: 10,
                    ),
                    labelText("Category"),
                    const SizedBox(
                      height: 10,
                    ),
                    controller.categoryDataList.isNotEmpty
                        ? dropDownField1()
                        : const SizedBox.shrink(),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      color: Palette.kColorGrey,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    labelText("SubCategory"),
                    const SizedBox(
                      height: 10,
                    ),
                    Obx(() => controller.isSubCatEnable.value
                        ? dropDownField2
                        : const SizedBox.shrink()),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      color: Palette.kColorGrey,
                    ),
                    fieldProductName("product_name".tr, "product_name".tr),
                    const SizedBox(
                      height: 10,
                    ),
                    /*const Divider(
                      color: Palette.kColorGrey,
                    ),
                    fieldProductFee("product_fee".tr, "product_fee".tr),
                    const SizedBox(
                      height: 10,
                    ),*/
                    const Divider(
                      color: Palette.kColorGrey,
                    ),
                    Obx(() => controller.isFeatureEnable.value
                        ? columnItem
                        : const SizedBox.shrink()),
                    const SizedBox(
                      height: 10,
                    ),
                    if(controller.subCategoryFeaturesList.isNotEmpty && controller.subCategoryFeaturesList.where((p0) => p0.featureType=="CHECKBOX").isNotEmpty)termAndCondition,
                    uploadImage,
                    const SizedBox(
                      height: 10,
                    ),
                    /*videoUpload,
                    const SizedBox(
                      height: 10,
                    ),*/
                    imageUpload,
                    const SizedBox(
                      height: 20,
                    ),
                    postLocationText,
                    const SizedBox(
                      height: 20,
                    ),
                    const Divider(
                      color: Palette.kColorGrey,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    uploadPostButton,
                    const SizedBox(
                      height: 20,
                    ),
                  ]),
            ),
          )));
  }

  Widget get banner {
    return BannerCarousel(bannerList: controller.bannerList);
  }

  Widget checkBox(String label, int index) {
    return Row(
      children: [
        CheckBox(
          index: index,
          label: label,
        ),
        labelText(label)
      ],
    );
  }

  Widget get productTypeRow {
    return Row(
      children: [
        typeProductCheckBox("rent".tr, controller.rent.value, "Rent"),
        typeProductCheckBox("sell".tr, controller.sell.value, "Sell")
      ],
    );
  }

  Widget typeProductCheckBox(
      String typeKey, bool typeValue, String checkBoxKey) {
    return Row(
      children: [
        TypeProductCheckBox(
          checkBoxKey: checkBoxKey,
          typeKey: typeKey,
          typeValue: typeValue,
        ),
        labelText(typeKey)
      ],
    );
  }

  Widget labelText(String label) {
    return Text(
      label,
      style: TextStyles.headingTexStyle(
          color: Palette.kColorBlack, fontFamily: "Oswald-Bold.ttf"),
    );
  }

  Widget dropDownField1() {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
          color: Palette.colorWhite,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.grey, //                   <--- border color
            width: 1.0,
          )),
      child: DropdownButton(
        isExpanded: true,
        underline: Container(),
        // Initial Value
        value: controller.categoryCatData.value,

        // Down Arrow Icon
        icon: const Align(
          alignment: Alignment.centerRight,
          child: Icon(Icons.keyboard_arrow_down),
        ),

        // Array list of items
        items: controller.categoryDataList.map((CategoryCatData items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items.categoryName),
          );
        }).toList(),
        // After selecting the desired option,it will
        // change button value to selected value
        onChanged: (CategoryCatData? item) {
          catId = item!.pc_id.toString();
          controller.categoryCatData.value = item;
          controller.isSubCatEnable.value = true;
          controller.isFeatureEnable.value = false;
          controller.subCategoryData.value = item.subCategories!.first;
          controller.subCatList.value = item.subCategories!;
          controller.productFeatureList.clear();
        },
      ),
    );
  }

  Widget get dropDownField2 {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
          color: Palette.colorWhite,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.grey, //                   <--- border color
            width: 1.0,
          )),
      child: DropdownButton(
        isExpanded: true,
        underline: Container(),
        // Initial Value
        value: controller.subCategoryData.value,

        // Down Arrow Icon
        icon: const Align(
          alignment: Alignment.centerRight,
          child: Icon(Icons.keyboard_arrow_down),
        ),

        // Array list of items
        items: subCatListWidget,
        // After selecting the desired option,it will
        // change button value to selected value
        onChanged: (SubCategory? newValue) {
          controller.subCategoryData.value = newValue!;
          controller.isFeatureEnable.value = true;
          subCatId = newValue.psc_id.toString();
          controller.productFeatureList.clear();

          if (controller.subCategoryData.value.subCategoryFeatures != null &&
              controller
                  .subCategoryData.value.subCategoryFeatures!.isNotEmpty) {
            controller.subCategoryFeaturesList.value =
                controller.subCategoryData.value.subCategoryFeatures!;
            controller.isFeatureEnable.value = true;
          } else {
            controller.isFeatureEnable.value = false;
          }
        },
      ),
    );
  }

  List<DropdownMenuItem<SubCategory>> get cubCatListWidget {
    return controller.subCatList.map((SubCategory items) {
      return DropdownMenuItem(
        value: items,
        child: Text(items.subCategoryName),
      );
    }).toList();
  }

  List<DropdownMenuItem<SubCategory>> get subCatListWidget {
    return controller.subCatList.map((SubCategory items) {
      return DropdownMenuItem(
        value: items,
        child: Text(items.subCategoryName),
      );
    }).toList();
  }

  Column get columnItem {
    controller.productFeatureList.clear();
    return Column(children: <Widget>[
      for (int i = 0; i <= controller.subCategoryFeaturesList.length - 1; i++)

        //field("gh", "",TextInputType.text)

        setFeature(controller.subCategoryFeaturesList[i], i)
    ]);
  }

  Widget setFeature(SubCategoryFeatures data, int index) {
    controller.productFeatureList.add(ProductFeature(
        productFeatureKey: data.subCategoryFeatureName,
        productFeatureValue: ""));
    if (data.featureType == "TEXT") {
      return field(data.subCategoryFeatureName, data.subCategoryFeatureName,
          'TEXT', index);
    } else if (data.featureType == "NUMBER") {
      return field(data.subCategoryFeatureName, data.subCategoryFeatureName,
          "Number", index);
    } else if (data.featureType == "Month In Number") {
      return field(data.subCategoryFeatureName, data.subCategoryFeatureName,
          "Number", index);
    } else if (data.featureType.toLowerCase().contains("dropdown")) {
      return (data.productFeatureDetailsList.isNotEmpty)
          ? dropDownWidget(data.subCategoryFeatureName, index,
              data.productFeatureDetailsList, data.featureType)
          : const SizedBox.shrink();
    } else if (data.featureType == "Month,Year") {
      return dateTime(data.subCategoryFeatureName, index);
    }

    return const SizedBox.shrink();
  }

  Widget dropDownWidget(
      String label, int index, List<dynamic> list, String featureType) {
    litterKgValue.value = list[0].toString();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        labelText(label),
        const SizedBox(
          height: 10,
        ),
        DropDownInColumn(
            index: index, label: label, list: list, featureType: featureType),
        const SizedBox(
          height: 10,
        ),
        const Divider(
          color: Palette.kColorGrey,
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget dateTime(String label, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        labelText(label),
        const SizedBox(
          height: 10,
        ),
        Padding(
            padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
            child: SfDateRangePicker(
              onSelectionChanged: (value) {
                _onSelectionChanged(value, index);
              },
              selectionMode: DateRangePickerSelectionMode.single,
            )),
        const SizedBox(
          height: 10,
        ),
        const Divider(
          color: Palette.kColorGrey,
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget yesAnNo(String label, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                checkBox(label, index),
              ],
            )),
        const SizedBox(
          height: 10,
        ),
        const Divider(
          color: Palette.kColorGrey,
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  void _onSelectionChanged(
      DateRangePickerSelectionChangedArgs args, int index) {
    DateTime date = args.value;
    controller.productFeatureList[index].productFeatureValue = date.toString();
  }

  Widget fieldProductName(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        labelText(label),
        const SizedBox(
          height: 10,
        ),
        TextField(
          textAlign: TextAlign.left,
          keyboardType: TextInputType.text,
          onChanged: (value) {
            productName = value;
          },
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                width: .10,
                color: Colors.grey,
              ),
            ),
            filled: true,
            contentPadding: const EdgeInsets.all(16),
            fillColor: Colors.white,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Divider(
          color: Palette.kColorGrey,
        ),
      ],
    );
  }

  Widget fieldProductFee(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        labelText(label),
        const SizedBox(
          height: 10,
        ),
        TextField(
          textAlign: TextAlign.left,
          keyboardType: TextInputType.number,
          onChanged: (value) {
            productFee = value.toString();
          },
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                width: .10,
                color: Colors.grey,
              ),
            ),
            filled: true,
            contentPadding: const EdgeInsets.all(16),
            fillColor: Colors.white,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Divider(
          color: Palette.kColorGrey,
        ),
      ],
    );
  }

  Widget fieldProductOldFee(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        labelText(label),
        const SizedBox(
          height: 10,
        ),
        TextField(
          textAlign: TextAlign.left,
          keyboardType: TextInputType.number,
          onChanged: (value) {
            productOldFee = value.toString();
          },
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                width: .10,
                color: Colors.grey,
              ),
            ),
            filled: true,
            contentPadding: const EdgeInsets.all(16),
            fillColor: Colors.white,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Divider(
          color: Palette.kColorGrey,
        ),
      ],
    );
  }

  Widget field(String label, String hint, String textInputType, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        labelText(label),
        const SizedBox(
          height: 10,
        ),
        TextField(
          textAlign: TextAlign.left,
          keyboardType: textInputType == "Number"
              ? TextInputType.number
              : TextInputType.text,
          onChanged: (value) {
            controller.productFeatureList[index].productFeatureValue =
                "$value";
          },
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                width: .10,
                color: Colors.grey,
              ),
            ),
            filled: true,
            contentPadding: const EdgeInsets.all(16),
            fillColor: Colors.white,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Divider(
          color: Palette.kColorGrey,
        ),
      ],
    );
  }
  Widget get termAndCondition {
    return SizedBox(width: screenWidget,child: Row(
      children: [
        Obx(() => Checkbox(
          checkColor: Colors.white,
          value: isTermCondition.value,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
          onChanged: (bool? value) {
            isTermCondition.value = value!;
          },
        )),
        const Flexible(child:  Text.rich(
            TextSpan(text: 'I Agree that F2DF will pay Rs (seller Price ) including GST charges To me after adjusting the Platform fee/ Delivery Charges (whatever applicable)', children: <InlineSpan>[

            ]))),



      ],
    ),);
  }
  Widget get uploadImage {
    return Row(
      children: [
        const Icon(
          Icons.camera_alt,
          color: Palette.appColor,
        ),
        const SizedBox(
          width: 5,
        ),
        labelText("Please upload at least one photo")
      ],
    );
  }

  Widget get videoUpload {
    return Container(
      height: 150,
      width: screenWidget,
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Palette.kColorGrey)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 90,
            child: Center(
              child: Icon(
                Icons.video_call,
                color: Palette.appColor,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: uploadImageButton1,
          )
        ],
      ),
    );
  }

  Widget get imageUpload {
    return Row(
      children: [
        Container(
          height: 150,
          width: screenWidget / 2.21,
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Palette.kColorGrey)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 90,
                child: Center(
                  child: Obx(() => controller.bytesImage1.value.isNotEmpty
                      ? Image.memory(
                          controller.bytesImage1.value,
                          fit: BoxFit.contain,
                        )
                      : const SizedBox(
                          height: 90,
                          child: Center(
                            child: Icon(
                              Icons.camera_alt,
                              color: Palette.appColor,
                            ),
                          ),
                        )),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: uploadImageButton1,
              )
            ],
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Container(
          height: 150,
          width: screenWidget / 2.21,
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Palette.kColorGrey)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 90,
                child: Center(
                  child: Obx(() => controller.bytesImage2.value.isNotEmpty
                      ? Image.memory(
                          controller.bytesImage2.value,
                          fit: BoxFit.contain,
                        )
                      : const SizedBox(
                          height: 90,
                          child: Center(
                            child: Icon(
                              Icons.camera_alt,
                              color: Palette.appColor,
                            ),
                          ),
                        )),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: uploadImageButton2,
              )
            ],
          ),
        )
      ],
    );
  }

  Widget get uploadImageButton1 {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: SizedBox(
        width: screenWidget,
        height: 45,
        child: PrimaryElevatedBtn("upload_image".tr, () {
          showModalBottomSheet(
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8.0), topLeft: Radius.circular(15.0)),
                  side: BorderSide(color: Colors.white)),
              context: Get.context!,
              builder: (BuildContext c) {
                return Padding(padding: MediaQuery.of(Get.context!).viewInsets,child: Container(child: Wrap(
                  children: <Widget>[const SizedBox(
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
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                      Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: SizedBox(
                        width: screenWidget,
                        height: 45,
                        child: PrimaryElevatedBtn(
                            "Choose from gallery",
                                () async {
                              controller.getImage1("1");
                              Get.back();
                            },
                            borderRadius: 10.0),
                      ),
                    ),
                          const SizedBox(
                            height: 10,
                          ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: SizedBox(
                          width: screenWidget,
                          height: 45,
                          child: PrimaryElevatedBtn(
                              "Use Camera",
                                  () async {
                                controller.getFromCamera("1");
                                Get.back();
                              },
                              borderRadius: 10.0),
                        ),
                      ),
                          const SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                  ],)));

              });
        }, borderRadius: 40.0),
      ),
    );
  }

  Widget get imageUpload2 {
    return Row(
      children: [
        Container(
          height: 150,
          width: screenWidget / 2.21,
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Palette.kColorGrey)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 90,
                child: Center(
                  child: Icon(
                    Icons.camera_alt,
                    color: Palette.appColor,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: uploadImageButton2,
              )
            ],
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Container(
          height: 150,
          width: screenWidget / 2.21,
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Palette.kColorGrey)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 90,
                child: Center(
                  child: Icon(
                    Icons.camera_alt,
                    color: Palette.appColor,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: uploadImageButton1,
              )
            ],
          ),
        )
      ],
    );
  }

  Widget get uploadImageButton2 {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: SizedBox(
        width: screenWidget,
        height: 45,
        child: PrimaryElevatedBtn("upload_image".tr, () {
          showModalBottomSheet(
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8.0), topLeft: Radius.circular(15.0)),
                  side: BorderSide(color: Colors.white)),
              context: Get.context!,
              builder: (BuildContext c) {
                return Padding(padding: MediaQuery.of(Get.context!).viewInsets,child: Container(child: Wrap(
                  children: <Widget>[const SizedBox(
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
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: SizedBox(
                              width: screenWidget,
                              height: 45,
                              child: PrimaryElevatedBtn(
                                  "Choose from gallery",
                                      () async {
                                    controller.getImage2();
                                    Get.back();
                                  },
                                  borderRadius: 10.0),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: SizedBox(
                              width: screenWidget,
                              height: 45,
                              child: PrimaryElevatedBtn(
                                  "Use Camera",
                                      () async {
                                    controller.getFromCamera("2");
                                    Get.back();
                                  },
                                  borderRadius: 10.0),
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                  ],)));
              });
        }, borderRadius: 40.0),
      ),
    );
  }

  Widget get postLocationText {
    return labelText("");
  }

  Widget get uploadPostButton {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: SizedBox(
        width: screenWidget,
        height: 45,
        child: PrimaryElevatedBtn("upload_you_post".tr, () {
          if(controller.subCategoryFeaturesList.isNotEmpty && controller.subCategoryFeaturesList.where((p0) => p0.featureType.toLowerCase().contains("checkbox")).isNotEmpty && !isTermCondition.value){
          Common.showToast("Please accept term & condition");
          return;
          }
          if(controller.productImage1.value.isEmpty){
            Common.showToast("Please choose at least one image");
            return;
          }

          controller.uploadPostClick(
              catId, subCatId, productName, productFee, productOldFee);
        }, borderRadius: 20.0),
      ),
    );
  }
}

class CheckBox extends StatefulWidget {
  final String label;
  final int index;

  const CheckBox({Key? key, required this.label, required this.index})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CheckBoxState();
  }
}

class _CheckBoxState extends State<CheckBox> {
  bool _myBoolean = false;
  final controller = Get.find<AddAndSellController>();

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: _myBoolean,
      onChanged: (value) {
        setState(() {
          controller.productFeatureList[widget.index].productFeatureKey =
              widget.label;
          controller.productFeatureList[widget.index].productFeatureValue =
              "${value!}";
          _myBoolean = value; // rebuilds with new value
        });
      },
    );
  }
}

class TypeProductCheckBox extends StatefulWidget {
  final String checkBoxKey;
  final String typeKey;
  final bool typeValue;

  const TypeProductCheckBox(
      {Key? key,
      required this.typeKey,
      required this.typeValue,
      required this.checkBoxKey})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TypeProductCheckBoxState();
  }
}

class _TypeProductCheckBoxState extends State<TypeProductCheckBox> {
  final _myBoolean = false.obs;
  final controller = Get.find<AddAndSellController>();

  @override
  Widget build(BuildContext context) {
    _myBoolean.value = widget.typeValue;
    return Checkbox(
      value: _myBoolean.value,
      onChanged: (value) {
        String typeValue = "Sell";
        setState(() {
          if (widget.checkBoxKey == "Rent" && value!) {
            controller.rent.value = value;
            controller.sell.value = false;
            typeValue = "Rent";
            controller.callCategoryAddProductListApi(
                type: typeValue.toString());
          }
          if (widget.checkBoxKey == "Sell" && value!) {
            controller.sell.value = value;
            controller.rent.value = false;
            typeValue = "Sell";
            controller.callCategoryAddProductListApi(
                type: typeValue.toString());
          }

          _myBoolean.value = value!; // rebuilds with new value
        });
      },
    );
  }
}

class DropDownInColumn extends StatefulWidget {
  final String label;
  final String featureType;
  final int index;
  final List<dynamic> list;

  const DropDownInColumn(
      {Key? key,
      required this.label,
      required this.index,
      required this.list,
      required this.featureType})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DropDownInColumnState();
  }
}

class _DropDownInColumnState extends State<DropDownInColumn> {
  String labelValue = "";
  List<dynamic> listData = [];

  final controller = Get.find<AddAndSellController>();

  @override
  void initState() {
    setState(() {
      labelValue = widget.list[0];
      listData = widget.list;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: width,
            child: Container(
                padding: const EdgeInsets.only(left: 10, right: 8),
                decoration: BoxDecoration(
                    color: Palette.colorWhite,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.grey, //                   <--- border color
                      width: 1.0,
                    )),
                child: DropdownButton(
                  isExpanded: true,
                  underline: Container(),
                  // Initial Value
                  value: labelValue,

                  // Down Arrow Icon
                  icon: const Align(
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.keyboard_arrow_down),
                  ),

                  // Array list of items
                  items: litterAndKgWidget,
                  // After selecting the desired option,it will
                  // change button value to selected value
                  onChanged: (String? newValue) {
                    setState(() {
                      newValue!;
                      labelValue = newValue;
                      controller.productFeatureList[widget.index]
                          .productFeatureKey = widget.label;
                      controller.productFeatureList[widget.index]
                              .productFeatureValue =
                          newValue; // rebuilds with new value
                    });
                  },
                )),
          ),
          if (widget.featureType.toLowerCase().contains("text") ||
              widget.featureType.toLowerCase().contains("number"))
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: fieldValue(),
            )
        ],
      ),
    );
  }

  Widget fieldValue() {
    final checkFeatureType = widget.featureType.split(",");
    return TextField(
      textAlign: TextAlign.left,
      keyboardType: checkFeatureType[0] == "NUMBER"
          ? TextInputType.number
          : TextInputType.text,
      onChanged: (value) {
        controller.productFeatureList[widget.index].productFeatureKey =
            widget.label;
        controller.productFeatureList[widget.index].productFeatureValue =
            "$value - $labelValue";
      },
      decoration: InputDecoration(
        hintText: "",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            width: .10,
            color: Colors.grey,
          ),
        ),
        filled: true,
        contentPadding: const EdgeInsets.all(16),
        fillColor: Colors.white,
      ),
    );
  }

  List<DropdownMenuItem<String>> get litterAndKgWidget {
    List<String> list = <String>[];
    for (String item in listData) {
      list.add(item);
    }
    return list.map((String items) {
      return DropdownMenuItem(
        value: items,
        child: Text(items),
      );
    }).toList();
  }

}
