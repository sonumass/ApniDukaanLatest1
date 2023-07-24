import 'package:flutter/material.dart';
import 'package:mcsofttech/services/navigator.dart';
import 'package:mcsofttech/theme/my_theme.dart';
import 'package:mcsofttech/ui/base/page.dart';
import 'package:mcsofttech/ui/commonwidget/text_style.dart';
import 'package:mcsofttech/ui/module/profile/profile_page.dart';

import 'my_order.dart';

class MyProfile extends AppPageWithAppBar {
  static String routeName = "/myProfile";

  MyProfile({Key? key}) : super(key: key);

  static Future<bool?> start<bool>() {
    return navigateTo<bool>(
      routeName,
      currentPageTitle: "My Profile",
    );
  }

  @override
  Widget get body {
    return Scaffold(
      body: Column(
        children: [items(()=>EditProfile.start(fromTab: "home"),"Profile"),items(()=>MyOrder.start(),"Orders")],
      ),
    );
  }

  Widget items(VoidCallback onPress,String title) {
    return SizedBox(
      width: screenWidget,
      child: InkWell(
        onTap:onPress,
        child: Card(
          elevation: 3,
          margin: const EdgeInsets.only(left: 10, right: 10,top: 10,bottom: 10),
          shape: RoundedRectangleBorder(
            side: BorderSide(width: .5, color: MyColors.kColorGrey),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(padding: const EdgeInsets.all(20),child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  maxLines: 2,
                  style: TextStyles.headingTexStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: MyColors.kColorBlack,
                      fontFamily: "assets/font/Oswald-Regular.ttf")),
              const Icon(Icons.arrow_forward_ios_outlined,color: MyColors.themeColor,),
            ],
          ),),
        ),
      ),
    );
  }


}
