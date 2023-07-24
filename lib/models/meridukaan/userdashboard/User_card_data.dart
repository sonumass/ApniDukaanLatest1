class UserCardData {
  UserCardData({
    required this.name,
    required this.value,
    required this.intvalue,
    required this.percentage,
    required this.iconImage,
    required this.navigate,
    required this.reportLink});

  UserCardData.fromJson(dynamic json) {
    name = json['name'] ?? "";
    value = json['value'] ?? "0";
    intvalue = json['intvalue'] ?? 0;
    percentage = json['percentage'] ?? "0";
    iconImage = json['iconImage'] ?? "";
    navigate = json['navigate'] ?? "";
    reportLink = json['reportLink'] ?? "";
  }

  String name = "";
  String value = "";
  int intvalue = 0;
  String percentage = "";
  String iconImage = "";
  String navigate = "";
  String reportLink = "";

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['value'] = value;
    map['intvalue'] = intvalue;
    map['percentage'] = percentage;
    map['iconImage'] = iconImage;
    map['navigate'] = navigate;
    map['reportLink'] = reportLink;
    return map;
  }

}