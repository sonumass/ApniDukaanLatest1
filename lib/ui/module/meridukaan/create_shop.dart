import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mcsofttech/ui/dialog/loader.dart';
import 'package:mcsofttech/utils/palette.dart';
import '../../../constants/Constant.dart';
import '../../../controllers/meridhukaan/meri_dukaan_controller.dart';
import '../../../services/navigator.dart';
import '../../base/page.dart';
import '../../commonwidget/primary_elevated_button.dart';
import '../../commonwidget/text_style.dart';
import '../profile/widget/profile_widget.dart';

class CreateShop extends AppPageWithAppBar {
  static const String routeName = "/createShop";

  CreateShop({Key? key}) : super(key: key);

  static Future<bool?> start<bool>(
    String title, {
    allProduct,
  }) {
    return navigateTo<bool>(routeName, currentPageTitle: title);
  }

  final controller = Get.put(MeriDukaanController());

  @override
  Widget get body {
    return Obx(
      () => controller.isLoader.value
          ? const Loader()
          : Container(
              color: Palette.appColor,
              child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  physics: const BouncingScrollPhysics(),
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 150,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: SizedBox(
                              width: 200,
                              height: 100,
                              child: Center(
                                child: Obx(
                                    () => controller.bytesImage.value.isNotEmpty
                                        ? Image.memory(
                                            controller.bytesImage.value,
                                            fit: BoxFit.contain,
                                          )
                                        : FadeInImage.assetNetwork(
                                            placeholder:
                                                'assets/png/app_logo.png',
                                            image:
                                                "${Constant.baseUrl}${controller.meriDukaanModel?.dukanDetails?.logo ?? ""}",
                                            fit: BoxFit.cover,
                                            height: 40.0,
                                          )),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: uploadImageButton1,
                          )
                        ],
                      ),
                    ),
                    companyName,
                    shopTagLine,
                    yearOfEst,
                    natureOfBusiness,
                    email,
                    phone,
                    companyAddress,
                    whatsAppNumber,
                    gstNumber,
                    myCompanyUrl,
                    checkUrlButton,
                    faceBookLink,
                    linkdinLink,
                    twitterLink,
                    instagramLink,
                    youTubeLink,
                    githubLink,
                    aboutUs,
                    createShop
                  ]),
            ),
    );
  }

  Widget get uploadImageButton1 {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: SizedBox(
        width: screenWidget,
        height: 45,
        child: PrimaryElevatedBtn("upload_image".tr, () {
          controller.getImage();
        }, borderRadius: 40.0),
      ),
    );
  }

  Widget get companyName {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          "my_company_my_dukaan".tr,
          style: TextStyles.headingTexStyle(color: Palette.kColorWhite),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: TextField(
              controller: controller.companyNameController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget get shopTagLine {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          "shop_tag_line".tr,
          style: TextStyles.headingTexStyle(color: Palette.kColorWhite),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: TextField(
              controller: controller.shopTagLineController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget get yearOfEst {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          "year_of_establish".tr,
          style: TextStyles.headingTexStyle(color: Palette.kColorWhite),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: TextField(
              controller: controller.yearOfEstController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget get natureOfBusiness {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          "nature_of_business".tr,
          style: TextStyles.headingTexStyle(color: Palette.kColorWhite),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: TextField(
                controller: controller.natureOfBusinessController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ))
      ],
    );
  }

  Widget get email {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          "email".tr,
          style: TextStyles.headingTexStyle(color: Palette.kColorWhite),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: TextField(
                controller: controller.emailController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ))
      ],
    );
  }

  Widget get phone {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          "mobile".tr,
          style: TextStyles.headingTexStyle(color: Palette.kColorWhite),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: TextField(
                controller: controller.phoneController,
                keyboardType: TextInputType.phone,
                maxLength: 10,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ))
      ],
    );
  }

  Widget get companyAddress {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          "address".tr,
          style: TextStyles.headingTexStyle(color: Palette.kColorWhite),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: TextField(
                controller: controller.companyAddressController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ))
      ],
    );
  }

  Widget get checkUrlButton {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: SizedBox(
          width: screenWidget / 3,
          height: 40,
          child: PrimaryElevatedBtn(
            "check_url".tr,
            () async => {controller.callCompanyUrlApi()},
            borderRadius: 40.0,
            buttonStyle: ButtonStyle(backgroundColor:
                MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> state) {
              if (state.contains(MaterialState.pressed)) {
                return Palette.buttonsColor;
              } else if (state.contains(MaterialState.disabled)) {
                return Palette.buttonsColor;
              }
              return Palette.buttonsColor;
            })),
          ),
        ),
      ),
    );
  }

  Widget get whatsAppNumber {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          "whatsapp_number".tr,
          style: TextStyles.headingTexStyle(color: Palette.kColorWhite),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: TextField(
                controller: controller.whatsAppNumberController,
                keyboardType: TextInputType.phone,
                maxLength: 10,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ))
      ],
    );
  }

  Widget get gstNumber {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          "gst_number".tr,
          style: TextStyles.headingTexStyle(color: Palette.kColorWhite),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: TextField(
                controller: controller.gstNumberController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ))
      ],
    );
  }

  Widget get myCompanyUrl {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          "shop_link".tr,
          style: TextStyles.headingTexStyle(color: Palette.kColorWhite),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: TextField(
                controller: controller.myCompanyUrlController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            )),
      ],
    );
  }

  Widget get faceBookLink {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          "facebook_link".tr,
          style: TextStyles.headingTexStyle(color: Palette.kColorWhite),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: TextField(
                controller: controller.faceBookLinkController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ))
      ],
    );
  }

  Widget get linkdinLink {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          "linkedin_link".tr,
          style: TextStyles.headingTexStyle(color: Palette.kColorWhite),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: TextField(
                controller: controller.linkdinLinkController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ))
      ],
    );
  }

  Widget get twitterLink {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          "twitter_link".tr,
          style: TextStyles.headingTexStyle(color: Palette.kColorWhite),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: TextField(
                controller: controller.twitterLinkController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ))
      ],
    );
  }

  Widget get instagramLink {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          "instagram_link".tr,
          style: TextStyles.headingTexStyle(color: Palette.kColorWhite),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: TextField(
                controller: controller.instagramLinkController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ))
      ],
    );
  }

  Widget get youTubeLink {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          "youtube_link".tr,
          style: TextStyles.headingTexStyle(color: Palette.kColorWhite),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: TextField(
                controller: controller.youTubeLinkController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ))
      ],
    );
  }

  Widget get githubLink {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          "github_link".tr,
          style: TextStyles.headingTexStyle(color: Palette.kColorWhite),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: TextField(
                controller: controller.githubLinkController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ))
      ],
    );
  }

  Widget get aboutUs {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          "about_us".tr,
          style: TextStyles.headingTexStyle(color: Palette.kColorWhite),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: TextField(
                controller: controller.aboutUsController,
                keyboardType: TextInputType.text,
                maxLines: 5,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ))
      ],
    );
  }

  Widget get createShop {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: SizedBox(
        width: screenWidget,
        height: 45,
        child: PrimaryElevatedBtn(
          (controller.myCompanyUrlController.text.isNotEmpty)
              ? "Update Dukaan"
              : "create_shop".tr,
          () async => {controller.callCreateShopApi()},
          borderRadius: 40.0,
          buttonStyle: ButtonStyle(backgroundColor:
              MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> state) {
            if (state.contains(MaterialState.pressed)) {
              return Palette.buttonsColor;
            } else if (state.contains(MaterialState.disabled)) {
              return Palette.buttonsColor;
            }
            return Palette.buttonsColor;
          })),
        ),
      ),
    );
  }
}
