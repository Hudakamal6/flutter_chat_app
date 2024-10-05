part of 'user_cubit.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}
class GetAllUsersLoading extends UserState {}
class GetAllUsersSuccess extends UserState {
  final List<String> userEmails ;
  GetAllUsersSuccess({required this.userEmails});
}
class GetAllUsersError extends UserState {
  final String errorMessage ;
  GetAllUsersError({required this.errorMessage});
}
