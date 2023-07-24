import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcsofttech/models/training/UpcomingEvents.dart';
import 'package:mcsofttech/theme/my_theme.dart';
import 'package:mcsofttech/ui/base/base_satateless_widget.dart';
import 'package:mcsofttech/utils/palette.dart';

import '../../../../../constants/Constant.dart';
import '../../../../../controllers/training/training_controller.dart';
import '../../../../../models/training/trainingDropdown/TrainingType.dart';
import '../../../../../models/training/trainingDropdown/Venue.dart';
import '../../../../commonwidget/primary_elevated_button.dart';
import '../../../../commonwidget/text_see_more.dart';
import '../../../../commonwidget/text_style.dart';
import '../../../../dialog/loader.dart';
import '../../../profile/widget/text_field_widget.dart';

class UpcomingTrainingPage extends BaseStateLessWidget {
  final String dropdownvalue = '';
  final controller = Get.put(TrainingController());

  // List of items in our dropdown menu
  final items = [
    'Offline',
    'Online',
  ];
  RxBool clickApplyAtCard = false.obs;
  RxInt trainingId = 0.obs;

  final bool clickApplyAt;

  UpcomingTrainingPage({Key? key, required this.clickApplyAt})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    clickApplyAtCard.value = clickApplyAt;
    controller.trainingEventsList();
    return Obx(() => clickApplyAtCard.isTrue
        ? Obx(() => SingleChildScrollView(
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
                    applyButtonTraining(),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ))
        : Obx(() => controller.isEventLoader.value?const Loader():SingleChildScrollView(
      child: upcomingTrainingUi,
    )));
  }

  Widget get upcomingTrainingUi {
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 5),
        child: Wrap(spacing: 5, children: upcomingTraining()));
  }

  List<Widget> upcomingTraining() {
    List<Widget> list = [];
    for (int i = 0; i <= controller.upcomingEventList.length-1; i++) {
      list.add(SizedBox(
        width: screenWidget,
        child: upcomingTrainingCard(controller.upcomingEventList[i]),
      ));
    }
    return list;
  }

  Widget upcomingTrainingCard(UpcomingEvents upcomingEvents) {
    final dateFieldController = TextEditingController();
    dateFieldController.text = upcomingEvents.date;
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
                  image: "${Constant.baseUrl}/${upcomingEvents.images[0].filePath}"),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Text(upcomingEvents.heading,
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
                  child: applyButton(upcomingEvents.id),
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
              controller.trainingVenue.value = newValue.venue;
              if (controller.trainingVenue.isNotEmpty) {
                controller.venueSelected = controller.trainingVenue.first;
              }
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
                  },
                ),
              )
            ],
          )
        : const SizedBox.shrink());
  }

  Widget selectTrainingHeaderText(String label) {
    return Text(
      label,
      style: TextStyles.headingTexStyle(
          color: Palette.kColorBlack,
          fontFamily: "assets/font/Oswald-Regular.ttf"),
    );
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

  Widget applyButton(int id) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: SizedBox(
        width: screenWidget,
        height: 45,
        child: PrimaryElevatedBtn(
            "apply_now".tr, () {clickApplyAtCard.value = true;trainingId.value=id;},
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

  Widget get messageText {
    final addressController = TextEditingController();
    return TextFieldWidget(
      controller: addressController,
      label: 'Ask Question',
      text:
          "When it comes to personalizing your online store, nothing is more effective than an About Us page. This is a quick summary of your company's history and purpose, and should provide a clear overview of the company's brand story.",
      maxLines: 5,
      onChanged: (about) {},
    );
  }

  Widget  applyButtonTraining() {
    debugPrint("sonu1::$trainingId");
    return SizedBox(
      width: screenWidget,
      height: 45,
      child: PrimaryElevatedBtn("apply_now".tr, (){clickApplyAtCard.value=false;controller.callApplyTrainingApi(trainingId.value);}, borderRadius: 20.0),
    );
  }
}
