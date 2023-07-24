import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcsofttech/constants/Constant.dart';
import 'package:mcsofttech/controllers/meridhukaan/meri_dukaan_controller.dart';
import 'package:mcsofttech/theme/my_theme.dart';
import 'package:mcsofttech/ui/module/login/login_page.dart';
import 'package:mcsofttech/ui/module/meridukaan/my_product.dart';
import 'package:mcsofttech/ui/module/profile/profile_page.dart';
import 'package:share/share.dart';
import '../../../data/preferences/AppPreferences.dart';
import '../meridukaan/create_shop.dart';
import '../meridukaan/meri_dekaan_dashboard.dart';
import '../news_and_video/news_and_video.dart';
import 'drawar/web_view.dart';

class DrawerDashboard extends StatefulWidget {
  const DrawerDashboard({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DrawerDashboardState();
  }
}

class _DrawerDashboardState extends State<DrawerDashboard> {
  final appPreferences = Get.find<AppPreferences>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        width: Get.width/1.2,
        backgroundColor: MyColors.kColorLightWhite,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 150,
                    color: MyColors.colorPrimary,
                    child: Column(
                      children: [
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 18, left: 14),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100.0),
                                  child: FadeInImage.assetNetwork(
                                    placeholder: 'assets/png/app_logo.png',
                                    image: appPreferences.userImage.isNotEmpty
                                        ? "${Constant.baseUrl}${appPreferences.userImage}"
                                        : "https://cdn-icons-png.flaticon.com/512/149/149071.png",
                                    fit: BoxFit.cover,
                                    height: 70.0,
                                    width: 70.0,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 12, top: 35),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text: appPreferences.userName,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Montserrat',
                                            color: Colors.white)),
                                    const TextSpan(
                                        text: " \n",
                                        style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: Colors.white)),
                                    TextSpan(
                                        text: appPreferences.mobile,
                                        style: const TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: Colors.white)),
                                  ]),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              shipingAndDelivery,
              sellerTermAndCondition,
              privacyPolicy,
              supportAndSecurity,
              cancellationPolicy,
              termAndCondition,
              referralCode,
              faqs,
              invite(context),
              contactUs,
              appPreferences.isLoggedIn ? logout : const SizedBox.shrink(),
              const SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget get profile {
    return InkWell(
      onTap: () {},
      child: ListTile(
        leading: const Icon(Icons.person_pin),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: "profile".tr,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                        color: Colors.black87)),
              ]),
            ),
            Icon(
              Icons.chevron_right,
              size: size_20,
            ),
          ],
        ),
        onTap: () {
          if (appPreferences.isLoggedIn) {
            EditProfile.start(fromTab: "Home");
          } else {
            LoginPage.start();
          }
        },
      ),
    );
  }

  Widget get createShop {
    return InkWell(
      onTap: () {},
      child: ListTile(
        leading: const Icon(Icons.store_sharp),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: "create_shop".tr,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                        color: Colors.black87)),
              ]),
            ),
            Icon(
              Icons.chevron_right,
              size: size_20,
            ),
          ],
        ),
        onTap: () {
          if (appPreferences.isLoggedIn) {
            Get.delete<MeriDukaanController>();
            CreateShop.start("create_shop".tr);
          } else {
            LoginPage.start();
          }
        },
      ),
    );
  }

  Widget get viewOnlineShop {
    return InkWell(
      onTap: () {},
      child: ListTile(
        leading: const Icon(Icons.store_sharp),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: "View Online dukaan".tr,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                        color: Colors.black87)),
              ]),
            ),
            Icon(
              Icons.chevron_right,
              size: size_20,
            ),
          ],
        ),
        onTap: () {
          if (appPreferences.isLoggedIn) {
            Get.delete<MeriDukaanController>();
            MyStatefulWidget.start("meri_dukaan".tr);
          } else {
            LoginPage.start();
          }
        },
      ),
    );
  }

  Widget get myProduct {
    return InkWell(
      onTap: () {},
      child: ListTile(
        leading: const Icon(Icons.card_travel),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: "my_product".tr,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                        color: Colors.black87)),
              ]),
            ),
            Icon(
              Icons.chevron_right,
              size: size_20,
            ),
          ],
        ),
        onTap: () {
          if (appPreferences.isLoggedIn) {
            Get.delete<MeriDukaanController>();
            MyProductPage.start("my_product".tr);
          } else {
            LoginPage.start();
          }
        },
      ),
    );
  }

  Widget get contactUs {
    return InkWell(
      onTap: () {},
      child: ListTile(
        leading: const Icon(Icons.contact_page_outlined),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: "contact_us".tr,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                        color: Colors.black87)),
              ]),
            ),
            Icon(
              Icons.chevron_right,
              size: size_20,
            ),
          ],
        ),
        onTap: () {
          NavigationWebView.start(
              "Contact Us", "${Constant.webViewBaseUrl}/new-f2df/contact.html");
          // Session().logout();
          //navigatorPushReplace(const LoginScreen());
        },
      ),
    );
  }

  Widget get newsAndVideo {
    return InkWell(
      onTap: () {
        NavigationWebView.start("new_and_video".tr,
            "${Constant.webViewBaseUrl}/new-f2df/contact.html");
      },
      child: ListTile(
        leading: const Icon(Icons.newspaper_sharp),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: "new_and_video".tr,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                        color: Colors.black87)),
              ]),
            ),
            Icon(
              Icons.chevron_right,
              size: size_20,
            ),
          ],
        ),
        onTap: () {
          NewsAndVideo.start("new_and_video".tr);
        },
      ),
    );
  }

  Widget get shipingAndDelivery {
    return InkWell(
      onTap: () {},
      child: ListTile(
        leading: const Icon(Icons.delivery_dining),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: "shipping_And_delivery_policy".tr,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                        color: Colors.black87)),
              ]),
            ),
            Icon(
              Icons.chevron_right,
              size: size_20,
            ),
          ],
        ),
        onTap: () {
          NavigationWebView.start("shipping_And_delivery_policy".tr,
              "${Constant.webViewBaseUrl}/new-f2df/shipping-delivery-policy.html");
        },
      ),
    );
  }

  Widget get sellerTermAndCondition {
    return InkWell(
      onTap: () {},
      child: ListTile(
        leading: const Icon(Icons.sell_outlined),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: "seller_term_and_condition".tr,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                        color: Colors.black87)),
              ]),
            ),
            Icon(
              Icons.chevron_right,
              size: size_20,
            ),
          ],
        ),
        onTap: () {
          NavigationWebView.start("seller_term_and_condition".tr,
              "${Constant.webViewBaseUrl}/new-f2df/seller-m-term-conditions.html");
        },
      ),
    );
  }

  Widget get privacyPolicy {
    return InkWell(
      onTap: () {
        NavigationWebView.start("privacy_policy".tr,
            "${Constant.webViewBaseUrl}//new-f2df/privacy-policy.html");
      },
      child: ListTile(
        leading: const Icon(Icons.privacy_tip_outlined),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: "privacy_policy".tr,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                        color: Colors.black87)),
              ]),
            ),
            Icon(
              Icons.chevron_right,
              size: size_20,
            ),
          ],
        ),
        onTap: () {
          NavigationWebView.start("privacy_policy".tr,
              "${Constant.webViewBaseUrl}/new-f2df/privacy-policy.html");
        },
      ),
    );
  }

  Widget get cancellationPolicy {
    return InkWell(
      onTap: () {},
      child: ListTile(
        leading: const Icon(Icons.free_cancellation),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: "cancellation_policy".tr,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                        color: Colors.black87)),
              ]),
            ),
            Icon(
              Icons.chevron_right,
              size: size_20,
            ),
          ],
        ),
        onTap: () {
          NavigationWebView.start("cancellation_policy".tr,
              "${Constant.webViewBaseUrl}/new-f2df/cancellation-policy.html");
        },
      ),
    );
  }

  Widget get termAndCondition {
    return InkWell(
      onTap: () {},
      child: ListTile(
        leading: const Icon(Icons.terminal),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: "terms_conditions".tr,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                        color: Colors.black87)),
              ]),
            ),
            Icon(
              Icons.chevron_right,
              size: size_20,
            ),
          ],
        ),
        onTap: () {
          NavigationWebView.start("terms_conditions".tr,
              "${Constant.webViewBaseUrl}/new-f2df/terms-conditions.html");
        },
      ),
    );
  }

  Widget get faqs {
    return InkWell(
      onTap: () {},
      child: ListTile(
        leading: const Icon(Icons.fact_check_outlined),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: "faqs".tr,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                        color: Colors.black87)),
              ]),
            ),
            Icon(
              Icons.chevron_right,
              size: size_20,
            ),
          ],
        ),
        onTap: () {
          NavigationWebView.start(
              "faqs".tr, "http://f2df.com/about-us/faq");
        },
      ),
    );
  }

  Widget get referralCode {
    return InkWell(
      onTap: () {},
      child: ListTile(
        leading: const Icon(Icons.local_offer_outlined),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: "rafferal_code".tr,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                        color: Colors.black87)),
              ]),
            ),
            Icon(
              Icons.chevron_right,
              size: size_20,
            ),
          ],
        ),
        onTap: () {
          NavigationWebView.start("rafferal_code".tr,
              "${Constant.webViewBaseUrl}/new-f2df/contact.html");
        },
      ),
    );
  }

  Widget get visitFaceBook {
    return InkWell(
      onTap: () {},
      child: ListTile(
        leading: const Icon(Icons.video_call),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: "visit_faceBook".tr,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                        color: Colors.black87)),
              ]),
            ),
            Icon(
              Icons.chevron_right,
              size: size_20,
            ),
          ],
        ),
        onTap: () {
          NavigationWebView.start(
              "visit_faceBook".tr, "https://www.facebook.com/f2dfsupport");
        },
      ),
    );
  }

  Widget get visitYoutube {
    return InkWell(
      onTap: () {},
      child: ListTile(
        leading: const Icon(Icons.video_call),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: "visit_youTube".tr,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                        color: Colors.black87)),
              ]),
            ),
            Icon(
              Icons.chevron_right,
              size: size_20,
            ),
          ],
        ),
        onTap: () {
          NavigationWebView.start(
              "visit_youTube".tr, "https://www.youtube.com/c/F2DFOFFICIAL");
        },
      ),
    );
  }

  Widget get logout {
    return InkWell(
      onTap: () {},
      child: ListTile(
        leading: const Icon(Icons.logout),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: "log_out".tr,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                        color: Colors.black87)),
              ]),
            ),
            Icon(
              Icons.chevron_right,
              size: size_20,
            ),
          ],
        ),
        onTap: () {
          appPreferences.logOut();
          LoginPage.start();
        },
      ),
    );
  }

  share(BuildContext context) {
    final RenderBox? box = context.findRenderObject() as RenderBox?;
    Share.share(
        "https://play.google.com/store/apps/details?id=com.f2df.mcsofttech",
        subject: "share_app".tr,
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }

  Widget invite(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.share),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(children: [
              TextSpan(
                  text: "share_app".tr,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                      color: Colors.black87)),
              // TextSpan(text: "Name: Email id", style: TextStyle(fontFamily: 'Montserrat', color: Colors.black26)),
            ]),
          ),
          Icon(
            Icons.chevron_right,
            size: size_20,
          ),
        ],
      ),
      onTap: () {
        share(context);
      },
    );
  }

  Widget get supportAndSecurity {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Align(
          alignment: Alignment.topLeft,
          child: Text(
            "support_and_security".tr,
            style: const TextStyle(color: Colors.black26),
          )),
    );
  }

  Widget get aboutUs {
    return ListTile(
      leading: const Icon(Icons.info_outline),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(children: [
              TextSpan(
                  text: "about_us".tr,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                      color: Colors.black87)),
              // TextSpan(text: "Name: Email id", style: TextStyle(fontFamily: 'Montserrat', color: Colors.black26)),
            ]),
          ),
          Icon(
            Icons.chevron_right,
            size: size_20,
          ),
        ],
      ),
      onTap: () {
        // AboutUs.start();
        //navigatorPushReplace(const LoginScreen());
      },
    );
  }

  Widget get branding {
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "Made with ",
                style: TextStyle(color: Colors.black38, fontSize: 12),
              ),
              Icon(
                Icons.favorite,
                color: Colors.red,
                size: 18,
              ),
              Text(
                " by ",
                style: TextStyle(color: Colors.black38, fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
