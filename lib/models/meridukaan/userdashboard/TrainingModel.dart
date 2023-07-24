import 'package:mcsofttech/models/meridukaan/userdashboard/training_data.dart';

class TrainingModel {
  List<TrainingData> attendedTrainingList;
  String message;
  int status;

  TrainingModel(
      {required this.attendedTrainingList,
      required this.message,
      required this.status});

  factory TrainingModel.fromJson(Map<String, dynamic> json) {
    return TrainingModel(
      attendedTrainingList: json['attendedTrainingList'] != null
          ? (json['attendedTrainingList'] as List)
              .map((i) => TrainingData.fromJson(i))
              .toList()
          : [],
      message: json['message'] ?? "",
      status: json['status'] ?? 200,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    data['attendedTrainingList'] =
        attendedTrainingList.map((v) => v.toJson()).toList();
    return data;
  }
}
