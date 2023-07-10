part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}


class LoadingState extends AuthState {}


class LoginSuccessState extends AuthState {}
class LoginFailedState extends AuthState {}


class LogoutSuccessState extends AuthState {}
class LogoutFailedState extends AuthState {}


