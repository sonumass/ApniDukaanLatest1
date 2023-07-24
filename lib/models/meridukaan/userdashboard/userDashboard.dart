import 'package:mcsofttech/models/home/AllProduct.dart';

class UserDashboard {
  int addExpiry;
  String enquiryList;
  String message;
  int messageCount;
  int totalNumbersOdAdd;
  int status;
  int totalActiveLead;
  int totalEnquiry;
  int totalInterested;
  int totalOrder;
  int totalTrainingAttended;
  int totalUnseenEnquiry;
  int totalValueOfOrderRecieved;
  String mereDukanLink;
  List<AllProduct> userProduct;

  UserDashboard(
      {required this.addExpiry,
      required this.enquiryList,
      required this.message,
      required this.messageCount,
      required this.totalNumbersOdAdd,
      required this.status,
      required this.totalActiveLead,
      required this.totalEnquiry,
      required this.totalInterested,
      required this.totalOrder,
      required this.totalTrainingAttended,
      required this.totalUnseenEnquiry,
      required this.totalValueOfOrderRecieved,
      required this.mereDukanLink,
      required this.userProduct});

  factory UserDashboard.fromJson(Map<String, dynamic> json) {
    return UserDashboard(
      addExpiry: json['addExpiry'] ?? 0,
      enquiryList: json['enquiryList'] ?? "0",
      message: json['message'],
      messageCount: json['messageCount'] ?? 0,
      totalNumbersOdAdd: json['totalNumbersOdAdd'] ?? 0,
      status: json['status'],
      totalActiveLead: json['totalActiveLead'] ?? 0,
      totalEnquiry: json['totalEnquiry'] ?? 0,
      totalInterested: json['totalInterested'] ?? 0,
      totalOrder: json['totalOrder'] ?? 0,
      totalTrainingAttended: json['totalTrainingAttended'] ?? 0,
      totalUnseenEnquiry: json['totalUnseenEnquiry'] ?? 0,
      totalValueOfOrderRecieved: json['totalValueOfOrderRecieved'] ?? 0,
      mereDukanLink: json['mereDukanLink'] ?? "",
      userProduct: json['userProduct'] != null
          ? (json['userProduct'] as List)
              .map((i) => AllProduct.fromJson(i))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['addExpiry'] = addExpiry;
    data['enquiryList'] = enquiryList;
    data['message'] = message;
    data['messageCount'] = messageCount;
    data['totalNumbersOdAdd'] = totalNumbersOdAdd;
    data['status'] = status;
    data['totalActiveLead'] = totalActiveLead;
    data['totalEnquiry'] = totalEnquiry;
    data['totalInterested'] = totalInterested;
    data['totalOrder'] = totalOrder;
    data['totalTrainingAttended'] = totalTrainingAttended;
    data['totalUnseenEnquiry'] = totalUnseenEnquiry;
    data['totalValueOfOrderRecieved'] = totalValueOfOrderRecieved;
    data['mereDukanLink'] = mereDukanLink;
    if (userProduct.isNotEmpty) {
      data['userProduct'] = userProduct.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
