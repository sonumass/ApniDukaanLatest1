import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:mcsofttech/theme/my_theme.dart';

import '../../../utils/palette.dart';
import '../../deeplink/deep_link.dart';
import 'base_satateless_widget.dart';

abstract class AppPage extends BaseStateLessWidget {
  AppPage({Key? key}) : super(key: key);

  dynamic get arguments {
    try {
      return Get.arguments['arguments'];
    } catch (e) {
      return null;
    }
  }

  Widget? get leadingWidget {
    return IconButton(
        visualDensity: VisualDensity.compact,
        splashRadius: 24,
        onPressed: Get.back,
        icon: const Icon(Icons.arrow_back_outlined));
  }

  String get title {
    try {
      return Get.arguments['title'];
    } catch (e) {
      return '';
    }
  }

  Widget? get titleWidget => null;

  bool get centerTitle => false;

  Widget get defaultTitleWidget => Text(
        title,
        style: const TextStyle(
            color: MyColors.kColorWhite, fontWeight: FontWeight.w200),
      );

  List<Widget>? get action => [];

  Widget get profileAction =>
      const IconButton(onPressed: null, icon: Icon(Icons.camera));

  final List<Widget> modulePageAction = [];

  double? get toolbarHeight => null;

  bool get automaticallyImplyleading => true;

  Color get actionBarContentColor => Palette.kColorWhite;

  String? get heading => null;

  Widget? get headerAction => null;

  Widget simpleAddHeaderAction(String text, VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.add,
              color: Palette.colorPrimaryDark,
            ),
            Text(text),
          ],
        ),
      ),
    );
  }

  Widget get header {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text(heading ?? ''),
          ),
        ),
        if (headerAction != null) headerAction!
      ],
    );
  }

  Widget? get bottomNavBar => null;

  FloatingActionButtonLocation? get floatingActionButtonLocation => null;

  Future<bool> Function()? get onWillPop => null;
}

enum WidgetVisibility { visible, invisible }

class AppPageWithAppBar extends AppPage {
  AppPageWithAppBar({Key? key}) : super(key: key);

  PreferredSizeWidget? get appBar {
    return AppBar(
      leading: leadingWidget,
      automaticallyImplyLeading: automaticallyImplyleading,
      iconTheme: IconThemeData(color: actionBarContentColor),
      elevation: 0,
      titleSpacing: 0,
      centerTitle: centerTitle,
      backgroundColor: MyColors.themeColor,
      toolbarHeight: toolbarHeight,
      systemOverlayStyle: SystemUiOverlayStyle.dark
          .copyWith(statusBarColor: Colors.transparent),
      title: titleWidget ?? defaultTitleWidget,
      actions: action
          ?.map((e) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: e,
              ))
          .toList(),
    );
  }

  bool get resizeToAvoidBottomInset => true;

  bool get observeVisibleChnages => false;

  void onResume() {}

  void onPause() {}

  Widget get body => Container(
        color: Palette.backgroundBg,
        decoration: const BoxDecoration(color: MyColors.appColor),
      );
  initDynamicLinks(BuildContext context) async {
    await Future.delayed(Duration(seconds: 3));
    var data = await FirebaseDynamicLinks.instance.getInitialLink();
    var deepLink = data?.link;
    /*final queryParams = deepLink?.queryParameters;
    if (queryParams?.length! > 0) {
      var userName = queryParams['userId'];
    }*/
    FirebaseDynamicLinks.instance.onLink;
  }
  @override
  Widget build(BuildContext context) {
    DynamicLinksApi().initDynamicLinks(context);
    Widget content = Scaffold(
      appBar: appBar,
      body: body,
      floatingActionButton: null,
      floatingActionButtonLocation: null,
      bottomNavigationBar: bottomNavBar,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
    );
    return WillPopScope(
        onWillPop: onWillPop,
        child: observeVisibleChnages
            ? FocusDetector(
                onFocusGained: () {
                  onResume();
                },
                onFocusLost: () {
                  onPause();
                },
                onVisibilityLost: () {
                  onPause();
                },
                child: content,
              )
            : content);
  }
}
