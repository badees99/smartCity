import 'package:admin/Features/accounts_management/data/data%20source/local_data_source.dart';
import 'package:admin/Features/authintication/data/data_sources/local_data_source.dart';
import 'package:admin/Features/authintication/data/models/authUserModel.dart';
import 'package:admin/core/exception_handler/failures.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

class AuthReposetorie {
  AuthLocalDataSource localDataSource ;
  AuthReposetorie({required this.localDataSource}) ;


  Future<Either<Failure , bool>> logOut() async{
    try {
      final result = await localDataSource.authLogout() ;
      return Right(result) ;
    } on FirebaseException catch (e) {
    return  Left( FirebaseAuthFailure()) ;
    }
  }

  Future<Either<Failure , bool>> logIn(AuthUser user) async{
    try {
      final result = await localDataSource.authLogin(user) ;
      return Right(result) ;
    } on FirebaseException catch (e) {
    return  Left( FirebaseAuthFailure()) ;
    }
  }

}