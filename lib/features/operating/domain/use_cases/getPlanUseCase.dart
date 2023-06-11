

import 'package:dartz/dartz.dart';
import 'package:smartcity/core/error/failure.dart';
import 'package:smartcity/features/operating/domain/entities/plan.dart';
import 'package:smartcity/features/operating/domain/repositories/repositories.dart';

class GetPlanUseCase {
  final BinRepositories repo;

  GetPlanUseCase({required this.repo});

  Future<Either<Failure, Plan>> call() async {
    return await repo.getPlan();
  }
}
