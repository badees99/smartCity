

import 'package:smartcity/features/operating/domain/entities/bin.dart';
import 'package:smartcity/features/operating/domain/entities/route.dart';

class RouteModel extends RouteEnt {
  RouteModel(
      { required super.polylines, required super.bins, required super.distance, required super.duration });

  factory RouteModel.fromJson(Map<String, dynamic> json) {
    return RouteModel(
        polylines: json['polyline'],
        bins: json['bins']  ,
        distance: json['distance'],
        duration: json['duration']);
  }

  Map<String, dynamic> toJson(Bin bin) {
    return {
      'name': bin.name,
      'longitude': bin.longitude,
      'latitude': bin.latitude,
      'status': bin.status
    };
  }
}
