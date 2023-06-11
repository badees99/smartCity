import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:smartcity/core/error/failure.dart';
import 'package:smartcity/features/login/domain/repositories/repositories.dart';

class LoginUseCase {
  final UserRepositories repo;

  LoginUseCase({required this.repo});

  Future<Either<Failure, Unit>> call(String userName, String password) async {
    debugPrint('login Usecas');
    return await repo.login(userName, password);
  }
}
