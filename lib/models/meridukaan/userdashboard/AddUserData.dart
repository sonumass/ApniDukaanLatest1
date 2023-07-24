//For add some wish ,cart enquiry and etc
class AddUserActionData {
  String productImg;
  String email;
  int id;
  String mobile;
  String price;
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

  AddUserActionData(
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
      required this.qunatity});

  Map toJson() => {
        'productImg': productImg,
        'email': email,
        'id': id,
        'mobile': mobile,
        'price': price,
        'productName': productName,
        'product_id': product_id,
        'product_user_id': product_user_id,
        'status': status,
        'subCategory': subCategory,
        'type': type,
        'updateDate': updateDate,
        'userName': userName,
        "user_id": user_id,
        'qunatity': qunatity
      };
}
