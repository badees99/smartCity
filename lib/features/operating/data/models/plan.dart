import 'package:smartcity/features/operating/domain/entities/plan.dart';

class PlanModel extends Plan{
  PlanModel({required super.id, required super.drivers, required super.timeStamp , required super.siteId});

  factory PlanModel.fromJson(Map<String, dynamic> json) {
    return PlanModel(
        id: json['id'] ,
        drivers: json['drivers'],
      timeStamp: json['time'],
      siteId : json['siteid']
    );
  }

  Map<String, dynamic> toJson(Plan plan) {
    return {
      'siteId' : plan.siteId ,
      'id' : plan.id,
      'drivers' : plan.drivers ,
      'time' : plan.timeStamp ,
    };
  }
}