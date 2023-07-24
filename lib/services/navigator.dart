import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<T?> navigateTo<T>(String route,
    {String? currentPageTitle, dynamic arguments}) async {
  Future.delayed(Duration.zero, () async {
    var result = await Get.toNamed(route, arguments: {
      'title': currentPageTitle,
      'arguments': arguments,
    });
    try {
      return result as T;
    } catch (e) {
      return null;
    }
  });

}

Future<T?> navigateOffAndTo<T>(String route,
    {String? currentPageTitle, dynamic arguments}) async {
  Future.delayed(Duration.zero, () async {
    var result = await Get.offAndToNamed(route, arguments: {
      'title': currentPageTitle,
      'arguments': arguments,
    });
    try {
      return result as T;
    } catch (e) {
      return null;
    }
  });

}

Future<T?> navigateOffAll<T>(String route,
    {String? currentPageTitle, dynamic arguments}) async {
  Future.delayed(Duration.zero, () async {
    var result = await Get.offAllNamed(route, arguments: {
      'title': currentPageTitle,
      'arguments': arguments,
    });
    try {
      return result as T;
    } catch (e) {
      return null;
    }
  });


}

Future<T?> navigateOffNamedUntil<T>(String route, RoutePredicate predicate,
    {String? currentPageTitle, dynamic arguments}) async {

  Future.delayed(Duration.zero, () async {
    var result = await Get.offNamedUntil(route, predicate, arguments: {
      'title': currentPageTitle,
      'arguments': arguments,
    });
    try {
      return result as T;
    } catch (e) {
      return null;
    }
  });
}

Future<T?> navigatePlacementNamedl<T>(String route,
    {String? currentPageTitle, dynamic arguments}) async {

  Future.delayed(Duration.zero, () async {
    var result = await Get.offNamed(route, arguments: {
      'title': currentPageTitle,
      'arguments': arguments,
    });
    try {
      return result as T;
    } catch (e) {
      return null;
    }
  });
}
//void popUntil(String routName) => Get.until(ModuleRoute.withName(routeName));
