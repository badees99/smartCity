import 'package:dartz/dartz.dart';
import 'package:smartcity/core/error/failure.dart';
import 'package:smartcity/features/login/domain/repositories/repositories.dart';

class LogoutUseCase {
  final UserRepositories repo;

  LogoutUseCase({required this.repo});

  Future<Either<Failure, Unit>> call() async {
    return await repo.logOut();
  }
}
