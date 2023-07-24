class BannerList {
  BannerList({
      required this.id,
    required this.name,
    required this.img,
    required this.home,
    required this.catId,
    required this.subCatId,
    required this.userId,
    required this.status,
    required this.link,});

  BannerList.fromJson(dynamic json) {
    id = json['id']??0;
    name = json['name']??"";
    img = json['img']??"";
    home = json['home']??"";
    catId = json['catId']??"";
    subCatId = json['subCatId']??"";
    userId = json['userId']??"";
    status = json['status']??"";
    link = json['link']??"";
  }
  int id=0;
  String name="";
  String img="";
  String home="";
  int catId=0;
  int subCatId=0;
  int userId=0;
  String status="";
  String  link="";

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['img'] = img;
    map['home'] = home;
    map['catId'] = catId;
    map['subCatId'] = subCatId;
    map['userId'] = userId;
    map['status'] = status;
    map['link'] = link;
    return map;
  }

}