class BannerData {
  int bannerId;
  String img;
  String urlLink;

  BannerData({required this.bannerId, required this.img,this.urlLink=""});

  factory BannerData.fromJson(Map<String, dynamic> json) {
    return BannerData(
      bannerId: json['id'] ?? 0,
      img: json['img'] ?? "",
        urlLink:json['urlLink']??""

    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = bannerId;
    data['img'] = img;
    data['urlLink'] =urlLink;
    return data;
  }
}
