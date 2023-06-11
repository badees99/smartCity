import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smartcity/core/error/failure.dart';
import 'package:smartcity/features/operating/domain/entities/bin.dart';
import 'package:smartcity/features/operating/domain/entities/plan.dart';
import 'package:smartcity/features/operating/domain/entities/route.dart';

abstract class BinRepositories {
  Future<Either<Failure, List<Bin>>> getAllBins();
  Future<Either<Failure, Bin  >> getBin();
  Future<Either<Failure, Plan>> getPlan();
  Future<Either<Failure, List<Plan>>> getAllPlans();
  Future<Either<Failure, RouteEnt>> getRoute();
  Future<Either<Failure , bool>> addOperation(Bin bin);

}
