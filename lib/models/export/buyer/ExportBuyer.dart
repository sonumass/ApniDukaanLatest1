import 'Cat.dart';

class ExportBuyer {
  ExportBuyer({
      required this.cat,
    required this.message,
    required this.status,});

  ExportBuyer.fromJson(dynamic json) {
    if (json['cat'] != null) {
      cat = [];
      json['cat'].forEach((v) {
        cat.add(Cat.fromJson(v));
      });
    }
    message = json['message']??"";
    status = json['status']??"";
  }
  List<Cat> cat=[];
  String message="";
  int status=200;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (cat.isNotEmpty) {
      map['cat'] = cat.map((v) => v.toJson()).toList();
    }
    map['message'] = message;
    map['status'] = status;
    return map;
  }

}