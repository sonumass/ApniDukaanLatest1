import 'Venue.dart';

class TrainingType {
  String discriptions;
  int id;
  String name;
  bool status;

  List<Venue> venue;

  TrainingType(
      {required this.discriptions,
      required this.id,
      required this.name,
      required this.status,
      required this.venue});

  factory TrainingType.fromJson(Map<String, dynamic> json) {
    return TrainingType(
      discriptions: json['discriptions'] ?? "",
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
      status: json['status'] ?? false,
      venue: json['venue'] != null
          ? (json['venue'] as List).map((i) => Venue.fromJson(i)).toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['discriptions'] = discriptions;
    data['id'] = id;
    data['name'] = name;
    data['status'] = status;

    if (venue.isNotEmpty) {
      data['venue'] = venue.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
