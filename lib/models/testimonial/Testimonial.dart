class Testimonial {
  Testimonial({
      required this.id,
    required this.name,
    required this.img,
    required this.desc,
    required this.degination,});

  Testimonial.fromJson(dynamic json) {
    id = json['id']??0;
    name = json['name']??"";
    img = json['img']??"";
    desc = json['desc']??"";
    degination = json['degination']??"";
  }
  int id=0;
  String name="";
  String img="";
  String desc="";
  String degination="";

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['img'] = img;
    map['desc'] = desc;
    map['degination'] = degination;
    return map;
  }

}