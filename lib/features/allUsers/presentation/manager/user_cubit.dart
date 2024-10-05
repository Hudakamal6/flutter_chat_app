import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../domain/use_cases/get_users_use_case.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {

  final GetUsersUseCase getUsersUseCase;
  UserCubit({required this.getUsersUseCase}) : super(UserInitial());

  bool isMyEmail  = false;
  Future<void> fetchUserEmails() async {
    try {
      emit(GetAllUsersLoading());
      final emails = await getUsersUseCase();


      emit(GetAllUsersSuccess(userEmails: emails));
    } catch (e) {
      emit(GetAllUsersError(errorMessage: e.toString()));
    }
  }

checkMyEmail(String myEmail, List<String> allEmails)  {
    for (var email in allEmails) {
      if (email == myEmail) {
       isMyEmail = true;
      }else{
        isMyEmail =false;
      }
    }

  }



}
