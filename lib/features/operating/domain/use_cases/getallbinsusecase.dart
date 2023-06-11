import 'package:dartz/dartz.dart';
import 'package:smartcity/core/error/failure.dart';
import 'package:smartcity/features/operating/domain/entities/bin.dart';
import 'package:smartcity/features/operating/domain/repositories/repositories.dart';

class GetAllBinsUseCase {
  final BinRepositories repo;

  GetAllBinsUseCase({required this.repo});

  Future<Either<Failure, List<Bin>>> call() async {
    return await repo.getAllBins();
  }
}
