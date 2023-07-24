class Data {
  String email;
  String id;
  String image;
  String name;
  String token;

  Data(
      {required this.email,
      required this.id,
      required this.image,
      required this.name,
      required this.token});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      email: json['email'] ?? "",
      id: json['id'] ?? "",
      image: json['image'] ?? "",
      name: json['name'] ?? "",
      token: json['token'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['email'] = email;
    data['id'] = id;
    data['image'] = image;
    data['name'] = name;
    data['token'] = token;
    return data;
  }
}
