class Equiry {
  String productImg;
  String email;
  int id;
  String mobile;
  int price;
  String productName;
  int product_id;
  int product_user_id;
  String status;
  String subCategory;
  String type;
  String updateDate;
  String userName;
  int user_id;
  int qunatity;
  int actualPrice;

  Equiry(
      {required this.productImg,
      required this.email,
      required this.id,
      required this.mobile,
      required this.price,
      required this.productName,
      required this.product_id,
      required this.product_user_id,
      required this.status,
      required this.subCategory,
      required this.type,
      required this.updateDate,
      required this.userName,
      required this.user_id,
      required this.qunatity,
      required this.actualPrice});

  factory Equiry.fromJson(Map<String, dynamic> json) {
    return Equiry(
        productImg: json['productImg'] ?? "",
        email: json['email'] ?? "",
        id: json['id'] ?? 0,
        mobile: json['mobile'] ?? "",
        price: json['price'] ?? 0,
        productName: json['productName'] ?? "",
        product_id: json['product_id'] ?? 0,
        product_user_id: json['product_user_id'] ?? 0,
        status: json['status'] ?? 200,
        subCategory: json['subCategory'] ?? "",
        type: json['type'] ?? "",
        updateDate: json['updateDate'] ?? "",
        userName: json['userName'] ?? "",
        user_id: json['user_id'] ?? 0,
        qunatity: json['qunatity'] ?? 1,
        actualPrice: json['actualPrice'] ?? 0);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productImg'] = productImg;
    data['email'] = email;
    data['id'] = id;
    data['mobile'] = mobile;
    data['price'] = price;
    data['productName'] = productName;
    data['product_id'] = product_id;
    data['product_user_id'] = product_user_id;
    data['status'] = status;
    data['subCategory'] = subCategory;
    data['type'] = type;
    data['updateDate'] = updateDate;
    data['userName'] = userName;
    data['user_id'] = user_id;
    data['qunatity'] = qunatity;
    data['actualPrice'] = actualPrice;
    return data;
  }
}
