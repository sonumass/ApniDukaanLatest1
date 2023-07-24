class CheckCompanyLinkModel {
  int data;
  String message;
  int status;

  CheckCompanyLinkModel(
      {required this.data, required this.message, required this.status});

  factory CheckCompanyLinkModel.fromJson(Map<String, dynamic> json) {
    return CheckCompanyLinkModel(
      data: json['data'] ?? 1,
      message: json['message'] ?? "",
      status: json['status'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = data;
    data['message'] = message;
    data['status'] = status;
    return data;
  }
}
