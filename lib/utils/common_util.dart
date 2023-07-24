import 'dart:math';
//import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'dart:io';
/*
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';*/
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mcsofttech/ui/module/home/home.dart';
import 'package:mcsofttech/utils/palette.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/tranflate_model.dart';
import '../ui/commonwidget/text_style.dart';
import '../ui/module/category/browse_category.dart';

class Common {
  static Options getOptions(String authToken) {
    return Options(headers: {"Authorization": authToken, "device": "mobile"});
  }
  static Future<void> _launchUrl(String url) async {
    await launchUrl(url) ;
  }
  static String  numberDigitParseInk(int number){
return NumberFormat.compactCurrency(
  decimalDigits: 0,
  symbol: '',
).format(number);
    String value= NumberFormat.compactCurrency(
      decimalDigits: 2,
      symbol: '',
    ).format(number);
    if(!value.contains(".0"))return value;

    var   splitValue = value.split(".");


    if(int.parse(splitValue[1])==0){
      return splitValue[0];
    }else{
      return value;
    }


  }
static Future<void> launchUrl(String url)async{
    await launchUrl(url);
  }
  static Future<bool?> showToast(String message) {
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static Widget productAllNavigation(String text,
      {required VoidCallback callback}) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyles.headingTexStyle(
              color: Palette.colorTextBlack,
              fontWeight: FontWeight.bold,
              fontSize: 14,
              fontFamily: 'Montserrat',
            ),
          ),
          GestureDetector(
            onTap: () {
              callback;
            },
            child: SvgPicture.asset(
                width: 28, height: 28, 'assets/svg/icon_left_arrow.svg'),
          )
        ],
      ),
    );
  }

  /* static Future<FirebaseApp> initializeFirebase({
    required BuildContext context,
  }) async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      const Home();
    }
    return firebaseApp;
  }*/
  static Widget languageAlertDialoagContainer() {
    List<TranslateModel> list = <TranslateModel>[];
    list.add(TranslateModel("ENGLISH", const Locale('en', 'US')));
    list.add(TranslateModel("हिंदी", const Locale('hi', 'IN')));

    return SizedBox(
      height: 300.0, // Change as per your requirement
      width: double.maxFinite, // Change as per your requirement
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            onTap: () {
              Get.updateLocale(list[index].local);
              Get.back();
            },
            title: Text(list[index].name),
          );
        },
      ),
    );
  }

  static Future<String?> getAddress(String latitude, String longitude) async {
    if (latitude.isNotEmpty && longitude.isNotEmpty) {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          double.parse(latitude), double.parse(longitude));
      debugPrint(placemarks.toString());
      Placemark place = placemarks[0];
      String address = '${place.locality}, '
          ' ${place.country}';
      return address.toString();
    }
    return "".toString();
  }

  static Future<String> getAppCurrentVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    // String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    //String currentAppVersion = "$version.$buildNumber";
    return buildNumber;
  }

  static Future<String?> getDeviceId() async {
    String id = Random(1000).toString();
    /*var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      id = iosDeviceInfo.isPhysicalDevice.toString();
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      id = androidDeviceInfo.id ?? "";
      return id; // unique ID on Android
    }*/
    return id;
  }

  static String dateParsing(String date) {
    DateFormat newDateFormat = DateFormat("dd-MM-yyyy");
    DateTime dateTime = DateFormat("yyyy-MM-dd'T'hh:mm:ss.000+0000").parse(date);
    String selectedDate = newDateFormat.format(dateTime);
    return selectedDate;
  }
  static String currentDateTimeStamp() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  static Future<void> deleteDialog() async {
    return showDialog<void>(
      context: Get.context!,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('delete_title'.tr),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text('delete_msg'.tr),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('yes'.tr),
              onPressed: () {
                print('Confirmed');
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('no'.tr),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  static Future<void> share({linkUrl,title,chooserTitle,text}) async {
    await FlutterShare.share(
        title: title??"",
        text: text??"",
        linkUrl: linkUrl??"",
        chooserTitle: chooserTitle??""
    );
  }

}
