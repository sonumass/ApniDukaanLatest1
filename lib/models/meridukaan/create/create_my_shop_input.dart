class CreateMyShopInput {
  String aboutUs;
  String address;
  String dukanLink;
  String email;
  String fbLink;
  String gitHubLink;
  String instaLink;
  String linkdinLink;
  String name;
  String mobile;
  String whatsAppNumber;
  String natureOfBuss;
  bool status;
  String tagLine;
  String twitterLink;
  String userId;
  int id;
  String youTubeLink;
  String yrsOfEst;
  String logo;

  CreateMyShopInput(
      this.aboutUs,
      this.address,
      this.dukanLink,
      this.email,
      this.fbLink,
      this.gitHubLink,
      this.instaLink,
      this.linkdinLink,
      this.name,
      this.mobile,
      this.whatsAppNumber,
      this.natureOfBuss,
      this.status,
      this.tagLine,
      this.twitterLink,
      this.userId,
      this.id,
      this.youTubeLink,
      this.yrsOfEst,
      this.logo);

  Map toJson() => {
        'aboutUs': aboutUs,
        'address': address,
        'dukanLink': dukanLink,
        'email': email,
        'fbLink': fbLink,
        'gitHubLink': gitHubLink,
        'instaLink': instaLink,
        'linkdinLink': linkdinLink,
        'name': name,
        'mobile': mobile,
        'whatsAppNumber': whatsAppNumber,
        'natureOfBuss': natureOfBuss,
        'status': status,
        'tagLine': tagLine,
        'twitterLink': twitterLink,
        'userId': userId,
        "id": id,
        'youTubeLink': youTubeLink,
        'yrsOfEst': yrsOfEst,
        'logo': logo,
      };
}
