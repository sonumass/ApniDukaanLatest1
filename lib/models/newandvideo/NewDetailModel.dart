import 'BannerList.dart';
import 'News.dart';

class NewDetailModel {
  NewDetailModel({
    required this.news,
    required this.bannerList,
    required this.newsCount,
    required this.message,
    required this.status,
  });

  NewDetailModel.fromJson(dynamic json) {
    if (json['news'] != null) {
      news = [];
      json['news'].forEach((v) {
        news.add(News.fromJson(v));
      });
    }
    if (json['bannerList'] != null) {
      bannerList = [];
      json['bannerList'].forEach((v) {
        bannerList.add(BannerList.fromJson(v));
      });
    }
    newsCount = json['newsCount'];
    message = json['message'];
    status = json['status'];
  }

  List<News> news =[];
  List<BannerList> bannerList=[];
  int newsCount=0;
  String message="";
  int status=0;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['news'] = news.map((v) => v.toJson()).toList();
    if (bannerList.isNotEmpty) {
      map['bannerList'] = bannerList.map((v) => v.toJson()).toList();
    }
    map['newsCount'] = newsCount;
    map['message'] = message;
    map['status'] = status;
    return map;
  }
}
