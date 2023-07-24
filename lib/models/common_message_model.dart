class CommonResponseModel {
  String message = "";
  String data = "";
  int totalPrice;
  int status;

  CommonResponseModel(
      {required this.message,
      required this.status,
      required this.data,
      required this.totalPrice});

  factory CommonResponseModel.fromJson(Map<String, dynamic> json) {
    return CommonResponseModel(
        message: json['message'] ?? "",
        data: json['data'] ?? "",
        status: json['status'] ?? 404,
        totalPrice: json['totalPrice'] ?? 0);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['data'] = data;
    data['status'] = status;
    data['totalPrice'] = totalPrice;
    return data;
  }
}
