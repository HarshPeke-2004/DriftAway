import 'package:driftaway/auth/login_screen.dart';
import 'package:driftaway/auth/register_screen.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {
  bool showloginScreen = true;

  void toggleScreens() {
    setState(() {
      showloginScreen = !showloginScreen;
    });
  }

  @override
  Widget build(context) {
    if (showloginScreen) {
      return LoginScreen(showRegisterScreen: toggleScreens);
    } else {
      return RegisterScreen(showLoginScreen: toggleScreens);
    }
  }
}
