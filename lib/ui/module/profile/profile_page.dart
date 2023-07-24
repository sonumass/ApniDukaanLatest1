import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcsofttech/constants/Constant.dart';
import 'package:mcsofttech/controllers/profile_controller.dart';
import 'package:mcsofttech/ui/commonwidget/text_style.dart';
import 'package:mcsofttech/ui/module/profile/widget/profile_widget.dart';
import 'package:mcsofttech/utils/palette.dart';
import '../../../data/preferences/AppPreferences.dart';
import '../../../services/navigator.dart';
import '../../base/page.dart';
import '../../commonwidget/custom_drop_down3.dart';
import '../../commonwidget/primary_elevated_button.dart';

class EditProfile extends AppPageWithAppBar {
  static String routeName = "/editProfile";

  EditProfile({Key? key}) : super(key: key);

  static Future<bool?> start<bool>({fromTab}) {
    return navigateTo<bool>(routeName,
        currentPageTitle: "Profile", arguments: {"fromTab": fromTab});
  }

  final controller = Get.put(ProfileController());
  final appPreferences = Get.find<AppPreferences>();
  late final String mobile;
  late final String name;
  late final String email;
  late final String line1;
  late final String line2;
  late final String district;
  late final String pincode;
  late final String state;

  @override
  Widget get body {
    return Obx(() => ListView(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          physics: const BouncingScrollPhysics(),
          children: [
            ProfileWidget(
              imagePath: controller.imageUrl.value.isEmpty
                  ? "https://cdn-icons-png.flaticon.com/512/149/149071.png"
                  : "${Constant.baseUrl}${controller.imageUrl.value}",
              isEdit: true,
              onClicked: () async {
                controller.getImage();
              },
            ),
            const SizedBox(height: 24),
            userType,
            const SizedBox(height: 24),
            textField("Enter Name", controller.userNameController,
                TextInputType.text),
            const SizedBox(height: 24),
            textField("Enter Mobile", controller.mobileController,
                TextInputType.number),
            const SizedBox(height: 24),
            textField("Enter Email", controller.emailController,
                TextInputType.emailAddress),
            const SizedBox(height: 24),
            textField("Enter WhatsApp number", controller.addressController,
                TextInputType.number),

            const SizedBox(height: 24),
            Text(
              "Edit Address",
              style: TextStyles.headingTexStyle(
                  color: Palette.kColorBlack,
                  fontFamily: "assets/font/Oswald-Bold.ttf"),
            ),
            const SizedBox(height: 10),
            textField("Enter Address Line1", controller.addressLine1Controller,
                TextInputType.text),
            const SizedBox(height: 24),
            textField("Enter Address Line2", controller.addressLine2Controller,
                TextInputType.text),
            const SizedBox(height: 24),
            textField("Enter Address PinCode",
                controller.addressLinePinCodeController, TextInputType.number),
            const SizedBox(height: 24),
            textField("Enter Address city",
                controller.addressDistrictCodeController, TextInputType.text),
            const SizedBox(height: 24),
            textField("Enter state", controller.addressStateCodeController,
                TextInputType.text),
            const SizedBox(height: 24),
            updateButton,
            const SizedBox(height: 24),
          ],
        ));
  }
Widget get userType{
    return SizedBox(
        width: screenWidget,
        height: 70,
        child: Card(
          elevation: 10,
          shape:  const RoundedRectangleBorder(
            side: BorderSide(
                width: .25, color: Palette.kColorBlack),
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          child: Obx(
                () => CustomDropdown3(
                  borderColor: Colors.white,
              icon: const Icon(Icons.arrow_drop_down),
              dropdownDecoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(
                    10.0) //                 <--- border radius here
                ),
              ),
              iconSize: 30,
              hint: 'Select Meeting Type',
              dropdownItems: controller.userTypeList,
              value: controller.selectTypeValue.value,
              onChanged: (value) {
                controller.selectTypeValue.value = value!;
              },
            ),
          ),
        ));
}
  Widget get updateButton {
    return SizedBox(
      width: screenWidget,
      height: 45,
      child: PrimaryElevatedBtn(
          "Update",
          () =>
              {controller.checkSignUpValidation(controller.selectTypeValue.value,fromTab: arguments['fromTab'])},
          borderRadius: 40.0),
    );
  }

  Widget textField(String hint, TextEditingController controller,
      TextInputType textInputType) {
    return TextField(
      controller: controller,
      textAlign: TextAlign.left,
      keyboardType: textInputType,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            width: 1,
            color: Colors.grey,
          ),
        ),
        filled: true,
        contentPadding: const EdgeInsets.all(20),
        fillColor: Colors.white,
      ),
    );
  }
}
