import 'dart:async';

import 'package:admin/Features/authintication/data/models/authUserModel.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:admin/Features/authintication/domain/use_cases/LoginUseCase.dart';
import 'package:admin/Features/authintication/domain/use_cases/logout_usecase.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

 final LoginUseCase loginUseCase  ;
  final LogoutUseCase logOutUseCase ;
  AuthBloc({required this.logOutUseCase , required this.loginUseCase}) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      emit(LoadingState()) ;
      if(event is CheckLogEvent){
        emit( FirebaseAuth.instance.currentUser != null ? LoginSuccessState() :  LoginFailedState()) ;
      }
      if(event is LogInEvent){
        final result = await loginUseCase(event.user) ;
        emit(result.fold((l) => LoginFailedState(), (r) => LoginSuccessState())) ;
      }if(event is LogOutEvent){
        final result = await logOutUseCase() ;
        emit(result.fold((l) => LogoutFailedState(), (r) => LogoutSuccessState())) ;
      }
    });
  }
}
