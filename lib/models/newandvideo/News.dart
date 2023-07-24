import 'Images.dart';

class News {
  News(
      {required this.id,
      required this.heading,
      required this.details,
      required this.videoLink,
      required this.tag,
      required this.catIds,
      required this.createDate,
      required this.images,
      required this.newsLink,
      required this.videoId});

  News.fromJson(dynamic json) {
    id = json['id'] ?? 0;
    heading = json['heading'] ?? "";
    details = json['details'] ?? "";
    videoLink = json['videoLink'] ?? "";
    tag = json['tag'] ?? "";
    catIds = json['cat_ids'] ?? 0;
    videoId = json['videoId'] ?? "";
    createDate = json['createDate'] ?? "";
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images.add(Images.fromJson(v));
      });
    }
  }

  int id = 0;
  String heading = "";
  String details = "";
  String videoLink = "";
  String tag = "";
  String catIds = "";
  String createDate = "";
  List<Images> images = [];
  String newsLink = "http://f2df.com";
  String videoId = "";

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['heading'] = heading;
    map['details'] = details;
    map['videoLink'] = videoLink;
    map['tag'] = tag;
    map['cat_ids'] = catIds;
    map['createDate'] = createDate;
    map['newsLink'] = newsLink;
    map['videoId'] = videoId;
    if (images.isNotEmpty) {
      map['images'] = images.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
