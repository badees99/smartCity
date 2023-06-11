import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:smartcity/core/error/exceptions.dart';
import 'package:smartcity/core/error/failure.dart';
import 'package:smartcity/features/login/data/data_sources/userRemoteDataSource.dart';
import 'package:smartcity/features/login/domain/entities/user.dart%20';
import 'package:smartcity/features/login/domain/repositories/repositories.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as internet;
class UserRepositoriseImpl implements UserRepositories {
  final UserRemoteDataSource dataSource;

UserRepositoriseImpl({required this.dataSource}) ;





  @override
  Future<Either<Failure, Unit>> logOut() async {
    try {
      await dataSource.logOut();
      return right(unit);
    } on ServerException {
      return left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> login(String userName, String password) async {
    debugPrint('login repo');
    return getmesage(dataSource.login(userName, password));
  }



  Future<Either<Failure, Unit>> getmesage(Future<Unit> login) async {
    try {
      await login;
      return right(unit);
    } on ServerException {
      return left(ServerFailure());
    }

  }

  @override
  Future<Either<Failure, Unit>> addUser(user) {
    // TODO: implement addUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> getUser() async {
    final user ;
    try{
       user = await dataSource.getUser() ;
      return Right(user) ;
    }on ServerException {
      return Left(ServerFailure());
    }
    // TODO: implement getUser
    throw UnimplementedError();
  }




}
