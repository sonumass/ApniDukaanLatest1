import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:mcsofttech/models/message_status_model.dart';
import 'package:mcsofttech/models/order/delivary_address_res_model.dart';
import '../../../constants/Constant.dart';
import '../dio_client.dart';

class CartApiServices extends DioClient {
  final client = DioClient.client;

  Future<CommonModel?> createDeliveryAddress({name, mobile, houseNo, street, area, landmark, state, city, country = "India", pincode, userId, type}) async {
    final inputData = {"name": name, "mobile": mobile, "houseNo": houseNo, "street": street,
      "area": area, "landmark": landmark, "state": state,
      "city": city, "country": "India", "pincode": pincode, "userId": userId, "type": type};
    debugPrint('inputData: $inputData');
    CommonModel? dataList;
    try {
      final response = await client.post(
        "${Constant.baseUrl}/addDeliveryAddress",
        data: jsonEncode(inputData),
      );
      if (kDebugMode) {
        print('inputData: $inputData');
        print('outPut: ${response.data}');
      }
      try {
        dataList = CommonModel.fromJson(response.data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return dataList;
  }

  Future<DelivaryAddsResModel?> getDelivaryAddrs({userId}) async {
    final inputData = { "userId":userId};
    debugPrint('inputData: $inputData');
    DelivaryAddsResModel? dataList;
    try {
      final response = await client.post(
        "${Constant.baseUrl}/getDeliveryAddress",
        data: jsonEncode(inputData),
      );
      if (kDebugMode) {
        print('inputData: $inputData');
        print('outPut: ${response.data}');
      }
      try {
        dataList = DelivaryAddsResModel.fromJson(response.data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return dataList;
  }
  Future<CommonModel?> setDelivaryAdds({userId,id}) async {
    final inputData = {"userId":userId,"id":id};
    debugPrint('inputData: $inputData');
    CommonModel? dataList;
    try {
      final response = await client.post(
        "${Constant.baseUrl}/setDelivaryAddrs",
        data: jsonEncode(inputData),
      );
      if (kDebugMode) {
        print('inputData: $inputData');
        print('outPut: ${response.data}');
      }
      try {
        dataList = CommonModel.fromJson(response.data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return dataList;
  }
  Future<CommonModel?> setDeliveryAddress({id,name, mobile, houseNo, street, area, landmark, state, city, country = "India", pincode, userId, type}) async {
    final inputData = {"name": name, "mobile": mobile, "houseNo": houseNo, "street": street,
      "area": area, "landmark": landmark, "state": state,
      "city": city, "country": "India", "pincode": pincode, "userId": userId, "type": type,"id":id,"selected":true};
    debugPrint('inputData: $inputData');
    CommonModel? dataList;
    try {
      final response = await client.post(
        "${Constant.baseUrl}/addDeliveryAddress",
        data: jsonEncode(inputData),
      );
      if (kDebugMode) {
        print('inputData: $inputData');
        print('outPut: ${response.data}');
      }
      try {
        dataList = CommonModel.fromJson(response.data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return dataList;
  }
}
