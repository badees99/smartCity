import 'package:dartz/dartz.dart';
import 'package:smartcity/core/error/failure.dart';
import 'package:smartcity/features/login/domain/entities/user.dart ';
import 'package:smartcity/features/login/domain/repositories/repositories.dart';

class GetAllUsersUseCase {
  final UserRepositories repo;

  GetAllUsersUseCase({required this.repo});

  Future<Either<Failure, List<User>>> call() async {
    return await repo.getAllUsers();
  }
}
