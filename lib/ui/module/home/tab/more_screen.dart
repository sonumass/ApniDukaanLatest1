import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcsofttech/ui/module/home/tab/banking_screen.dart';
import 'package:mcsofttech/ui/module/home/tab/prime_screen.dart';
import 'package:mcsofttech/ui/module/home/tab/training_screen.dart';
import 'package:mcsofttech/ui/module/meridukaan/meri_dukaan.dart';
import 'package:mcsofttech/ui/module/news_and_video/news_screen.dart';
import 'package:mcsofttech/ui/module/profile/my_profile.dart';
import 'package:mcsofttech/ui/module/testimonial/testimonial_screen.dart';
import 'package:mcsofttech/ui/module/thankyou/thank_you.dart';
import '../../../../data/preferences/AppPreferences.dart';
import '../../../../utils/analytics.dart';
import '../../../../utils/analytics_constant.dart';
import '../../../base/page.dart';
import '../../../commonwidget/more_card_widget.dart';
import '../../login/login_page.dart';
import '../../news_and_video/video_screen.dart';
import '../../profile/profile_page.dart';

class MoreTab extends AppPageWithAppBar {
  MoreTab({Key? key}) : super(key: key);

  @override
  double? get toolbarHeight => 0;
  final appPreferences = Get.find<AppPreferences>();

  @override
  Widget get body {
    //Analytics.sendCurrentScreen(AnalyticsConstants.screenMore);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                profileCard,
                const SizedBox(
                  width: 10,
                ),
                news
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                banking,
                const SizedBox(
                  width: 10,
                ),
                training
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                promoteBusiness,
                const SizedBox(
                  width: 10,
                ),
                videoNews
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                prime,
                const SizedBox(
                  width: 10,
                ),
                weather
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget get profileCard {
    return InkWell(
      onTap: () {
        if (appPreferences.isLoggedIn) {
          MyProfile.start();
        } else {
          LoginPage.start();
        }
      },
      child: const MoreWidgetCard(
          assetName: "assets/svg/ic_profile_card.png",
          text: "My Profile",
          iconAsset: "assets/svg/icon_profile.png"),
    );
  }

  Widget get mandiBhav {
    return InkWell(
      onTap: () {
        ThankYou.start();
      },
      child: const MoreWidgetCard(
          assetName: "assets/svg/ic_mandi_bhav_card.png",
          text: "Mandi Bhav",
          iconAsset: "assets/svg/ic_mondi_icon.png"),
    );
  }

  Widget get banking {
    return InkWell(
      onTap: () {
        BankingPage.start("Banking");
      },
      child: const MoreWidgetCard(
          assetName: "assets/svg/ic_banking_card.png",
          text: "Banking",
          iconAsset: "assets/svg/icon_banking.png"),
    );
  }

  Widget get training {
    return InkWell(
      onTap: () {
        TrainingPage.start("Training");
      },
      child: const MoreWidgetCard(
          assetName: "assets/svg/ic_taning_card.png",
          text: "Training",
          iconAsset: "assets/svg/icon_traning.png"),
    );
  }

  Widget get promoteLead {
    return InkWell(
      onTap: () {
        ThankYou.start();
      },
      child: const MoreWidgetCard(
          assetName: "assets/svg/ic_promote_lead_card.png",
          text: "Promote Your \n      Lead",
          iconAsset: "assets/svg/icon_promot_leade.png"),
    );
  }

  Widget get promoteBusiness {
    return InkWell(
      onTap: () {
       MeriDukaan.start("Promote Business", "https://f2df.com/grow-business/promote-your-business");
      },
      child: const MoreWidgetCard(
          assetName: "assets/svg/ic_promote_business_card.png",
          text: "Promote your \n   Business",
          iconAsset: "assets/svg/icon_promot_business.png"),
    );
  }

  Widget get news {
    return InkWell(
      onTap: () {
        NewsScreen.start();
      },
      child: const MoreWidgetCard(
          assetName: "assets/png/ic_mandi_new.png",
          text: "      News \n         &\nMandi bhav",
          iconAsset: "assets/svg/icon_news.png"),
    );
  }

  Widget get videoNews {
    return InkWell(
      onTap: () {
        VideoScreen.start();
      },
      child: const MoreWidgetCard(
          assetName: "assets/svg/ic_video_card.png",
          text: "F2DF TV",
          iconAsset: "assets/svg/ic_f2df_tv.png"),
    );
  }

  Widget get prime {
    return InkWell(
      onTap: () {
        PrimePage.start("Prime Video");
      },
      child: const MoreWidgetCard(
          assetName: "assets/svg/ic_prime_card.png",
          text: "F2DF Prime",
          iconAsset: "assets/svg/ic_mondi_icon.png"),
    );
  }

  Widget get weather {
    return InkWell(
      onTap: () {
        TestimonialScreen.start();
      },
      child: const MoreWidgetCard(
          assetName: "assets/svg/ic_weather_card.png",
          text: "Testimonial",
          iconAsset: "assets/svg/icon_traning.png"),
    );
  }
}
