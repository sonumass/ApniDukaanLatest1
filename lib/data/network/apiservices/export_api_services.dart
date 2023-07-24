import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:mcsofttech/models/common_message_model.dart';
import '../../../constants/Constant.dart';
import '../../../models/export/add_requirenment_input_model.dart';
import '../../../models/export/buyer/ExportBuyer.dart';
import '../../../models/export/exportList_data_model.dart';
import '../../../models/export/exportList_seller_data_model.dart';
import '../../../models/login/login_input_model.dart';
import '../../../models/login/login_model.dart';
import '../dio_client.dart';

class ExportApiServices extends DioClient {
  final client = DioClient.client;

  Future<ExportBuyer?> buyerRequirementApi() async {
    ExportBuyer? data;
    try {
      final response = await client.post(
        "${Constant.baseUrl}/home/getExportQuantity",
        data: jsonEncode({}),
      );
      if (kDebugMode) {
        print('outPut: ${response.data}');
      }
      try {
        data = ExportBuyer.fromJson(response.data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return data;
  }

  Future<ExportListSellerDataModel?> sellerListApi() async {
    ExportListSellerDataModel? data;
    try {
      final response = await client.post(
        "${Constant.baseUrl}/getSellerList",
        data: jsonEncode({}),
      );
      if (kDebugMode) {
        print('outPut: ${response.data}');
      }
      try {
        data = ExportListSellerDataModel.fromJson(response.data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return data;
  }

  Future<CommonResponseModel?> addRequirementApi(
      String show,
      String productName,
      String name,
      String phoneNumber,
      String location,
      String offerPrice,
      String quantity,
      String expectedDate) async {
    String inputData = jsonEncode(AddRequirementInputModel(
        show: show,
        productName: productName,
        name: name,
        phoneNumber: phoneNumber,
        location: location,
        offerPrice: offerPrice,
        quantity: quantity,
        expectedDate: expectedDate));

    debugPrint('inputData: $inputData');
    CommonResponseModel? data;
    try {
      final response = await client.post(
        "${Constant.baseUrl}/addSellerReq",
        data: inputData,
      );
      if (kDebugMode) {
        print('inputData: $inputData');
        print('outPut: ${response.data}');
      }
      try {
        data = CommonResponseModel.fromJson(response.data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return data;
  }

  Future<CommonResponseModel?> addSellerApi(
      String show,
      String productName,
      String name,
      String phoneNumber,
      String location,
      String offerPrice,
      String quantity,
      String expectedDate) async {
    String inputData = jsonEncode(AddRequirementInputModel(
        show: show,
        productName: productName,
        name: name,
        phoneNumber: phoneNumber,
        location: location,
        offerPrice: offerPrice,
        quantity: quantity,
        expectedDate: expectedDate));

    debugPrint('inputData: $inputData');
    CommonResponseModel? data;
    try {
      final response = await client.post(
        "${Constant.baseUrl}/buyerAvailablityAdd",
        data: inputData,
      );
      if (kDebugMode) {
        print('inputData: $inputData');
        print('outPut: ${response.data}');
      }
      try {
        data = CommonResponseModel.fromJson(response.data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return data;
  }
}
