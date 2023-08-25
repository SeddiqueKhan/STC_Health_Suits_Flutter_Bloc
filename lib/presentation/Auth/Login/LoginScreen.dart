import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stc_health_suits/app/sharedPrefs/SharedPrefs.dart';
import 'package:stc_health_suits/common/constants.dart';
import 'package:stc_health_suits/presentation/Auth/AuthScreen.dart';
import 'package:stc_health_suits/presentation/Auth/Login/bloc/LoginBloc.dart';
import 'package:stc_health_suits/presentation/Auth/Login/bloc/LoginEvent.dart';
import 'package:stc_health_suits/presentation/Auth/Login/bloc/LoginState.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final LoginBloc _loginBloc = LoginBloc();

  TextEditingController _emailTextEditingController = TextEditingController();
  TextEditingController _passwordTextEditingController = TextEditingController();

  @override
  void initState() {
    _loginBloc.add(Login());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _loginBloc,
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message!),
              ),
            );
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            if (state is LoginInitial) {
              return _loading();
            } else if (state is LoginLoading) {
              return _loading();
            } else if (state is LoginLoaded) {
              return _buildLoginBody();
            } else if (state is LoginError) {
              return Container();
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  _loading() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
        ],
      ),
    );
  }

  _buildLoginBody(){
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width * 1,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: <Color>[Color(0xff188095), Color(0xff2ab3c6)]),
                ),
                child: const Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      child: Text(
                        "STC \n HEALTH",
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Positioned(
                      bottom: 50,
                      left: 30,
                      child: Text('Log In',
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center),
                    )
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width * 1,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 15.0),
                      child: SizedBox(
                        height: 100,
                        width: 300,
                        child: TextField(
                          controller: _emailTextEditingController,
                          // onChanged: (value){
                          //   _emailTextEditingController.text = value;
                          // },
                          decoration: const InputDecoration(
                              labelText: 'Email',
                              border: InputBorder.none,
                              suffixIcon: Icon(Icons.check_circle_outline)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                      width: 300,
                      child: TextField(
                        controller: _passwordTextEditingController,
                        // onChanged: (value){
                        //   _passwordTextEditingController.text = value;
                        // },
                        obscureText: true,
                        decoration: const InputDecoration(
                            labelText: 'Password',
                            border: InputBorder.none,
                            suffixIcon: Icon(Icons.remove_red_eye_outlined)),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        gradient: const LinearGradient(colors: <Color>[
                          Color(0xff188095),
                          Color(0xff2ab3c6)
                        ]),
                      ),
                      child: TextButton(
                          onPressed: () async {
                            SharedPrefss sharedPrefss = SharedPrefss();
                            if(_emailTextEditingController.text.isNotEmpty && _passwordTextEditingController.text.isNotEmpty){
                              await sharedPrefss.addStringToSF(
                                  SAVE_EMAIL, _emailTextEditingController.text);
                              await sharedPrefss.addStringToSF(SAVE_PASSWORD,
                                  _passwordTextEditingController.text);
                            }else{
                              const snackBar = SnackBar(
                                content: Text('Email and Password required.'),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            }

                          },
                          child: const Text(
                            "Continue",
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                    TextButton(
                        onPressed: () {
                        },
                        child: const Text(
                          'NEED HELP?',
                          style: TextStyle(color: Colors.black),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
