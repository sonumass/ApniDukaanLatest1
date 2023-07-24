import 'Equiry.dart';

class UserDashboardCardDataModel {
  int totalPrice;
  List<Equiry> equiryList;
  String message;
  int status;

  UserDashboardCardDataModel(
      {required this.equiryList,
      required this.message,
      required this.status,
      required this.totalPrice});

  factory UserDashboardCardDataModel.fromJson(Map<String, dynamic> json) {
    return UserDashboardCardDataModel(
        equiryList: json['equiryList'] != null
            ? (json['equiryList'] as List)
                .map((i) => Equiry.fromJson(i))
                .toList()
            : [],
        message: json['message'] ?? "",
        status: json['status'] ?? 200,
        totalPrice: json['totalPrice'] ?? 0);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    data['equiryList'] = equiryList.map((v) => v.toJson()).toList();
    data['totalPrice'] = totalPrice;
    return data;
  }
}
