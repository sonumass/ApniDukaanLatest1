import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:mcsofttech/models/common_message_model.dart';
import '../../../constants/Constant.dart';
import '../../../models/login/login_model.dart';
import '../../../models/message_status_model.dart';
import '../dio_client.dart';

class ProfileApiServices extends DioClient {
  final client = DioClient.client;

  Future<CommonModel?> profileApi(
      {mobile,
      email,
      username,
      userType,
      address,
      userId,
      address1,
      address2,
      city,
      state,
      pincode}) async {
    late CommonModel? commonResponseModel;
    var inputData = {
      "mobile": mobile,
      "email": email,
      "name": username,
      "userType":userType,
      "id": userId,
      "address": {
        "address1": address1,
        "address2": address2,
        "city": city,
        "state": state,
        "country": "India",
        "pincode": pincode
      }
    };
    debugPrint('inputData: ${jsonEncode(inputData).toString()}');
    try {
      final response = await client.post(
        "${Constant.baseUrl}/saveUser",
        data: jsonEncode(inputData).toString(),
      );
      if (kDebugMode) {
        print('outPut: ${response.data}');
      }
      try {
        commonResponseModel = CommonModel.fromJson(response.data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return commonResponseModel;
  }

  Future<CommonResponseModel?> uploadImage(
      {fileContentBase64, fileName, userId}) async {
    late CommonResponseModel? commonResponseModel;
    var inputData = {
      "fileContentBase64": fileContentBase64,
      "fileName": fileName,
      "userId": userId
    };
    debugPrint('inputData: $inputData');
    try {
      final response = await client.post(
        "${Constant.baseUrl}/uploadImage",
        data: inputData,
      );
      if (kDebugMode) {
        print('outPut: ${response.data}');
      }
      try {
        commonResponseModel = CommonResponseModel.fromJson(response.data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return commonResponseModel;
  }

  Future<LoginModel?> getProfileApi({id}) async {
    var inputData = {"id": id};
    debugPrint('inputData: $inputData');
    LoginModel? loginModel;
    try {
      final response = await client.post(
        "${Constant.baseUrl}/getProfile",
        data: inputData,
      );
      if (kDebugMode) {
        print('inputData: $inputData');
        print('outPut: ${response.data}');
      }
      try {
        loginModel = LoginModel.fromJson(response.data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return loginModel;
  }
}
