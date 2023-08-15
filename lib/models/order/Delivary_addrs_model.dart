class DelivaryAddrsModel {
  DelivaryAddrsModel({
      this.id, 
      this.name, 
      this.mobile, 
      this.houseNo, 
      this.street, 
      this.area, 
      this.landmark, 
      this.state, 
      this.city, 
      this.country, 
      this.pincode, 
      this.userId, 
      this.type,
      this.isSelected});

  DelivaryAddrsModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    houseNo = json['houseNo'];
    street = json['street'];
    area = json['area'];
    landmark = json['landmark'];
    state = json['state'];
    city = json['city'];
    country = json['country'];
    pincode = json['pincode'];
    userId = json['userId'];
    type = json['type'];
    isSelected =json['selected'];
  }
  int? id;
  String? name;
  String? mobile;
  String? houseNo;
  String? street;
  String? area;
  String? landmark;
  String? state;
  String? city;
  String? country;
  String? pincode;
  int? userId;
  String? type;
  bool? isSelected;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['mobile'] = mobile;
    map['houseNo'] = houseNo;
    map['street'] = street;
    map['area'] = area;
    map['landmark'] = landmark;
    map['state'] = state;
    map['city'] = city;
    map['country'] = country;
    map['pincode'] = pincode;
    map['userId'] = userId;
    map['type'] = type;
    map['selected'] =isSelected??true;
    return map;
  }
  String get getAddrs { return "$houseNo,$street,$area,$landmark,$city,$street";}

  String get getPlaceAt {
    switch(type){
      case "1":
        return "Home";
      case "2":
        return "Office";
      case "3":
        return "Work";
      default:
        "Home";

    }
    return "Home";}

}