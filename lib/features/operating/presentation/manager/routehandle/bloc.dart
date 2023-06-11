import 'package:bloc/bloc.dart';
import 'package:smartcity/core/error/failure.dart';
import 'package:smartcity/features/operating/domain/use_cases/getRouteUseCase.dart';

import 'event.dart';
import 'state.dart';

class RouteHandleBloc extends Bloc<RouteHandleEvent, RouteHandleState> {
  final GetRouteUseCase getRouteUseCase ;
  RouteHandleBloc({required this.getRouteUseCase}) : super(RouteHandleState().init()) {
    on<InitEvent>(_init);
  }

  void _init(RouteHandleEvent event, Emitter<RouteHandleState> emit) async {
    emit(LoadingRouteState());
    if(event is DrawRouteEvent){
      final filureOrDoneMessage = await getRouteUseCase();
      emit(
        filureOrDoneMessage.fold((failure) =>(failure is EmptyModelFailure) ? EmtypRouteState() : RouteErrorLoadingState()  , (route) => RouteLoadedState(route: route))
      );
    }

  }
}
