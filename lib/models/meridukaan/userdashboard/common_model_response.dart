class CommonModelResponse {
  String message;
  int status;

  CommonModelResponse({required this.message, required this.status});

  factory CommonModelResponse.fromJson(Map<String, dynamic> json) {
    return CommonModelResponse(
      message: json['message'] ?? "",
      status: json['status'] ?? 200,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    return data;
  }
}
