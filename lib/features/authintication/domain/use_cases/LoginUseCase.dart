
import 'package:admin/Features/authintication/data/models/authUserModel.dart';
import 'package:admin/Features/authintication/data/repositories/authintication_reposetorie.dart';
import 'package:admin/core/exception_handler/failures.dart';
import 'package:dartz/dartz.dart';

class LoginUseCase {
  final AuthReposetorie repo;

  LoginUseCase({required this.repo});

  Future<Either<Failure, bool>> call(AuthUser user) async {
    return await repo.logIn(user);
  }
}
