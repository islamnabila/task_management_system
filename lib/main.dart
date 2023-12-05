import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_manager_practice/Style/style.dart';

import 'Screen/splash_screen.dart';

void main(){
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigationKey,
      theme: ThemeData(
        primaryColor: colorGreen,
      ),
      debugShowCheckedModeBanner: false,
      home:const SplashScreen(),
    );
  }
}
