import 'LoginData.dart';

class LoginModel {
  LoginData? loginData;
  String message;
  int status;

  LoginModel({this.loginData, required this.message, required this.status});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      loginData: json['data'] != null ? LoginData.fromJson(json['data']) : null,
      message: json['message'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    if (loginData != null) {
      data['data'] = loginData?.toJson();
    }
    return data;
  }
}
