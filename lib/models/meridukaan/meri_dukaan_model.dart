import 'DukanDetails.dart';

class MeriDukaanModel {
  DukanDetails? dukanDetails;
  List<String> gallaryList;
  String message;
  int reviewCount;
  String status;

  MeriDukaanModel(
      {required this.dukanDetails,
      required this.gallaryList,
      required this.message,
      required this.reviewCount,
      required this.status});

  factory MeriDukaanModel.fromJson(Map<String, dynamic> json) {
    return MeriDukaanModel(
      dukanDetails: json['dukanDetails'] != null
          ? DukanDetails.fromJson(json['dukanDetails'])
          : null,
      gallaryList: json['gallaryList'] != null
          ? List<String>.from(json['gallaryList'])
          : [],
      message: json['message'],
      reviewCount: json['reviewCount'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = message;
    data['reviewCount'] = reviewCount;
    data['status'] = status;
    data['dukanDetails'] = dukanDetails?.toJson();
    data['gallaryList'] = this.gallaryList;
    return data;
  }
}
