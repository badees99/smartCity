import 'package:flutter/cupertino.dart';

abstract class Login_userEvent {}

class InitEvent extends Login_userEvent {}

class LoginEvent extends Login_userEvent {
  final String userName, password;

  LoginEvent({required this.userName, required this.password}) {
    debugPrint('login event');
  }
}
class GetUserEvent extends Login_userEvent {
}

class LogoutEvent extends Login_userEvent {}
