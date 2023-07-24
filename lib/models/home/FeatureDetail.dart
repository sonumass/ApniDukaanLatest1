class FeatureDetail {
  int pfd_id;

  FeatureDetail({
    required this.pfd_id,
  });

  factory FeatureDetail.fromJson(Map<String, dynamic> json) {
    return FeatureDetail(
      pfd_id: json['pfd_id'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['pfd_id'] = pfd_id;

    return data;
  }
}
