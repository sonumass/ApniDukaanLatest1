import 'package:mcsofttech/models/home/AllProduct.dart';

import 'User_card_data.dart';

class UserDynamicDashboard {
  String message;
  String mereDukanLink;
  List<AllProduct> userProduct;
  List<UserCardData> cardData;
  int status;
  bool admin;

  UserDynamicDashboard(
      {required this.message,
      required this.status,
      this.admin=false,
      required this.mereDukanLink,
      required this.cardData,
      required this.userProduct});

  factory UserDynamicDashboard.fromJson(Map<String, dynamic> json) {
    return UserDynamicDashboard(
      message: json['message'] ?? "",
      status: json['status'] ?? 200,
      admin: json['admin'] ?? false,
      mereDukanLink: json['mereDukanLink'] ?? "",
      userProduct: json['userProduct'] != null
          ? (json['userProduct'] as List)
              .map((i) => AllProduct.fromJson(i))
              .toList()
          : [],
      cardData: json['data'] != null
          ? (json['data'] as List).map((i) => UserCardData.fromJson(i)).toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['admin'] = admin;
    data['mereDukanLink'] = mereDukanLink;
    if (userProduct.isNotEmpty) {
      data['userProduct'] = userProduct.map((v) => v.toJson()).toList();
    }
    if (cardData.isNotEmpty) {
      data['data'] = cardData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
