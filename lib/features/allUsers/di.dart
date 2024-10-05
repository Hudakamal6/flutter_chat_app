import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat_app/features/allUsers/data/data_sources/remote_data%20source.dart';
import 'package:flutter_chat_app/features/allUsers/presentation/manager/user_cubit.dart';
import 'package:get_it/get_it.dart';

import 'data/data_sources/remote_data_source_impl.dart';
import 'data/repositories/repo.dart';
import 'domain/repositories/user_repo_impl.dart';
import 'domain/use_cases/get_users_use_case.dart';

class UsersDi {
  final sl = GetIt.instance;

  Future<void> init() async {

    sl.registerFactory(() => UserCubit(getUsersUseCase: sl()));


    sl.registerLazySingleton(() => GetUsersUseCase(repository: sl()));


    sl.registerLazySingleton<UserRepository>(
            () => UserRepositoryImpl(remoteDataSource: sl()));


    sl.registerLazySingleton<UserRemoteDataSource>(
            () => UserRemoteDataSourceImpl(firestore: sl()));


    sl.registerLazySingleton(() => FirebaseFirestore.instance);
  }
}