import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

import '../ui/dialog/loader.dart';

class BaseController extends GetxController {
  bool _isLoaderVisible = false;

  bool get isLoaderVisible => _isLoaderVisible;

  bool get isLoaderNotVisible => !_isLoaderVisible;

  void cancelSubscription(StreamSubscription? streamSubscription) {
    if (streamSubscription != null) streamSubscription.cancel();
  }

  void showLoader() {
    if (Get.isSnackbarOpen) {
      Get.back();
    }
    if (!_isLoaderVisible) {
      Get.dialog(const Loader(),
          useSafeArea: false,
          routeSettings: const RouteSettings(name: "AppLoader"));
      _isLoaderVisible = true;
    }
  }

  void hideLoader({bool closeOverlays = false}) {
    if (_isLoaderVisible) {
      Get.back(closeOverlays: closeOverlays);
      _isLoaderVisible = false;
    }
  }
}
