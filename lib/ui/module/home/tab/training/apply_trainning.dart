import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcsofttech/models/training/trainingDropdown/TrainingType.dart';
import 'package:mcsofttech/models/training/trainingDropdown/Venue.dart';
import 'package:mcsofttech/theme/my_theme.dart';
import 'package:mcsofttech/ui/base/base_satateless_widget.dart';
import 'package:mcsofttech/ui/dialog/loader.dart';
import 'package:mcsofttech/utils/palette.dart';

import '../../../../../controllers/training/training_controller.dart';
import '../../../../../utils/analytics.dart';
import '../../../../commonwidget/primary_elevated_button.dart';
import '../../../../commonwidget/text_see_more.dart';
import '../../../../commonwidget/text_style.dart';

class ApplyTraining extends BaseStateLessWidget {
  final String dropdownvalue = '';
  final controller = Get.put(TrainingController());

  // List of items in our dropdown menu
  final items = [
    'Offline',
    'Online',
  ];
  final clickApplyAtCard = false.obs;

  ApplyTraining({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Analytics.sendCurrentScreen("apply_training");
    controller.applyTrainingDropDownApiApi();
    return Obx(() => controller.isLoader.value
        ? const Loader()
        : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  aboutHeaderText,
                  const SizedBox(
                    height: 10,
                  ),
                  aboutText,
                  const SizedBox(
                    height: 20,
                  ),
                  userName,
                  const SizedBox(
                    height: 20,
                  ),
                  userEmail,
                  const SizedBox(
                    height: 20,
                  ),
                  userMobile,
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  userDescription,
                  const SizedBox(
                    height: 20,
                  ),
                  controller.trainingTypeList.isNotEmpty
                      ? trainingDropDownField1
                      : const SizedBox.shrink(),
                  const SizedBox(
                    height: 20,
                  ),
                  trainingModeDropDownField,
                  const SizedBox(
                    height: 20,
                  ),
                  controller.trainingVenue.isNotEmpty
                      ? trainingVenueDropDownField
                      : const SizedBox.shrink(),
                  const SizedBox(
                    height: 20,
                  ),
                  trainingDate,
                  const SizedBox(
                    height: 20,
                  ),
                  applyButtonTraining,
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ));
  }

  Widget get upcomingTrainingUi {
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 5),
        child: Wrap(spacing: 5, children: upcomingTraining()));
  }

  List<Widget> upcomingTraining() {
    List<Widget> list = [];
    for (int i = 0; i <= 4; i++) {
      list.add(SizedBox(
        width: screenWidget,
        child: upcomingTrainingCard(),
      ));
    }
    return list;
  }

  Widget upcomingTrainingCard() {
    final dateFieldController = TextEditingController();
    dateFieldController.text = "June 24, 2021";
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: FadeInImage.assetNetwork(
                  width: screenWidget,
                  placeholder: "assets/png/placeholder.png",
                  image: "https://gyanhouse.com/new-f2df/img/blog/1.jpg"),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Text("Common Engine oil problem and solution",
                style: TextStyles.headingTexStyle(
                  color: MyColors.kColorBlack,
                )),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: screenWidget / 2.5,
                  child: TextField(
                    controller: dateFieldController,
                    enabled: false,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.date_range,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: screenWidget / 2.5,
                  child: applyButton(),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget applyButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: SizedBox(
        width: screenWidget,
        height: 45,
        child: PrimaryElevatedBtn(
            "apply_now".tr, () => {clickApplyAtCard.value = true},
            borderRadius: 40.0),
      ),
    );
  }

  Widget get aboutHeaderText {
    return Text(
      "about_training".tr,
      style: TextStyles.headingTexStyle(
          color: Palette.kColorBlack,
          fontFamily: "assets/font/Oswald-Regular.ttf"),
    );
  }

  Widget get aboutText {
    return ExpandableText(
      "about_training_text".tr,
      trimLines: 2,
    );
  }

  Widget get userName {
    return TextField(
      controller: controller.userNameController,
      textAlign: TextAlign.left,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.account_box_rounded),
        hintText: 'enter_user_name'.tr,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            width: .10,
            color: Palette.appColor,
          ),
        ),
        filled: true,
        contentPadding: const EdgeInsets.all(16),
        fillColor: Colors.white,
      ),
    );
  }

  Widget get userEmail {
    return TextField(
      controller: controller.userEmailController,
      textAlign: TextAlign.left,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.email),
        hintText: 'enter_your_email'.tr,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            width: .10,
            color: Palette.appColor,
          ),
        ),
        filled: true,
        contentPadding: const EdgeInsets.all(16),
        fillColor: Colors.white,
      ),
    );
  }

  Widget get userMobile {
    return TextField(
      controller: controller.userMobileController,
      textAlign: TextAlign.left,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.phone_android_sharp),
        hintText: 'enter_user_mobile'.tr,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            width: .10,
            color: Palette.appColor,
          ),
        ),
        filled: true,
        contentPadding: const EdgeInsets.all(16),
        fillColor: Colors.white,
      ),
    );
  }

  Widget get userDescription {
    return TextField(
      controller: controller.userDescriptionController,
      textAlign: TextAlign.left,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.account_box_rounded),
        hintText: 'enter_user_description'.tr,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            width: .10,
            color: Palette.appColor,
          ),
        ),
        filled: true,
        contentPadding: const EdgeInsets.all(16),
        fillColor: Colors.white,
      ),
    );
  }

  Widget selectTrainingHeaderText(String label) {
    return Text(
      label,
      style: TextStyles.headingTexStyle(
          color: Palette.kColorBlack,
          fontFamily: "assets/font/Oswald-Regular.ttf"),
    );
  }

  Widget get trainingDropDownField1 {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        selectTrainingHeaderText("Select Training"),
        const SizedBox(
          height: 10,
        ),
        Container(
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
            value: controller.trainingTypeSelected,

            // Down Arrow Icon
            icon: const Align(
              alignment: Alignment.centerRight,
              child: Icon(Icons.keyboard_arrow_down),
            ),

            // Array list of items
            items: controller.trainingTypeList.map((TrainingType items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items.name),
              );
            }).toList(),
            // After selecting the desired option,it will
            // change button value to selected value
            onChanged: (TrainingType? newValue) {
              controller.trainingTypeSelected = newValue!;
              controller.trainingType.value = newValue.id.toString();
              controller.trainingVenue.value = newValue.venue;
              if (controller.trainingVenue.isNotEmpty)
                controller.venueSelected = controller.trainingVenue.first;
              // dropdownvalue = newValue!;
            },
          ),
        )
      ],
    );
  }

  Widget get trainingModeDropDownField {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        selectTrainingHeaderText("Select training mode"),
        const SizedBox(
          height: 10,
        ),
        Container(
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
            value: items.first,

            // Down Arrow Icon
            icon: const Align(
              alignment: Alignment.centerRight,
              child: Icon(Icons.keyboard_arrow_down),
            ),

            // Array list of items
            items: items.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items),
              );
            }).toList(),
            // After selecting the desired option,it will
            // change button value to selected value
            onChanged: (String? newValue) {
              controller.trainingMode.value = newValue!;
              // dropdownvalue = newValue!;
            },
          ),
        )
      ],
    );
  }

  Widget get trainingVenueDropDownField {
    return Obx(() => controller.trainingVenue.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              selectTrainingHeaderText("Select training venue"),
              const SizedBox(
                height: 10,
              ),
              Container(
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
                  value: controller.venueSelected,
                  icon: const Align(
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.keyboard_arrow_down),
                  ),

                  // Array list of items
                  items: controller.trainingVenue.map((Venue items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items.name),
                    );
                  }).toList(),
                  // After selecting the desired option,it will
                  // change button value to selected value
                  onChanged: (Venue? newValue) {
                    // dropdownvalue = newValue!;
                    controller.venueSelected = newValue!;
                    controller.trainingDateController.text =
                        newValue.trainingDate;
                    controller.trainingVenueValue.value =
                        newValue.id.toString();
                  },
                ),
              )
            ],
          )
        : const SizedBox.shrink());
  }

  Widget get trainingDate {
    return TextField(
      controller: controller.trainingDateController,
      textAlign: TextAlign.left,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.account_box_rounded),
        hintText: 'enter_training_date'.tr,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            width: .10,
            color: Palette.appColor,
          ),
        ),
        filled: true,
        contentPadding: const EdgeInsets.all(16),
        fillColor: Colors.white,
      ),
    );
  }

  Widget get applyButtonTraining {
    return SizedBox(
      width: screenWidget,
      height: 45,
      child: PrimaryElevatedBtn("apply_now".tr, () {
        controller.callApplyTrainingApi(0);
      }, borderRadius: 20.0),
    );
  }
}
