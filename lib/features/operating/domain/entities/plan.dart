
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Plan extends Equatable {
  final String id;
  final String siteId ;
  final String drivers ;
  final Timestamp timeStamp ;

  const Plan(
      {required this.id,
        required this.siteId  ,
        required this.drivers,
        required this.timeStamp ,
      });

  @override
  // TODO: implement props
  List<Object?> get props => [id , drivers , timeStamp , siteId];
}
