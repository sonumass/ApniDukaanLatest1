import 'EquiryList.dart';

class EnquiryModelData {
  EnquiryModelData(
      {required this.equiryList, required this.message, required this.status});

  EnquiryModelData.fromJson(dynamic json) {
    message = json['message'] ?? "";
    status = json['status'] ?? 200;
    if (json['equiryList'] != null) {
      equiryList = [];
      json['equiryList'].forEach((v) {
        equiryList.add(EquiryList.fromJson(v));
      });
    }
  }

  List<EquiryList> equiryList = [];
  String message = "";
  int status = 200;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (equiryList != null) {
      map['equiryList'] = equiryList.map((v) => v.toJson()).toList();
    }
    map['status'] = status;
    map['message'] = message;
    return map;
  }
}
