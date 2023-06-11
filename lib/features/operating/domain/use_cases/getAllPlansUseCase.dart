import 'package:dartz/dartz.dart';
import 'package:smartcity/core/error/failure.dart';
import 'package:smartcity/features/operating/domain/repositories/repositories.dart';
import 'package:smartcity/features/operating/domain/entities/bin.dart';

class GetPlanUseCase {
  final BinRepositories repo;

  GetPlanUseCase({required this.repo});

  Future<Either<Failure, List<Bin>>> call() async {
    return await repo.getAllBins();
  }
}