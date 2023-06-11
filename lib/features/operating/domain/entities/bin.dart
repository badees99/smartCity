
import 'package:equatable/equatable.dart';

class Bin extends Equatable {
  final String id;
  final String name ;
  final String longitude , latitude  ;
  final String status ;

  const Bin(
      {required this.id,
        required this.name,
        required this.longitude ,
        required this.latitude ,
        required this.status
       });

  @override
  // TODO: implement props
  List<Object?> get props => [name,id , longitude , latitude];
}
