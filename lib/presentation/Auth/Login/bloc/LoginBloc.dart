import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stc_health_suits/app/sharedPrefs/SharedPrefs.dart';
import '../../../../common/constants.dart';
import 'LoginEvent.dart';
import 'LoginState.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {

    on<Login>((event, emit) async {
      SharedPrefss sharedPrefss = SharedPrefss();
      emit(LoginLoading());
      try {
        if(event.email.isNotEmpty && event.password.isNotEmpty)
          {
            await sharedPrefss.addStringToSF(SAVE_EMAIL, event.email);
            await sharedPrefss.addStringToSF(SAVE_PASSWORD, event.password);
            emit(LoginLoaded());
          }else{
          emit(const LoginError("Enter login credentials to login"));
        }
      } catch(e) {
        emit(const LoginError("Failed to load. is your device online?"));
      }

    });
  }
}