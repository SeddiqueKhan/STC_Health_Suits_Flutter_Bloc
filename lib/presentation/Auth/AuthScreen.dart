import 'package:flutter/cupertino.dart';
import 'package:stc_health_suits/app/sharedPrefs/SharedPrefs.dart';
import 'package:stc_health_suits/common/constants.dart';
import 'package:stc_health_suits/presentation/Auth/Login/LoginScreen.dart';
import 'package:stc_health_suits/presentation/Auth/Profile/ProfileScreen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  SharedPrefss sharedPrefss = SharedPrefss();
  late Future<bool>? _checkUser;

  @override
  void initState() {
    _checkUser = sharedPrefss.getStringValuesSF(SAVE_PHONE);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _checkUser,
      builder: (ctx, snapshot){
        if(snapshot.data == true){
          return const ProfileScreen();
        }
        else if(snapshot.data == false){

          return const LoginScreen();
        }
        else{
          return Container();
        }
      },
    );
  }
}
