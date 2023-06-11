import 'package:smartcity/features/operating/domain/entities/bin.dart';

abstract class OperatingEvent {}

class InitEvent extends OperatingEvent {}
class GetAllBinsEvent extends OperatingEvent {

}
class GetPlanEvent extends InitEvent {

}

class AddOperationEvent extends InitEvent {
  Bin bin ;
  AddOperationEvent({required this.bin});
}