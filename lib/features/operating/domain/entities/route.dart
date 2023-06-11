import 'package:equatable/equatable.dart';
import 'package:smartcity/features/operating/domain/entities/bin.dart';

class RouteEnt extends Equatable{
  String   polylines   , duration , distance ;
  List<Bin> bins ;
  RouteEnt({ required  this.polylines , required this.bins , required this.distance , required this.duration });

  @override
  // TODO: implement props
  List<Object?> get props => [ polylines , bins , duration , distance ];

}