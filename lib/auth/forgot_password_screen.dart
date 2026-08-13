import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_text_fields/material_text_fields.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() {
    return _ForgetState();
  }
}

class _ForgetState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _emailController.text.trim(),
      );
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(content: Text('Password reset link sent!'));
        },
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(
              'Invalid Email. Please use the registered email only',
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reset Password')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              'Enter registered email to get password reset link',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          ),

          const SizedBox(height: 20),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: MaterialTextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              hint: 'email',
              textInputAction: TextInputAction.next,
              prefixIcon: Icon(Icons.email_outlined),
              suffixIcon: Icon(Icons.check),
            ),
          ),

          const SizedBox(height: 10),

          MaterialButton(
            onPressed: () => passwordReset(),
            color: Color.fromARGB(255, 230, 113, 4),
            child: Text('Reset Password'),
          ),
        ],
      ),
    );
  }
}
