import 'package:dartz/dartz.dart';
import 'package:smartcity/core/error/exceptions.dart';

import 'package:smartcity/core/error/failure.dart';
import 'package:smartcity/features/operating/data/data_sources/binRD.dart';
import 'package:smartcity/features/operating/domain/entities/bin.dart';
import 'package:smartcity/features/operating/domain/entities/plan.dart';
import 'package:smartcity/features/operating/domain/entities/route.dart';
import 'package:smartcity/features/operating/domain/repositories/repositories.dart';

class BinsRepositoriseImpl implements BinRepositories {
  final BinRemoteDataSource dataSource;

  BinsRepositoriseImpl({required this.dataSource});

  @override
  Future<Either<Failure, List<Bin>>> getAllBins() async {
    try{
      final data = await dataSource.getAllBins()  ;
      return Right(data);
    } on ServerException{
      return Left(ServerFailure()) ;
    }
  }

  @override
  Future<Either<Failure, Bin>> getBin() {
    // TODO: implement logOut
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Plan>> getPlan() async{
    try{
      final data = await dataSource.getPlan()  ;
      return Right(data);
    } on ServerException{
      return Left(ServerFailure()) ;
    }
  }

  @override
  Future<Either<Failure, List<Plan>>> getAllPlans() {
    // TODO: implement getAllPlans
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, RouteEnt>> getRoute() async {
    try {
      final data = await dataSource.getRoute();
      return Right(data) ;
    } on ServerException {
      return Left(ServerFailure());
    } on EmptyModelException {
      return Left(EmptyModelFailure());
    }
    // TODO: implement getRoute
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> addOperation(Bin bin) async {
    try{
      final bool status = await dataSource.addOperation(bin);
      return Right(status) ;
    }on ServerException{
      Left(ServerFailure());
    }on EmptyModelException {
      Left(EmptyModelFailure());

    }
    // TODO: implement addOperation
    throw UnimplementedError();
  }
}
