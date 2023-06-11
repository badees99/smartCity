import 'package:dartz/dartz.dart';
import 'package:smartcity/core/error/failure.dart';
import 'package:smartcity/features/login/domain/entities/user.dart%20';
abstract class UserRepositories {
  Future<Either<Failure, Unit>> login(String userName, String password);
  Future<Either<Failure, Unit>> logOut();
  Future<Either<Failure, User>> getUser();
}
