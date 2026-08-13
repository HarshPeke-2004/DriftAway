import 'dart:async';

import 'package:driftaway/auth/main_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (ctx) => MainPage()));
    });
  }

  @override
  Widget build(context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/images/logo.jpg', width: 350, height: 350),
      ),
    );
  }
}
