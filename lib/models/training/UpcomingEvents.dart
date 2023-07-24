import 'Images.dart';

class UpcomingEvents {
  UpcomingEvents({
      required this.id,
      required this.heading,
      required this.location,
      required this.content,
      required this.date,
      required this.createDate,
      required this.images,});

  UpcomingEvents.fromJson(dynamic json) {
    id = json['id']??0;
    heading = json['heading']??"";
    location = json['location']??"";
    content = json['content']??"";
    date = json['date']??"";
    createDate = json['createDate']??"";
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images.add(Images.fromJson(v));
      });
    }

  }
  int id=0;
  String heading="";
  String location="";
  String content="";
  String date="";
  String createDate="";
  List<Images> images=[];

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['heading'] = heading;
    map['location'] = location;
    map['content'] = content;
    map['date'] = date;
    map['createDate'] = createDate;
    map['images'] = images.map((v) => v.toJson()).toList();
    return map;
  }

}