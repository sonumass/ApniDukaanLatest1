class ProfileInputModel {
  String mobile;
  String email;
  String name;
  String id;
  AddressInputModel address;

  ProfileInputModel(
      {required this.mobile,
      required this.email,
      required this.name,
      required this.id,required  this.address});

  Map toJson() => {'mobile': mobile, 'email': email, 'name': name, 'id': id,'address':address};
}

class AddressInputModel {
  String address1;
  String address2;

  String city;
  String country;
  String pincode;

  AddressInputModel(
      {required this.address1,
      required this.address2,
      required this.city,
      required this.country,
      required this.pincode});

  Map toJson() => {
        'address1': address1,
        'address2': address2,
        'city': city,
        'country': country,
        'pincode': pincode
      };
}
