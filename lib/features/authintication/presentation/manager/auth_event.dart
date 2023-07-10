part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}


class LogInEvent extends AuthEvent {
  final AuthUser user ;
  LogInEvent({required this.user}) ;
}

class LogOutEvent extends AuthEvent {

}
class CheckLogEvent extends AuthEvent {
}