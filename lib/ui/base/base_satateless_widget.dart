import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

abstract class BaseStateLessWidget extends StatelessWidget {
  const BaseStateLessWidget({Key? key}) : super(key: key);

  double get screenHeight => Get.height;

  double get screenWidget => Get.width;

  double get statusBarHeight => MediaQuery.of(Get.context!).padding.top;

  double get actionBarHeight => AppBar().preferredSize.height;
}
