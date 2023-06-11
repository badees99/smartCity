import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcity/features/login/domain/use_cases/get_user_use_case.dart';
import 'package:smartcity/features/login/domain/use_cases/login_use_case.dart';
import 'package:smartcity/features/login/domain/use_cases/logout_Usecase.dart';

import 'event.dart';
import 'state.dart';

class Login_userBloc extends Bloc<Login_userEvent, Login_userState> {
  final GetUserUseCase getUser;
  final LogoutUseCase logout;

  final LoginUseCase login;

  Login_userBloc(
      {required this.login, required this.getUser, required this.logout})
      : super(Login_userState()) {

    on<Login_userEvent>((event, emit) async {
      if(event is InitEvent){
        emit(Login_userState()) ;
      }
      if (event is LoginEvent) {
        debugPrint('login bloc');
        final failureOrDoneMessage = await login(
            event.userName, event.password);
       emit( failureOrDoneMessage.fold((l) => ErrorLoginState(), (r) =>
           LoadedLoginState()));
      } else if (event is GetUserEvent) {
        debugPrint('login bloc');
        final failureOrDoneMessage = await getUser();
        emit(
            failureOrDoneMessage.fold((l) => ErrorGetUserDataState(), (r) =>
                UserDataLoadedState(user: r))
        );
      } else if (event is LogoutEvent) {
        final failureOrDone = await logout();
        emit(
            failureOrDone.fold((l) => ErrorLogoutState(), (r) =>
                SuccefullLogoutState())
        );
      }
      //emit(LoadingLoginState()) ;

    });
  }
}
