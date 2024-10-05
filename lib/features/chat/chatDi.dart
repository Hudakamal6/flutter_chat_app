import 'package:flutter_chat_app/core/authBloc/auth_cubit.dart';
import 'package:flutter_chat_app/features/chat/domain/use_cases/ger_user_by_email.dart';
import 'package:flutter_chat_app/features/chat/domain/use_cases/get_message_use_case.dart';
import 'package:flutter_chat_app/features/chat/domain/use_cases/get_online_statues_use_case.dart';
import 'package:flutter_chat_app/features/chat/domain/use_cases/get_typing_statues_use_case.dart';
import 'package:flutter_chat_app/features/chat/domain/use_cases/set_typing_statues_use_case.dart';
import 'package:flutter_chat_app/features/chat/presentation/manager/chat_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'data/data_sources/chat_remote_data_source.dart';
import 'data/data_sources/chat_remote_data_source_impl.dart';
import 'data/repositories/chat_repo.dart';
import 'domain/repositories/chat_repo_impl.dart';
import 'domain/use_cases/send_message_use_case.dart';

final sl = GetIt.instance;

class ChatDi {
  void init() {
    sl.registerFactory(() => AuthCubit());
    sl.registerFactory(() => ChatCubit(
          sendMessageUseCase: sl(),
          getMessagesUseCase: sl(), getTypingStatusUseCase: sl(), getOnlineStatusUseCase: sl(), setTypingStatusUseCase: sl(), getUserByEmail: sl(),
        ));

    sl.registerLazySingleton(() => SendMessageUseCase(sl()));
    sl.registerLazySingleton(() => GetMessagesUseCase(sl()));
    sl.registerLazySingleton(() => GetTypingStatusUseCase(sl()));
    sl.registerLazySingleton(() => SetTypingStatusUseCase(sl()));
    sl.registerLazySingleton(() => GetOnlineStatusUseCase(sl()));
    sl.registerLazySingleton(() => GetUserByEmail(sl()));

    sl.registerLazySingleton<ChatRepository>(() => ChatRepositoryImpl(sl()));

    sl.registerLazySingleton<ChatRemoteDataSource>(
        () => ChatRemoteDataSourceImpl(FirebaseFirestore.instance));
  }
}
