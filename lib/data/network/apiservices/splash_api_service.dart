import 'dart:convert';

import 'package:flutter/foundation.dart';
import '../../../constants/Constant.dart';
import '../dio_client.dart';

class SplashApiServices extends DioClient {
  final client = DioClient.client;

  Future<bool?> forceUpdateApi({appVersion}) async {
    bool isUpdate = false;
    var inputData = {
      "id": appVersion,
    };
    debugPrint('inputData: $inputData');
    try {
      final response = await client.post(
        "${Constant.baseUrl}/home/forceFullyUpdate",
        data: jsonEncode(inputData),
      );
      if (kDebugMode) {
        debugPrint('outPut: ${response.data}');
        isUpdate = response.data;
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return isUpdate;
  }
}
