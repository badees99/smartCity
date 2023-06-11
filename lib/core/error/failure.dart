import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class OfflineFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class EmptyCacheFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class IncorrectCredentialsFailure extends Failure {
  @override
  List<Object?> get props => [];
}
class EmptyModelFailure extends Failure {
  @override
  List<Object?> get props => [];
}
