import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:mcsofttech/models/message_status_model.dart';
import 'package:mcsofttech/models/training/events_model.dart';
import 'package:mcsofttech/models/training/trainingDropdown/training_model.dart';
import '../../../constants/Constant.dart';
import '../../../models/banking/apply_insaurance.dart';
import '../../../models/login/login_input_model.dart';
import '../../../models/login/login_model.dart';
import '../../../models/training/apply_training_input.dart';
import '../dio_client.dart';

class TrainingApiServices extends DioClient {
  final client = DioClient.client;

  Future<CommonModel?> applyTrainingApi({
    id,
    name,
    email,
    phone,
    discription,
    trainingType,
    trainingMode,
    trainingVenue,
    trainingDate,
  }) async {
    String inputData = jsonEncode(ApplyTrainingInput(
        id: id,
        name: name,
        email: email,
        phone: phone,
        discription: discription,
        trainingType: trainingType,
        trainingMode: trainingMode,
        trainingVenue: trainingVenue,
        trainingDate: trainingDate));
    debugPrint('inputData: $inputData');
    CommonModel? commonModel;
    try {
      final response = await client.post(
        "${Constant.baseUrl}/home/saveTraining",
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

  Future<TrainingModel?> applyTrainingDropDownApi() async {
    String inputData = jsonEncode({});
    debugPrint('inputData: $inputData');
    TrainingModel? trainingModel;
    try {
      final response = await client.post(
        "${Constant.baseUrl}/home/trainingType",
        data: inputData,
      );
      if (kDebugMode) {
        print('inputData: $inputData');
        print('outPut: ${response.data}');
      }
      try {
        trainingModel = TrainingModel.fromJson(response.data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return trainingModel;
  }
  Future<EventsModel?> eventApi() async {
    String inputData = jsonEncode({});
    debugPrint('inputData: $inputData');
    EventsModel? eventsModel;
    try {
      final response = await client.post(
        "${Constant.baseUrl}/event/getSuccessfulEvents",
        data: inputData,
      );
      if (kDebugMode) {
        print('inputData: $inputData');
        print('outPut: ${response.data}');
      }
      try {
        eventsModel = EventsModel.fromJson(response.data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return eventsModel;
  }
}
