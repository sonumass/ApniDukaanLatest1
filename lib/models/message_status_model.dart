class CommonModel {
  String message = "";

  int status;

  CommonModel({required this.message, required this.status});

  factory CommonModel.fromJson(Map<String, dynamic> json) {
    return CommonModel(
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
