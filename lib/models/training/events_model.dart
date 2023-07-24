import 'package:mcsofttech/models/training/post_event.dart';

import 'UpcomingEvents.dart';

class EventsModel {
  EventsModel({
      required this.upcomingEvents,required this.pastEvents,required this.message,required this.status});

  EventsModel.fromJson(dynamic json) {
    if (json['upcomingEvents'] != null) {
      upcomingEvents = [];
      json['upcomingEvents'].forEach((v) {
        upcomingEvents.add(UpcomingEvents.fromJson(v));
      });
    }
    if (json['pastEvents'] != null) {
      pastEvents = [];
      json['pastEvents'].forEach((v) {
        pastEvents.add(PostEvent.fromJson(v));
      });
      message=json['message'];
      status=json['status'];
    }
  }
  List<UpcomingEvents> upcomingEvents=[];
  List<PostEvent> pastEvents=[];
  String message="";
  int status=200;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['upcomingEvents'] = upcomingEvents.map((v) => v.toJson()).toList();
    map['pastEvents'] = pastEvents.map((v) => v.toJson()).toList();
    map['message']=message;
    map['status']=status;
    return map;
  }

}