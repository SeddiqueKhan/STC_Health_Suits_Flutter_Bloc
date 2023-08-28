import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stc_health_suits/app/sharedPrefs/SharedPrefs.dart';
import 'package:stc_health_suits/common/constants.dart';
import 'package:stc_health_suits/presentation/Auth/AuthScreen.dart';
import 'package:stc_health_suits/presentation/Auth/Login/bloc/LoginBloc.dart';
import 'package:stc_health_suits/presentation/Auth/Login/bloc/LoginEvent.dart';
import 'package:stc_health_suits/presentation/Auth/Login/bloc/LoginState.dart';
import 'package:stc_health_suits/presentation/ProductDetail/ProductDetailScreen.dart';

import '../../DashBoard/DashBoardScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController _emailTextEditingController = TextEditingController();
  TextEditingController _passwordTextEditingController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return _buildLoginBody();
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
                         child: BlocProvider(
                           create: (BuildContext context) => LoginBloc(),
                           child: BlocListener<LoginBloc, LoginState>(
                               listener: (context, state) {
                                 if (state is LoginError) {
                                   ScaffoldMessenger.of(context).showSnackBar(
                                     SnackBar(
                                       content: Text(state.message!),
                                     ),
                                   );
                                 }
                                 else if(state is LoginLoaded){
                                   ScaffoldMessenger.of(context).showSnackBar(
                                     const SnackBar(
                                       content: Text('Successfully Login'),
                                     ),
                                   );
                                   dashboardKey.currentState!.onItemTapped(0);
                                 }
                               },
                           child: BlocBuilder<LoginBloc, LoginState>(
                             builder: (context, state){
                               if(state is LoginInitial){
                                 return TextButton(
                                     onPressed: () async {
                                       BlocProvider.of<LoginBloc>(context).add(
                                           Login(email: _emailTextEditingController.text, password: _passwordTextEditingController.text));
                                     },
                                     child: const Text(
                                       "Login",
                                       style: TextStyle(color: Colors.white),
                                     ));
                               }
                               else if(state is LoginLoading){
                                 return TextButton(
                                     onPressed: () async {},
                                     child: const SizedBox(
                                       child: CircularProgressIndicator(),
                                     ));
                               }
                               return TextButton(
                                   onPressed: () async {
                                     BlocProvider.of<LoginBloc>(context).add(
                                         Login(email: _emailTextEditingController.text, password: _passwordTextEditingController.text));
                                   },
                                   child: const Text(
                                     "Login",
                                     style: TextStyle(color: Colors.white),
                                   ));
                             },
                           )
                           )
                         ),
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
