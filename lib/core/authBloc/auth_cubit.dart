import 'package:bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final _secureStorage = const FlutterSecureStorage();
   String? currentUserEmail = '';

  Future<void> checkUserAuthorized() async {
    try {

      String? isAuthorized = await _secureStorage.read(key: 'authorized');


      if (isAuthorized != null && isAuthorized == 'true') {
        emit(Authenticated());
      } else {
        emit(Unauthenticated()); }
    } catch (e) {

    }
  }


  Future<void> storeUserData(String userEmail , String userPassword) async{
    await _secureStorage.write(key: 'email', value: userEmail);
    await _secureStorage.write(key: 'password', value: userPassword);
    await _secureStorage.write(key: 'authorized', value: 'true');
    currentUserEmail =  (await _secureStorage.read(key: 'email'))!;

    emit(Authenticated());
  }
  Future<void> deleteUserData() async{
    await _secureStorage.delete(key: 'email');
    await _secureStorage.delete(key: 'password');
    await _secureStorage.delete(key: 'authorized');
    currentUserEmail = null;
    emit(Unauthenticated());
  }

  Future<void> verifyLogInState() async{
    currentUserEmail =  (await _secureStorage.read(key: 'email'))!;


  }
}
