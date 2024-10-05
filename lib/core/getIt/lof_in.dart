import 'package:get_it/get_it.dart';

import '../../features/signIn/data/data_sources/log_in_remote_data_source_impl.dart';
import '../../features/signIn/data/repositories/log_in_repo.dart';
import '../../features/signIn/domain/repositories/log_in_repo_impl.dart';
import '../../features/signIn/domain/use_cases/log_in_use_case.dart';
import '../../features/signIn/domain/use_cases/log_out_use_case.dart';
import '../../features/signIn/presentation/manager/log_in_cubit.dart';

class LoginDi{

  final sl = GetIt.instance;

  void init() {

    sl.registerFactory(() => LoginCubit(sl(),sl()));


    sl.registerLazySingleton(() => LoginUseCase(sl()));
    sl.registerLazySingleton(() => LogOutUseCase(sl()));


    sl.registerLazySingleton<LoginRepository>(() => LoginRepositoryImpl(sl()));


    sl.registerLazySingleton(() => LoginRemoteDataSource());
  }

}