import 'package:dio/dio.dart';

import 'logging.dart';

class DioClient {
  DioClient();

  static final Dio client = Dio(
    BaseOptions(
      baseUrl: 'https://reqres.in/api',
      connectTimeout: 300000,
      receiveTimeout: 300000,
    ),
  )..interceptors.add(Logging());
/*
  Future<UserInfo?> createUser({required UserInfo userInfo}) async {
    UserInfo? retrievedUser;

    try {
      Response response = await _dio.post(
        '/users',
        data: userInfo.toJson(),
      );

      print('User created: ${response.data}');

      retrievedUser = UserInfo.fromJson(response.data);
    } catch (e) {
      print('Error creating user: $e');
    }

    return retrievedUser;
  }*/

}
