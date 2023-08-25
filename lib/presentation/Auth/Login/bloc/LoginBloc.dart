import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'LoginEvent.dart';
import 'LoginState.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {

    on<Login>((event, emit) async {
      try {
        emit(LoginLoading());
        emit(LoginLoaded());
      } catch(e) {
        emit(const LoginError("Failed to load. is your device online?"));
      }
    });
  }
}