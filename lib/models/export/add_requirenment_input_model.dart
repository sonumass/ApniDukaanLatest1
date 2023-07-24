import 'dart:core';

class AddRequirementInputModel {
  String productName;
  String name;
  String phoneNumber;
  String location;
  String offerPrice;
  String quantity;
  String expectedDate;
  String show;

  AddRequirementInputModel(
      {required this.show,
      required this.productName,
      required this.name,
      required this.phoneNumber,
      required this.location,
      required this.offerPrice,
      required this.quantity,
      required this.expectedDate});

  Map toJson() => {
        'show': show,
        'productName': productName,
        'name': name,
        'phoneNumber': phoneNumber,
        'location': location,
        'offerPrice': offerPrice,
        'quantity': quantity,
        'expectedDate': expectedDate
      };
}
