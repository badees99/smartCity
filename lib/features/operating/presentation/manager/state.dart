import 'package:equatable/equatable.dart';
import 'package:smartcity/features/operating/data/models/plan.dart';
import 'package:smartcity/features/operating/domain/entities/bin.dart';
import 'package:smartcity/features/operating/domain/entities/plan.dart';

class OperatingState extends Equatable {
  OperatingState init() {
    return OperatingState();
  }

  OperatingState clone() {
    return OperatingState();
  }


  List<Object?> get props => [] ;
}

class SuccessPlanLoad extends OperatingState{
  final Plan planModel ;
  SuccessPlanLoad({required this.planModel}) ;
  @override
  // TODO: implement props
  List<Object?> get props => [planModel];
}
class UnscuccessPlanLoad extends OperatingState{}
class LoadingOperatingState extends OperatingState{}
class LoadinBinsState extends OperatingState {}

class ErrorLoadingState extends OperatingState {}


class BinsLoadedState extends OperatingState {
  final List<Bin> bins ;
  BinsLoadedState({required this.bins});
  @override
  // TODO: implement props
  List<Object?> get props => [bins];
}


class OperationAddedSuccessState extends OperatingState {
  final bool result ;
  OperationAddedSuccessState({required this.result});
  @override
  // TODO: implement props
  List<Object?> get props => [result];
}
class OperationAddErrorState extends OperatingState {}

