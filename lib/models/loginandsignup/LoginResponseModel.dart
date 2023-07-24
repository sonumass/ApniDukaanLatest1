import 'Data.dart';

class LoginResponseModel {
  Data? data;
  String message;
  bool status;
  String token;

  LoginResponseModel(
      {required this.data,
      required this.message,
      required this.status,
      required this.token});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
      message: json['message'] ?? "Server error",
      status: json['status'] ?? false,
      token: json['token'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['message'] = message;
    data['status'] = status;
    data['token'] = token;
    data['data'] = this.data?.toJson();
    return data;
  }
}
