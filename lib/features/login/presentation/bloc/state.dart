import 'package:smartcity/features/login/domain/entities/user.dart%20';

class Login_userState {
  Login_userState init() {
    return Login_userState();
  }

  Login_userState clone() {
    return Login_userState();
  }
}

class LoadingLoginState extends Login_userState {}
class ErrorGetUserDataState extends Login_userState{}
class ErrorLoginState extends Login_userState {}
class ErrorLogoutState extends Login_userState {}
class SuccefullLogoutState extends Login_userState {}

class LoadedLoginState extends Login_userState {

}

class UserDataLoadedState extends Login_userState {
final User user ;
UserDataLoadedState({required this.user}) ;
}
