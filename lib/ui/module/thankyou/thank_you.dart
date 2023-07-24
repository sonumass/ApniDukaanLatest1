import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mcsofttech/theme/my_theme.dart';
import 'package:mcsofttech/ui/commonwidget/outline_elevated_button.dart';

import '../../../services/navigator.dart';
import '../../../utils/palette.dart';
import '../../base/page.dart';
import '../../commonwidget/text_style.dart';

class ThankYou extends AppPageWithAppBar {
  static const String routeName = "/thankyou";

  ThankYou({Key? key}) : super(key: key);

  static Future<bool?> start<bool>() {
    return navigateTo<bool>(
      routeName,
      currentPageTitle: "Thank You",
    );
  }

  @override
  double? get toolbarHeight => 0;

  @override
  Widget get body {
    return SafeArea(
        child: SingleChildScrollView(
      child: Container(
        height: screenHeight,
        color: MyColors.themeColor,
        child: Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Text("WE ARE",
                  style: TextStyles.headingTexStyle(
                    color: Palette.kColorWhite,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    fontFamily: 'Montserrat',
                  )),
              const SizedBox(
                height: 50,
              ),
              Text("COMING SOON",
                  style: TextStyles.headingTexStyle(
                    color: Palette.kColorWhite,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    fontFamily: 'Montserrat',
                  )),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(30),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: SvgPicture.asset("assets/svg/icon_coming_soon.svg"),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Text(
                    "Stay with us and be the first to learn about our latest offers and exciting new features.",
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    style: TextStyles.headingTexStyle(
                      color: Palette.kColorWhite,
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                      fontFamily: 'Montserrat',
                    )),
              ),
              const SizedBox(
                height: 50,
              ),
              OutLineElevatedBtn("Thank You", () => Get.back())
            ],
          ),
        ),
      ),
    ));
  }
}
