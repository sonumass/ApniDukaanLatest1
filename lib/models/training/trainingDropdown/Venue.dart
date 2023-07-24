class Venue {
  String discriptions;
  int id;
  String name;
  bool status;
  String trainingDate;

  Venue(
      {required this.discriptions,
      required this.id,
      required this.name,
      required this.status,
      required this.trainingDate});

  factory Venue.fromJson(Map<String, dynamic> json) {
    return Venue(
      discriptions: json['discriptions'] ?? "",
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
      status: json['status'] ?? false,
      trainingDate: json['trainingDate'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['discriptions'] = discriptions;
    data['id'] = id;
    data['name'] = name;
    data['status'] = status;
    data['trainingDate'] = trainingDate;
    return data;
  }
}
