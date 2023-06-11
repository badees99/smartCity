import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcity/core/error/failure.dart';
import 'package:smartcity/features/operating/domain/entities/bin.dart';
import 'package:smartcity/features/operating/domain/use_cases/add_operation_useCase.dart';
import 'package:smartcity/features/operating/domain/use_cases/getallbinsusecase.dart';
import 'package:smartcity/features/operating/domain/use_cases/getPlanUseCase.dart';
import 'event.dart';
import 'state.dart';

class OperatingBloc extends Bloc<OperatingEvent, OperatingState> {
  final GetAllBinsUseCase  getAllBinsUseCase  ;
  final GetPlanUseCase getPlanUseCase ;
  final AddOperationUseCase addOperationUseCase ;
  OperatingBloc({required this.getAllBinsUseCase , required this.getPlanUseCase , required this.addOperationUseCase}) : super(OperatingState().init()) {
    on<OperatingEvent>(_init);
  }



  void _init(OperatingEvent event, Emitter<OperatingState> emit) async {
    emit(LoadingOperatingState()) ;
    if(event is GetAllBinsEvent){
      final failureOrDoneMessage = await getAllBinsUseCase();
      emit(_eitherFailureOrDoneMessage(failureOrDoneMessage));
    }
    if(event is GetPlanEvent){
      final failureOrDoneMessage = await getPlanUseCase();
      emit(
        failureOrDoneMessage.fold((l) => UnscuccessPlanLoad(), (planModel) => SuccessPlanLoad(planModel: planModel) )
      ) ;
    }if(event is AddOperationEvent){
      final failureOrDoneMessage  = await addOperationUseCase(event.bin) ;
      emit(
          failureOrDoneMessage.fold((failure) => OperationAddErrorState(), (result) => OperationAddedSuccessState(result: result))
      ) ;
    }

  }

  OperatingState _eitherFailureOrDoneMessage(Either<Failure, List<Bin>> either) {
    return either.fold((failure) => ErrorLoadingState(), (bins) => BinsLoadedState(bins: bins));
  }
}



