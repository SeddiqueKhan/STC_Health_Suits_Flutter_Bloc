import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stc_health_suits/app/sharedPrefs/SharedPrefs.dart';
import '../../../../common/constants.dart';
import 'ProfileEvent.dart';
import 'ProfileState.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {

    on<Profile>((event, emit) async {
      SharedPrefss sharedPrefss = SharedPrefss();
      emit(ProfileLoading());
      try {
        if(event.phone.isEmpty && event.password.isEmpty)
          {
            emit(const ProfileError("Enter login credentials to login"));
          }
        else{
          await sharedPrefss.addStringToSF(SAVE_PHONE, event.phone);
          await sharedPrefss.addStringToSF(SAVE_PASSWORD, event.password);
          emit(ProfileLoaded());
        }
      } catch(e) {
        emit(const ProfileError("Failed to load. is your device online?"));
      }

    });
  }
}