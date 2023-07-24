import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../../../constants/Constant.dart';
import '../../../models/login/login_input_model.dart';
import '../../../models/login/login_model.dart';
import '../../../models/newandvideo/NewDetailModel.dart';
import '../dio_client.dart';

class NewsApiServices extends DioClient {
  final client = DioClient.client;

  Future<NewDetailModel?> newsApi(int pageNo, int size,String type) async {

    String inputData = jsonEncode({"pageNo":pageNo,"size":size,"type":"news"});
    debugPrint('inputData: $inputData');
    NewDetailModel? newDetailModel;
    try {
      final response = await client.post(
        "${Constant.baseUrl}/news/getAllNews",
        data: inputData,
      );
      if (kDebugMode) {
        print('inputData: $inputData');
        print('outPut: ${response.data}');
      }
      try {
        newDetailModel = NewDetailModel.fromJson(response.data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return newDetailModel;
  }
  Future<NewDetailModel?> videoApi(int pageNo, int size,String type) async {

    String inputData = jsonEncode({"pageNo":pageNo,"size":size,"type":"Video"});
    debugPrint('inputData: $inputData');
    NewDetailModel? newDetailModel;
    try {
      final response = await client.post(
        "${Constant.baseUrl}/news/getAllVideoNews",
        data: inputData,
      );
      if (kDebugMode) {
        print('inputData: $inputData');
        print('outPut: ${response.data}');
      }
      try {
        newDetailModel = NewDetailModel.fromJson(response.data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return newDetailModel;
  }


}
