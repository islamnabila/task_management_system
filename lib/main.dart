import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_manager_practice/Style/style.dart';

import 'Screen/forget_password_screen.dart';
import 'Screen/pin_verification_screen.dart';
import 'Screen/signup_screen.dart';
import 'Screen/splash_screen.dart';

void main(){
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: colorGreen,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
