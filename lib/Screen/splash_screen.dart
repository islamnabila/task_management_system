import 'dart:async';

import 'package:flutter/material.dart';
import 'package:task_manager_practice/Screen/login_screen.dart';
import 'package:task_manager_practice/Screen/main_bottom_navbar.dart';
import 'package:task_manager_practice/Style/style.dart';
import 'package:task_manager_practice/controller/auth_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    loginScreen();
  }

  Future<void> loginScreen() async {
    final bool isLogedin = await AuthController.checkAuthState();

    Timer(const Duration(seconds: 2), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  isLogedin ?const MainBottomNavScreen() :
                  const LoginScreen()),
          (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ScreenBackGround(context),
          Center(child: ScreenLogo(context))
        ],
      ),
    );
  }
}
