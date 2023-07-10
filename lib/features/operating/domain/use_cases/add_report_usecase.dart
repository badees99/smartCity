import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:smartcity/core/error/failure.dart';
import 'package:smartcity/features/operating/data/models/report.dart';
import 'package:smartcity/features/operating/domain/repositories/repositories.dart';

class AddReportUseCase extends Equatable {
  final BinRepositories repo ;
  AddReportUseCase({required this.repo});
  Future<Either<Failure , bool>> call(ReportModel reportModel) async{
    return await repo.addReport(reportModel);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [] ;

}