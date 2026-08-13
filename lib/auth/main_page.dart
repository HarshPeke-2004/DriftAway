import 'package:driftaway/auth/auth_page.dart';
import 'package:driftaway/screens/explore_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ExploreScreen();
          } else {
            return AuthPage();
          }
        },
      ),
    );
  }
}
