import 'package:driftaway/auth/forgot_password_screen.dart';
import 'package:driftaway/data/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_text_fields/material_text_fields.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.showRegisterScreen});

  final void Function() showRegisterScreen;
  
  @override
  State<LoginScreen> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future signIn() async {
    showDialog(
      context: context,
      builder: (context) {
        return Center(child: CircularProgressIndicator(color: kPrimaryColor));
      },
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Email or password is incorrect!\n  Please enter the correct email and password.',
          ),
        ),
      );
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/images/logo.jpg', width: 350, height: 250),

              const SizedBox(height: 10),

              Text(
                'Welcome Back!',
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 230, 113, 4),
                ),
              ),

              Text(
                'LogIn below with your details',
                style: TextStyle(fontSize: 17),
              ),

              const SizedBox(height: 50),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: MaterialTextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  hint: 'email',
                  prefixIcon: Icon(Icons.email),
                  suffixIcon: Icon(Icons.check),
                ),
              ),

              const SizedBox(height: 10),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: MaterialTextField(
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.next,
                  obscureText: true,
                  hint: 'password',
                  prefixIcon: Icon(Icons.lock_outline),
                  suffixIcon: Icon(Icons.visibility_off),
                ),
              ),

              const SizedBox(height: 30),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => ForgotPasswordScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: GestureDetector(
                  onTap: signIn,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 230, 113, 4),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Not registered?'),
                  GestureDetector(
                    onTap: widget.showRegisterScreen,
                    child: Text(
                      'Register now',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
