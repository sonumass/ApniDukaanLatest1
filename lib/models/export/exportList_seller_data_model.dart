import 'buyer_list.dart';

class ExportListSellerDataModel {
  List<BuyerList> sellerList;
  String message;
  int status;

  ExportListSellerDataModel(
      {required this.sellerList, required this.message, required this.status});

  factory ExportListSellerDataModel.fromJson(Map<String, dynamic> json) {
    return ExportListSellerDataModel(
      sellerList: json['sellerList'] != null
          ? (json['sellerList'] as List)
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
    data['sellerList'] = sellerList.map((v) => v.toJson()).toList();
    return data;
  }
}
