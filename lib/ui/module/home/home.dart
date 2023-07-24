import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:mcsofttech/controllers/home/home_controller.dart';
import 'package:mcsofttech/ui/module/addsellrent/rent_sell.dart';
import 'package:mcsofttech/ui/module/cart/cart_list_page.dart';
import 'package:mcsofttech/ui/module/home/tab/account.dart';
import 'package:mcsofttech/ui/module/home/tab/dashboard.dart';
import 'package:mcsofttech/ui/module/home/tab/meri_dukaan_tab.dart';
import 'package:mcsofttech/ui/module/home/tab/more_screen.dart';
import 'package:mcsofttech/ui/module/login/login_page.dart';
import 'package:mcsofttech/utils/analytics.dart';
import 'package:mcsofttech/utils/analytics_constant.dart';
import 'package:mcsofttech/utils/common_util.dart';
import 'package:mcsofttech/utils/palette.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../controllers/addandsell/add_and_sell_controller.dart';
import '../../../controllers/training/training_controller.dart';
import '../../../data/preferences/AppPreferences.dart';
import '../../../notifire/cart_notifire.dart';
import '../../../services/navigator.dart';
import '../../../theme/my_theme.dart';
import '../../commonwidget/kart_counter.dart';
import '../../commonwidget/text_style.dart';
import '../export/buyer_requirement_and_seller_tab.dart';
import '../notfication/notifation_page.dart';
import 'mydrawer.dart';

class Home extends StatefulWidget {
  static String routeName = "/home";

  const Home({Key? key}) : super(key: key);

  static Future<bool?> start<bool>() {
    return navigateOffAll<bool>(routeName);
  }

  void openStorePageAtClickOnList(int storeId) {}

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  String location = 'Null, Press Button';
  String address = 'Location';
  String locality = 'Your Current\n';
  final appPreferences = Get.find<AppPreferences>();

  // Properties & Variables needed
  final isStore = false.obs;
  late DateTime currentBackPressTime;
  int currentTab = 0; // to keep track of active tab index
  final List<Widget> screens = [
    Dashboard(),
    Dashboard(),
    Dashboard(),
    Account(),
    RentSell()
  ]; // to store nested tabs
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Dashboard();
  double width = 0.0; // Our first view in viewport
  @override
  void initState() {
    super.initState();
    getAddress();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return body;
  }

  Widget get body {
   // Analytics.sendCurrentScreen(AnalyticsConstants.screenHome);
    return Scaffold(
        drawer: const DrawerDashboard(),
        appBar: appBar(context),
        body: PageStorage(
          bucket: bucket,
          child: currentScreen,
        ),
        floatingActionButton: storeDetail,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          color: MyColors.transparent,
          child: Container(
            height: 60,
            decoration: BoxDecoration(
                color: MyColors.themeColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                border: Border.all(
                  color: MyColors
                      .themeColor, //                   <--- border color
                )),
            //add ClipRRect widget for Round Corner
            child: Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    width: width / 2.4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        dashboard,
                        const SizedBox(
                          width: 20,
                        ),
                        meriDukaan,
                      ],
                    ),
                  ),
                  rentSell,
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    width: width / 2.7,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        export,
                        const SizedBox(
                          width: 20,
                        ),
                        more,
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (now.difference(currentBackPressTime) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: "Exit App");
      return Future.value(false);
    }
    return Future.value(true);
  }

  Widget get storeDetail {
    return SizedBox(
      child: FloatingActionButton(
        onPressed: () {
          if (appPreferences.isLoggedIn) {
            Get.delete<AddAndSellController>();
            RentSell.start("rent_sell".tr);
          } else {
            LoginPage.start();
          }
        },
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.add,
          color: MyColors.themeColor,
        ),
      ),
    );
  }

  Widget get dashboard {
    return InkWell(
      onTap: () {
        appPreferences.saveStoreId("0");
        setState(() {
          currentScreen =
              Dashboard(); // if user taps on this dashboard tab will be active
          currentTab = 0;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 20,
            height: 20,
            child: SvgPicture.asset('assets/svg/icon_home.svg'),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'home'.tr,
            style: TextStyles.headingTexStyle(
                color: Colors.white,
                fontWeight: FontWeight.w100,
                fontSize: 13,
                fontFamily: "Montserrat"),
          ),
        ],
      ),
    );
  }

  Widget get meriDukaan {
    return InkWell(
      onTap: () {
        setState(() {
          currentTab = 1;
          appPreferences.saveStoreId("0");
          if (appPreferences.isLoggedIn) {
            Get.delete<HomeController>();
            currentScreen = const MeriDukaanTabTabs();
          } else {
            LoginPage.start();
          }
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 20,
            height: 20,
            child: SvgPicture.asset('assets/svg/icon_meri_dukaan.svg'),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'meri_dukaan'.tr,
            style: TextStyles.headingTexStyle(
                color: Colors.white,
                fontWeight: FontWeight.w100,
                fontSize: 12,
                fontFamily: "Montserrat"),
          ),
        ],
      ),
    );
  }

  Widget get rentSell {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const SizedBox(
          width: 10,
          height: 30,
        ),
        Text(
          'rent_sell'.tr,
          style: TextStyles.headingTexStyle(
              color: Colors.white,
              fontWeight: FontWeight.w100,
              fontSize: 10,
              fontFamily: "Montserrat"),
        ),
      ],
    );
  }

  Widget get export {
    return InkWell(
      onTap: () {
        Get.delete<HomeController>();
        setState(() {
          currentScreen =
              const ExportTabs(); // if user taps on this dashboard tab will be active
          currentTab = 2;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 30,
            height: 25,
            child: SvgPicture.asset('assets/svg/icon_export.svg'),
          ),
          const SizedBox(
            height: 3,
          ),
          Text(
            'export'.tr,
            style: TextStyles.headingTexStyle(
                color: Colors.white,
                fontWeight: FontWeight.w100,
                fontSize: 12,
                fontFamily: "Montserrat"),
          ),
        ],
      ),
    );
  }

  Widget get more {
    return InkWell(
      onTap: () {
        setState(() {
          Get.delete<TrainingController>();
          currentScreen = MoreTab();
          currentTab = 3;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 20,
            height: 20,
            child: SvgPicture.asset('assets/svg/icon_more.svg'),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'more'.tr,
            style: TextStyles.headingTexStyle(
                color: Colors.white,
                fontWeight: FontWeight.w100,
                fontSize: 12,
                fontFamily: "Montserrat"),
          ),
        ],
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      leading: Builder(builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {
            Scaffold.of(context).openDrawer();
          },
          child: Padding(
            padding: const EdgeInsets.all(17),
            child: SvgPicture.asset('assets/png/icon_hamburger.svg'),
          ),
        );
      }),
      title: InkWell(
        onTap: () async {
          Position position = await _getGeoLocationPosition();
          location = 'Lat: ${position.latitude} , Long: ${position.longitude}';
          getAddressFromLatLong(position);
        },
        child: Row(
          children: [
            Icon(
              Icons.location_on,
              size: size_25,
              color: MyColors.kColorWhite,
            ),
            Column(
              children: [
                SizedBox(
                  width: 80,
                  child: RichText(
                    textAlign: TextAlign.center,
                    softWrap: true,
                    text: TextSpan(
                        text: locality,
                        style: const TextStyle(
                            fontSize: 16, color: Palette.kColorWhite),
                        children: <TextSpan>[
                          TextSpan(
                            text: address,
                            style: const TextStyle(
                              color: Palette.kColorWhite,
                              fontSize: 12,
                            ),
                          ),
                        ]),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        InkWell(
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Select Language'),
                    content: Common.languageAlertDialoagContainer(),
                  );
                });
          },
          child: Padding(
            padding:
                const EdgeInsets.only(left: 0, right: 15, top: 8, bottom: 8),
            child: Stack(
              children: [
                Align(
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                        width: 25, height: 25, 'assets/png/icon_lang.svg')),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () async => await launchUrl(
              Uri.parse("whatsapp://send?phone=+919138111860&text=hello")),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 0, right: 15, top: 8, bottom: 8),
            child: Stack(
              children: [
                Align(
                    alignment: Alignment.center,
                    child: SvgPicture.asset("assets/png/icon_chat_app.svg")),
              ],
            ),
          ),
        ),
        /*InkWell(
          onTap: () {
            NotificationPage.start("Notification");
            // WishListPage.start("Wish List");
          },
          child: Padding(
            padding:
                const EdgeInsets.only(left: 0, right: 15, top: 8, bottom: 8),
            child: Stack(
              children: [
                Align(
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                        width: 25,
                        height: 25,
                        'assets/svg/icon_notification.svg')),
              ],
            ),
          ),
        ),*/
        InkWell(
          onTap: () {
            CartListPage.start("my_cart".tr);
            /* if (appPreferences.isLoggedIn) {
               // KartStorePage.start();
              } else {
              //  LogInScreen.start();
              }*/
          },
          child: Padding(
            padding:
                const EdgeInsets.only(left: 0, right: 15, top: 8, bottom: 8),
            child: Stack(
              children: [
                Align(
                    alignment: Alignment.center,
                    child: SvgPicture.asset('assets/png/icon_cart.svg')),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: KartCounter(
                    count:
                        Provider.of<CartNotifier>(context).productList.length,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
      backgroundColor: MyColors.themeColor,
      shadowColor: Colors.transparent,
    );
  }

  Future<Position> _getGeoLocationPosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    } else {
      throw Exception('Error');
    }
    return await Geolocator.getCurrentPosition();

  }

  Future<void> getAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    debugPrint(placemarks.toString());
    Placemark place = placemarks[0];
    address =
        //'${place.subLocality},'
        ' ${place.locality}, '
        //'${place.postalCode},'
        ' ${place.country}';
    locality = '${place.subLocality},\n';
    setState(() {});
  }

  void getAddress() async {
    Position position = await _getGeoLocationPosition();
    location = 'Lat: ${position.latitude} , Long: ${position.longitude}';
    getAddressFromLatLong(position);
  }
}

class HomeInterface {
  void clickOnList() {}
}
