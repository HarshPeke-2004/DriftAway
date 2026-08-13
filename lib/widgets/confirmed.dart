import 'dart:async';

import 'package:driftaway/screens/show_bookings_screen.dart';
import 'package:flutter/material.dart';

class ConfirmScreen extends StatefulWidget {
  const ConfirmScreen({super.key});

  @override
  State<ConfirmScreen> createState() {
    return _ConfirmState();
  }
}

class _ConfirmState extends State<ConfirmScreen> {
  @override
  void initState() {
    super.initState();
    // After a delay, navigate to the login page
    Timer(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => ShowBookingsScreen(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                'assets/images/confirmed.gif',
                width: 400,
                height: 400,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 35,),
              child: Text(
                "Booking Confirmed! Redirecting to Bookings Page...",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
