import 'package:dartz/dartz.dart';
import 'package:smartcity/core/error/failure.dart';
import 'package:smartcity/features/login/domain/entities/user.dart ';
import 'package:smartcity/features/login/domain/repositories/repositories.dart';

class GetUserUseCase {
  final UserRepositories repo;

  GetUserUseCase({required this.repo});

  Future<Either<Failure, User>> call() async {
    return await repo.getUser();
  }
}
