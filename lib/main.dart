import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stc_health_suits/presentation/DashBoard/DashBoardScreen.dart';
import 'package:stc_health_suits/presentation/Home/HomeScreen.dart';
import 'package:stc_health_suits/presentation/Home/HomeViewModel.dart';
import 'package:stc_health_suits/presentation/Login/LoginScreen.dart';
import 'package:stc_health_suits/presentation/ProductDetail/ProductDetailScreen.dart';
import 'package:stc_health_suits/presentation/ProductDetail/ProductDetailViewModel.dart';

import 'app/di/injector.dart';

Future main() async {
  await initializeDependencies();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  // This widget is the root of your application.
   @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider(create: (_) => const DashBoardScreen()),
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => ProductDetailViewModel()),
        // ChangeNotifierProvider(create: (_) => const LoginScreen())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const DashBoardScreen(),
          'home': (context) => const HomeScreen(),
          'productDetail': (context) => const ProductDetailScreen(),
          'login': (context) => const LoginScreen()
        }
      ),
    );
  }
}