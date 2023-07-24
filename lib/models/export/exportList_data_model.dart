import 'buyer_list.dart';

class ExportListDataModel {
  List<BuyerList> buyerList;
  String message;
  int status;

  ExportListDataModel(
      {required this.buyerList, required this.message, required this.status});

  factory ExportListDataModel.fromJson(Map<String, dynamic> json) {
    return ExportListDataModel(
      buyerList: json['buyerList'] != null
          ? (json['buyerList'] as List)
              .map((i) => BuyerList.fromJson(i))
              .toList()
          : [],
      message: json['message'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    data['equiryList'] = buyerList.map((v) => v.toJson()).toList();
    return data;
  }
}
