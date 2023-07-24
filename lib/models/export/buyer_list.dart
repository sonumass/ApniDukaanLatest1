class BuyerList {
  String createDate;
  String expectedDate;
  int id;
  String location;
  String name;
  String offerPrice;
  String phoneNumber;
  String productName;
  String quantity;
  String status;
  String updateDate;

  BuyerList(
      {required this.createDate,
      required this.expectedDate,
      required this.id,
      required this.location,
      required this.name,
      required this.offerPrice,
      required this.phoneNumber,
      required this.productName,
      required this.quantity,
      required this.status,
      required this.updateDate});

  factory BuyerList.fromJson(Map<String, dynamic> json) {
    return BuyerList(
      createDate: json['createDate'] ?? "",
      expectedDate: json['expectedDate'] ?? "",
      id: json['id'] ?? 0,
      location: json['location'] ?? "",
      name: json['name'] ?? "",
      offerPrice: json['offerPrice'] ?? "",
      phoneNumber: json['phoneNumber'] ?? "",
      productName: json['productName'] ?? "",
      quantity: json['quantity'] ?? "",
      status: json['status'] ?? "",
      updateDate: json['updateDate'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createDate'] = createDate;
    data['expectedDate'] = expectedDate;
    data['id'] = id;
    data['location'] = location;
    data['name'] = name;
    data['offerPrice'] = offerPrice;
    data['phoneNumber'] = phoneNumber;
    data['productName'] = productName;
    data['quantity'] = quantity;
    data['status'] = status;
    data['updateDate'] = updateDate;
    return data;
  }
}
