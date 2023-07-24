import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mcsofttech/utils/common_util.dart';
import 'package:mcsofttech/utils/palette.dart';
import 'package:permission_handler/permission_handler.dart';

Future<bool> requestPermission(Permission permission, String permisionLable,
    {String? rational}) async {
  PermissionStatus status = await permission.request();
  switch (status) {
    case PermissionStatus.granted:
    case PermissionStatus.restricted:
    case PermissionStatus.limited:
    case PermissionStatus.denied:
      bool? result = await showAppRequirePermissionDialog(permisionLable,
          rational: rational);
      return result == true
          ? await requestPermission(permission, permisionLable,
              rational: rational)
          : false;
    case PermissionStatus.permanentlyDenied:
  }
  return false;
}

Future<bool?> showAppRequirePermissionDialog(String? permissionLabel,
    {String? rational}) async {
  return await showAlertDialog(
      title: const Text("Permission is required"),
      content: Text(
        rational ?? "Need permission",
      ),
      positiveAction: "Give",
      negativeAction: "Cancel");
}

Future<bool?> showAlertDialog(
    {Widget? title,
    Widget? content,
    String? positiveAction,
    VoidCallback? onPositiveAction,
    String? negativeAction,
    VoidCallback? onNegativeAction}) async {
  List<Widget> action = [];
  if (negativeAction != null) {
    action.add(TextButton(
        onPressed: () => Get.back(result: false), child: Text(negativeAction)));
  }
  if (positiveAction != null) {
    action.add(TextButton(
        onPressed: () => Get.back(result: false), child: Text(positiveAction)));
  }
  final dialog = AlertDialog(
    title: title,
    content: content!,
    actions: action,
  );
  return await showDialog<bool>(
      useSafeArea: false,
      context: Get.context!,
      barrierColor: Palette.colorTextGrey.withOpacity(0.91),
      builder: (_) => dialog);
}
