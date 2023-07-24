import 'TrainingType.dart';

class TrainingModel {
  String message;
  int status;
  List<TrainingType> trainingType;

  TrainingModel(
      {required this.message,
      required this.status,
      required this.trainingType});

  factory TrainingModel.fromJson(Map<String, dynamic> json) {
    return TrainingModel(
      message: json['message'],
      status: json['status'],
      trainingType: json['trainingType'] != null
          ? (json['trainingType'] as List)
              .map((i) => TrainingType.fromJson(i))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['message'] = message;
    data['status'] = this.status;
    if (trainingType.isNotEmpty) {
      data['trainingType'] = trainingType.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
