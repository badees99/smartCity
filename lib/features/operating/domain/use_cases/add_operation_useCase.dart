import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:smartcity/core/error/failure.dart';
import 'package:smartcity/features/operating/domain/entities/bin.dart';
import 'package:smartcity/features/operating/domain/repositories/repositories.dart';

class AddOperationUseCase extends Equatable {
  BinRepositories repo ;
  AddOperationUseCase({required this.repo});
  Future<Either<Failure , bool>> call(Bin bin) async{

    return await repo.addOperation(bin);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [] ;

}