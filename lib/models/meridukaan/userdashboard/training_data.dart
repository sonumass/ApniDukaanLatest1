class TrainingData {
  String certificate;
  int id;
  String status;
  String trainingName;
  int training_id;
  String updateDate;
  int user_id;
  String venue;

  TrainingData(
      {required this.certificate,
      required this.id,
      required this.status,
      required this.trainingName,
      required this.training_id,
      required this.updateDate,
      required this.user_id,
      required this.venue});

  factory TrainingData.fromJson(Map<String, dynamic> json) {
    return TrainingData(
      certificate: json['certificate'] ?? "--",
      id: json['id'] ?? 0,
      status: json['status'] ?? "",
      trainingName: json['trainingName'] ?? "",
      training_id: json['training_id'] ?? 0,
      updateDate: json['updateDate'] ?? "",
      user_id: json['user_id'] ?? 0,
      venue: json['venue'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['certificate'] = certificate;
    data['id'] = id;
    data['status'] = status;
    data['trainingName'] = trainingName;
    data['training_id'] = training_id;
    data['updateDate'] = updateDate;
    data['user_id'] = user_id;
    data['venue'] = venue;
    return data;
  }
}
