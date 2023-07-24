import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:mcsofttech/models/message_status_model.dart';
import '../../../constants/Constant.dart';
import '../../../models/banking/apply_insaurance.dart';
import '../../../models/login/login_input_model.dart';
import '../../../models/login/login_model.dart';
import '../dio_client.dart';

class BankingApiServices extends DioClient {
  final client = DioClient.client;

  Future<CommonModel?> applyInsuranceApi(
      {name, email,loanAmount,cropAmount, mobile, address, message}) async {
    String inputData = jsonEncode(ApplyInsauranceInput(
        name: name,
        email: email,
        loanAmount: loanAmount,
        cropAmount: cropAmount,
        phone: mobile,
        address: address,
        message: message));
    debugPrint('inputData: $inputData');
    CommonModel? commonModel;
    try {
      final response = await client.post(
        "${Constant.baseUrl}/home/saveInsurance",
        data: inputData,
      );
      if (kDebugMode) {
        print('inputData: $inputData');
        print('outPut: ${response.data}');
      }
      try {
        commonModel = CommonModel.fromJson(response.data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return commonModel;
  }

  Future<CommonModel?> applyLoanApi(
      {name, email, loanAmount,cropAmount,mobile, address, message}) async {
    String inputData = jsonEncode(ApplyInsauranceInput(
        name: name,
        email: email,
        cropAmount:cropAmount,
        loanAmount:loanAmount,
        phone: mobile,
        address: address,
        message: message));
    debugPrint('inputData: $inputData');
    CommonModel? commonModel;
    try {
      final response = await client.post(
        "${Constant.baseUrl}/home/saveLoan",
        data: inputData,
      );
      if (kDebugMode) {
        print('inputData: $inputData');
        print('outPut: ${response.data}');
      }
      try {
        commonModel = CommonModel.fromJson(response.data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return commonModel;
  }
}
