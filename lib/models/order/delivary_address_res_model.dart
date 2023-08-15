import 'Delivary_addrs_model.dart';

class DelivaryAddsResModel {
  String message = "";
  int status;
  List<DelivaryAddrsModel>? listData;

  DelivaryAddsResModel({required this.listData,required this.message, required this.status});

  factory DelivaryAddsResModel.fromJson(Map<String, dynamic> json) {
    return DelivaryAddsResModel(
      listData: json['data'] != null
          ? (json['data'] as List)
          .map((i) => DelivaryAddrsModel.fromJson(i))
          .toList()
          : [],
      message: json['message'] ?? "",
      status: json['status'] ?? 404,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    return data;
  }
}
