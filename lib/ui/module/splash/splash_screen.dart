import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcsofttech/controllers/splash/force_update_controller.dart';
import 'package:mcsofttech/services/navigator.dart';
import 'package:mcsofttech/theme/my_theme.dart';
import 'package:mcsofttech/ui/module/login/before_login.dart';
import 'package:mcsofttech/ui/module/login/login_page.dart';
import '../../../data/preferences/AppPreferences.dart';
import '../../../utils/analytics.dart';
import '../../commonwidget/text_style.dart';
import '../home/home.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = "/splash";

  static Future<bool?> start<bool>(String currentPageTitle) {
    return navigateOffAll<bool>(routeName, currentPageTitle: currentPageTitle);
  }

  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final appPreferences = Get.find<AppPreferences>();
  final controller = Get.put(SplashController());

  @override
  void initState() {
    super.initState();
    _navigateToHome();

  }

  _navigateToHome() async {
    /*controller.callForceUpdateApi().then((value) {
      if (value) {*/
        if (appPreferences.isLoggedIn) {
          controller.callUserDashboardCardCall("Cart");
          Home.start();
          return;
        }
        LoginPage.start();
      }
   /* });*/
  //}

  @override
  Widget build(BuildContext context) {
    //Analytics.sendCurrentScreen("SplashScreen");
    return Scaffold(
      backgroundColor: MyColors.kColorWhite,
      body: SizedBox(
        height: double.infinity,
        width: double.maxFinite,
        child: Center(
          child: Image.asset(
            "assets/png/app_logo.png",
            width: size_100,
            height: size_100,
          ),
        ),
      ),
    );
  }

  showAlertDialog() {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("Update"),
      onPressed: () {},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Please update app!"),
      content: Text(
        "This is my message.",
        style: TextStyles.headingTexStyle(color: Colors.black),
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      barrierDismissible: false,
      useSafeArea: true,
      context: Get.context!,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
