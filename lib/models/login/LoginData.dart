import 'package:mcsofttech/models/login/LoginAddress.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class LoginData {
  String createDate;
  String email = "";
  String gender;
  String googleId;
  int id = 0;
  String img;
  int mobile;
  String name;
  String reffralCode;
  int otp;
  String password;
  String role;
  bool userExist;
  LoginAddress? address;
  bool status;
  String updateDate;
  String userType;

  LoginData(
      {required this.address,
      required this.createDate,
      required this.email,
      required this.gender,
      required this.googleId,
      required this.id,
      required this.img,
      required this.mobile,
      required this.name,
      required this.reffralCode,
      required this.otp,
      required this.password,
      required this.role,
      required this.userExist,
      required this.status,
      required this.updateDate,this.userType="FPO"});

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      address: json['address'] != null
          ? LoginAddress?.fromJson(json['address'])
          : null,
      createDate: json['createDate'] ?? "",
      userType:json['userType'] ?? "FPO",
      email: json['email'] ?? "",
      gender: json['gender'] ?? "",
      googleId: json['googleId'] ?? "",
      id: json['id'] ?? 0,
      img: json['img'] ?? "",
      mobile: json['mobile'] ?? 0,
      name: json['name'] ?? "",
      reffralCode: json['reffralCode'] ?? "",
      otp: json['otp'] ?? "",
      password: json['password'] ?? "",
      role: json['role'] ?? "",
      status: json['status'] ?? "",
      userExist: json['userExist'] ?? false,
      updateDate: json['updateDate'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['mobile'] = mobile;
    data['otp'] = otp;
    data['status'] = status;
    data['address'] = address?.toJson();
    data['createDate'] = createDate;
    data['email'] = email;
    data['gender'] = gender;
    data['googleId'] = googleId;
    data['userType'] = userType;
    data['img'] = img;
    data['name'] = name;
    data['reffralCode'] = reffralCode;
    data['password'] = password;
    data['role'] = role;
    data['userExist'] = userExist;
    data['updateDate'] = updateDate;

    return data;
  }
}
