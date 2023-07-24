class DukanDetails {
  String aboutUs;
  String address;
  String createDate;
  String dukanLink;
  String email;
  String fbLink;
  String gitHubLink;
  int id;
  String instaLink;
  String linkdinLink;
  String logo;
  String mobile;
  String name;
  String natureOfBuss;
  bool status;
  String tagLine;
  String twitterLink;
  String updateDate;
  int userId;
  String youTubeLink;
  String yrsOfEst;

  DukanDetails(
      {required this.aboutUs,
      required this.address,
      required this.createDate,
      required this.dukanLink,
      required this.email,
      required this.fbLink,
      required this.gitHubLink,
      required this.id,
      required this.instaLink,
      required this.linkdinLink,
      required this.logo,
      required this.mobile,
      required this.name,
      required this.natureOfBuss,
      required this.status,
      required this.tagLine,
      required this.twitterLink,
      required this.updateDate,
      required this.userId,
      required this.youTubeLink,
      required this.yrsOfEst});

  factory DukanDetails.fromJson(Map<String, dynamic> json) {
    return DukanDetails(
      aboutUs: json['aboutUs'] ?? "",
      address: json['address'] ?? "",
      createDate: json['createDate'] ?? "",
      dukanLink: json['dukanLink'] ?? "",
      email: json['email'] ?? "",
      fbLink: json['fbLink'] ?? "",
      gitHubLink: json['gitHubLink'] ?? "",
      id: json['id'] ?? 0,
      instaLink: json['instaLink'] ?? "",
      linkdinLink: json['linkdinLink'] ?? "",
      logo: json['logo'] ?? "",
      mobile: json['mobile'] ?? "",
      name: json['name'] ?? "",
      natureOfBuss: json['natureOfBuss'] ?? "",
      status: json['status'] ?? false,
      tagLine: json['tagLine'] ?? "",
      twitterLink: json['twitterLink'] ?? "",
      updateDate: json['updateDate'] ?? "",
      userId: json['userId'] ?? 0,
      youTubeLink: json['youTubeLink'] ?? "",
      yrsOfEst: json['yrsOfEst'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['aboutUs'] = aboutUs;
    data['address'] = address;
    data['dukanLink'] = dukanLink;
    data['email'] = email;
    data['fbLink'] = fbLink;
    data['gitHubLink'] = gitHubLink;
    data['id'] = id;
    data['instaLink'] = instaLink;
    data['linkdinLink'] = linkdinLink;
    data['logo'] = logo;
    data['name'] = name;
    data['natureOfBuss'] = natureOfBuss;
    data['status'] = status;
    data['tagLine'] = tagLine;
    data['twitterLink'] = twitterLink;
    data['userId'] = userId;
    data['youTubeLink'] = youTubeLink;
    data['yrsOfEst'] = yrsOfEst;
    data['createDate'] = createDate;
    data['mobile'] = mobile;
    data['updateDate'] = updateDate;

    return data;
  }
}
