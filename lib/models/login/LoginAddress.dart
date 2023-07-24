class LoginAddress {
  String address1;
  String address2;
  String city;
  String country;
  int id;
  String pincode;
  String state;
  int userId;

  LoginAddress(
      {required this.address1,
      required this.address2,
      required this.city,
      required this.country,
      required this.id,
      required this.pincode,
      required this.state,
      required this.userId});

  factory LoginAddress.fromJson(Map<String, dynamic> json) {
    return LoginAddress(
      address1: json['address1'] ?? "",
      address2: json['address2'] ?? "",
      city: json['city'] ?? "",
      country: json['country'] ?? "",
      id: json['id'],
      pincode: json['pincode'] ?? "",
      state: json['state'] ?? "",
      userId: json['userId'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;

    data['address1'] = address1;

    data['address2'] = address2;

    data['city'] = city;

    data['country'] = country;

    data['pincode'] = pincode;

    data['state'] = state;

    return data;
  }
}
