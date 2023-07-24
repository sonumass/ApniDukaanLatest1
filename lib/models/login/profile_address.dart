import 'LoginAddress.dart';

class ProfileAddress {
  LoginAddress? address;

  ProfileAddress({this.address});

  factory ProfileAddress.fromJson(Map<String, dynamic> json) {
    return ProfileAddress(
      address: json['address'] != null
          ? LoginAddress.fromJson(json['address'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    final address = this.address;
    if (address != null) {
      data['address'] = address.toJson();
    }
    return data;
  }
}
