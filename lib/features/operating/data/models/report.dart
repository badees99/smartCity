
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class ReportModel {
  final String id , binid , description , addedBy  ;
  final List<File> images ;
  final Timestamp date ;

  ReportModel({required this.date  , required this.id , required this.binid,required this.description,required this.addedBy,required this.images});

  factory ReportModel.fromJson(Map<String , dynamic> json){
    return ReportModel(
      date: json['date'] ,
        id: json['id'],
        binid: json['binid'],
        description: json['description'],
        addedBy: json['addedby'] ,
        images: json['images'],);

  }


  Map<String, dynamic> toJson() {
    return {
      'date' :  Timestamp.fromDate(DateTime.now()),
      'id': this.id,
      'binid': this.binid,
      'description': this.description,
      'addedby': this.addedBy ,
      'images': this.images ,
    };
  }
}