

import 'package:dartz/dartz.dart';
import 'package:smartcity/core/error/failure.dart';
import 'package:smartcity/features/operating/domain/entities/route.dart';
import 'package:smartcity/features/operating/domain/repositories/repositories.dart';

class GetRouteUseCase {
  final BinRepositories repo;

  GetRouteUseCase({required this.repo});

  Future<Either<Failure, RouteEnt>> call() async {
    return await repo.getRoute();
  }
}
