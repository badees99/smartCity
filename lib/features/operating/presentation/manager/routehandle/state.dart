import 'package:smartcity/features/operating/domain/entities/route.dart';

class RouteHandleState {
  RouteHandleState init() {
    return RouteHandleState();
  }

  RouteHandleState clone() {
    return RouteHandleState();
  }

}


class RouteLoadedState extends RouteHandleState {
  RouteLoadedState({required this.route});
  final RouteEnt route ;

}

class EmtypRouteState extends RouteHandleState {

}

class RouteErrorLoadingState extends RouteHandleState{

}class LoadingRouteState extends RouteHandleState{

}