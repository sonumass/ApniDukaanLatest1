class MeriDukaanHome {
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
  String name;
  String natureOfBuss;
  bool status;
  String tagLine;
  String twitterLink;
  String updateDate;
  int userId;
  String youTubeLink;
  String yrsOfEst;

  MeriDukaanHome(
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
      required this.name,
      required this.natureOfBuss,
      required this.status,
      required this.tagLine,
      required this.twitterLink,
      required this.updateDate,
      required this.userId,
      required this.youTubeLink,
      required this.yrsOfEst});

  factory MeriDukaanHome.fromJson(Map<String, dynamic> json) {
    return MeriDukaanHome(
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
      name: json['name'] ?? "",
      natureOfBuss: json['natureOfBuss'] ?? "",
      status: json['status'] ?? false,
      tagLine: json['tagLine'] ?? "",
      twitterLink: json['twitterLink'] ?? "",
      updateDate: json['updateDate'] ?? "",
      userId: json['userId'] ?? "",
      youTubeLink: json['youTubeLink'] ?? "",
      yrsOfEst: json['yrsOfEst'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['aboutUs'] = aboutUs;
    data['address'] = address;
    data['createDate'] = createDate;
    data['dukanLink'] = dukanLink;
    data['email'] = email;
    data['fbLink'] = fbLink;
    data['gitHubLink'] = gitHubLink;
    data['id'] = id;
    data['instaLink'] = instaLink;
    data['linkdinLink'] = linkdinLink;
    data['name'] = name;
    data['natureOfBuss'] = natureOfBuss;
    data['status'] = status;
    data['tagLine'] = tagLine;
    data['twitterLink'] = twitterLink;
    data['updateDate'] = updateDate;
    data['userId'] = userId;
    data['youTubeLink'] = youTubeLink;
    data['yrsOfEst'] = yrsOfEst;
    return data;
  }
}
