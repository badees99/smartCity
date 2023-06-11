import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:smartcity/features/login/data/data_sources/userRemoteDataSource.dart';
import 'package:smartcity/features/login/data/repositories/repositries.dart';
import 'package:smartcity/features/login/domain/repositories/repositories.dart';
import 'package:smartcity/features/login/domain/use_cases/get_user_use_case.dart';
import 'package:smartcity/features/login/domain/use_cases/login_use_case.dart';
import 'package:smartcity/features/login/domain/use_cases/logout_Usecase.dart';
import 'package:smartcity/features/login/presentation/bloc/bloc.dart';
import 'package:smartcity/features/operating/data/data_sources/binRD.dart';
import 'package:smartcity/features/operating/data/repositories/repositories.dart';
import 'package:smartcity/features/operating/domain/repositories/repositories.dart';
import 'package:smartcity/features/operating/domain/use_cases/add_operation_useCase.dart';
import 'package:smartcity/features/operating/domain/use_cases/getPlanUseCase.dart';
import 'package:smartcity/features/operating/domain/use_cases/getRouteUseCase.dart';
import 'package:smartcity/features/operating/domain/use_cases/getallbinsusecase.dart';
import 'package:smartcity/features/operating/presentation/manager/bloc.dart';
import 'package:smartcity/features/operating/presentation/manager/routehandle/bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //Features - Login
  // Bloc
  sl.registerFactory(() => Login_userBloc(logout: sl(),login: sl(), getUser: sl()));


  //Use Cases
  sl.registerLazySingleton(() => LoginUseCase(repo: sl()));
  sl.registerLazySingleton(() => GetUserUseCase(repo: sl()));
  sl.registerLazySingleton(() => LogoutUseCase(repo: sl()));


  //Repositories

  sl.registerLazySingleton<UserRepositories>(
      () => UserRepositoriseImpl(dataSource: sl()));

  //DataSources

  sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserReamotDataSourceImp(firebaseAuth: sl()));

  sl.registerLazySingleton(() => FirebaseAuth.instance);


  //Feature-Operation
  //Bloc
  sl.registerFactory(() => OperatingBloc(getPlanUseCase: sl(),getAllBinsUseCase: sl() , addOperationUseCase: sl()));
  sl.registerFactory(() => RouteHandleBloc(getRouteUseCase: sl()));

  //Use cases
  sl.registerLazySingleton(() => GetAllBinsUseCase(repo: sl()));
  sl.registerLazySingleton(() => GetPlanUseCase(repo: sl()));
  sl.registerLazySingleton(() => GetRouteUseCase(repo: sl())) ;
  sl.registerLazySingleton(() => AddOperationUseCase(repo: sl()));

  //Repositories
  sl.registerLazySingleton<BinRepositories>(() => BinsRepositoriseImpl(dataSource: sl()));


  //DataSource
  sl.registerLazySingleton<BinRemoteDataSource>(() => BinReamotDataSourceImp(firebaseFirestore: sl() , firebaseAuth: sl())) ;
  sl.registerLazySingleton(() => FirebaseFirestore.instance) ;
}
