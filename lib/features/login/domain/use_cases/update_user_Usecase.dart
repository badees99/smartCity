import 'package:dartz/dartz.dart';
import 'package:smartcity/core/error/failure.dart';
import 'package:smartcity/features/login/domain/entities/user.dart';
import 'package:smartcity/features/login/domain/repositories/repositories.dart';

class UpdatePostUseCase {
  final UserRepositories repo;

  UpdatePostUseCase({required this.repo});

  Future<Either<Failure, Unit>> call(User user) async {
    return await repo.updateUser(user);
  }
}
