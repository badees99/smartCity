import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class RouteHandleEvent {}

class InitEvent extends RouteHandleEvent {}

class DrawRouteEvent extends InitEvent{
  DrawRouteEvent() ;

}