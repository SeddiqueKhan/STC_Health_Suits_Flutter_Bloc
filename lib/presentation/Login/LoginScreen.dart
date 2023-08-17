import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height*0.4,
                width: MediaQuery.of(context).size.width*1,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: <Color>[Color(0xff188095), Color(0xff2ab3c6)]),
                ),
                child: const Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      child: Text("STC \n HEALTH", style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                    ),
                    Positioned(
                      bottom: 50,
                      left: 30,
                      child: Text('Log In', style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                    )
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height*0.5,
                width: MediaQuery.of(context).size.width*1,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 15.0),
                      child: SizedBox(
                        height: 100,
                        width: 300,
                        child: TextField(
                          decoration: InputDecoration(labelText: 'Email', border: InputBorder.none,
                              suffixIcon: Icon(Icons.check_circle_outline)
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 100,
                      width: 300,
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(labelText: 'Password', border: InputBorder.none,
                            suffixIcon: Icon(Icons.remove_red_eye_outlined)
                        ),
                      ),
                    ),
                   Container(
                     height: MediaQuery.of(context).size.height*0.08,
                     width: MediaQuery.of(context).size.width*0.8,
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(40),
                       gradient: LinearGradient(colors: <Color>[Color(0xff188095), Color(0xff2ab3c6)]),
                     ),                     child: TextButton(onPressed: (){},
                         child: Text("Continue", style: TextStyle(color: Colors.white),)),
                   ),
                    TextButton(onPressed: (){}, 
                        child: Text('NEED HELP?', style: TextStyle(color: Colors.black),))
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
