import 'package:mcsofttech/models/home/banner.dart';
import 'package:mcsofttech/models/testimonial/Testimonial.dart';


class TestimonialModel {
  List<Testimonial>? testimonial;
  List<BannerData>? bannerList;
  String message;
  int status;

  TestimonialModel(
      {required this.testimonial,
        required this.bannerList,
        required this.message,
        required this.status});

  factory TestimonialModel.fromJson(Map<String, dynamic> json) {
    return TestimonialModel(
      testimonial: json['testimonial'] != null
          ? (json['testimonial'] as List)
          .map((i) => Testimonial.fromJson(i))
          .toList()
          : null,
      bannerList: json['bannerList'] != null
          ? (json['bannerList'] as List)
          .map((i) => BannerData.fromJson(i))
          .toList()
          : null,
      message: json['message']??"",

      status: json['status']??203,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    if (testimonial != null) {
      data['testimonial'] = testimonial?.map((v) => v.toJson()).toList();
    }
    if (bannerList != null) {
      data['bannerList'] = bannerList?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
