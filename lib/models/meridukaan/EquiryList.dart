class EquiryList {
  EquiryList({
      required this.id,
      required this.userId,
      required this.userName,
      required this.email,
      required this.mobile,
      required this.productName,
      required this.productImg,
      required this.price,
      required this.actualPrice,
      required this.qunatity,
      required this.subCategory,
      required this.productId,
      required this.productUserId,
      required this.type,
      required this.createDate,
      required this.updateDate,
      required this.orderId,
      required this.orderStatus,
      required this.status,});

  EquiryList.fromJson(dynamic json) {
    id = json['id']??0;
    userId = json['user_id']??1;
    userName = json['userName']??"";
    email = json['email']??"";
    mobile = json['mobile']??"";
    productName = json['productName']??"";
    productImg = json['productImg']??"";
    price = json['price']??0;
    actualPrice = json['actualPrice']??0;
    qunatity = json['qunatity']??0;
    subCategory = json['subCategory']??"";
    productId = json['product_id']??0;
    productUserId = json['product_user_id']??0;
    type = json['type']??"";
    createDate = json['createDate']??"";
    updateDate = json['updateDate']??"";
    orderId = json['orderId']??"";
    orderStatus = json['orderStatus']??false;
    status = json['status']??"false";
  }
  int id=0;
  int userId=0;
  String userName="";
  String email="";
  String mobile="";
  String productName="";
  String productImg="";
  int price=0;
  int actualPrice=0;
  int qunatity=0;
  String subCategory="";
  int productId=0;
  int productUserId=0;
  String type="";
  String createDate="";
  String updateDate="";
  String orderId="";
  bool orderStatus=false;
  String status="";

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['userName'] = userName;
    map['email'] = email;
    map['mobile'] = mobile;
    map['productName'] = productName;
    map['productImg'] = productImg;
    map['price'] = price;
    map['actualPrice'] = actualPrice;
    map['qunatity'] = qunatity;
    map['subCategory'] = subCategory;
    map['product_id'] = productId;
    map['product_user_id'] = productUserId;
    map['type'] = type;
    map['createDate'] = createDate;
    map['updateDate'] = updateDate;
    map['orderId'] = orderId;
    map['orderStatus'] = orderStatus;
    map['status'] = status;
    return map;
  }

}