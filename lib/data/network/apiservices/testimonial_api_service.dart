import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:mcsofttech/models/testimonial/Tesiminial_model.dart';
import '../../../constants/Constant.dart';
import '../dio_client.dart';

class TestimonialApiServices extends DioClient {
  final client = DioClient.client;

  Future<TestimonialModel?> testimonialApi() async {

    TestimonialModel? testimonialModel;
    var inputData = {};
    debugPrint('inputData: $inputData');
    try {
      final response = await client.post(
        "${Constant.baseUrl}/home/testimonial",
        data: jsonEncode(inputData),
      );
      if (kDebugMode) {
        debugPrint('outPut: ${response.data}');

      }
      try {
        testimonialModel = TestimonialModel.fromJson(response.data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return testimonialModel;
  }
}
