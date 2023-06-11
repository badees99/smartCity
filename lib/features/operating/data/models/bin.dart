

import 'package:smartcity/features/operating/domain/entities/bin.dart';

class BinModel extends Bin {
  BinModel(
      {required super.id,
        required super.name,
        required super.longitude,
        required super.latitude,
        required super.status});

  factory BinModel.fromJson(Map<String, dynamic> json) {
    return BinModel(
        id: json['id'],
        name: json['name'],
        longitude: json['location'].longitude.toString(),
        latitude: json['location'].latitude.toString(),
        status: json['status'].toString());
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
