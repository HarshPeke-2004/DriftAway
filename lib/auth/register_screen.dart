import 'package:driftaway/data/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_text_fields/material_text_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, required this.showLoginScreen});

  final void Function() showLoginScreen;

  @override
  State<RegisterScreen> createState() {
    return _RegisterState();
  }
}

class _RegisterState extends State<RegisterScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPassController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPassController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  bool passwordConfirmed() {
    return _passwordController.text.trim() ==
        _confirmPassController.text.trim();
  }

  Future<void> signUp(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return Center(child: CircularProgressIndicator(color: kPrimaryColor));
      },
    );

    if (passwordConfirmed()) {
      if (_passwordController.text.trim().length >= 6) {
        try {
          final existingUser = await FirebaseFirestore.instance
              .collection('user')
              .doc(_emailController.text.trim())
              .get();

          if (existingUser.exists) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('email already exists'),
                duration: Duration(seconds: 5),
              ),
            );
            return;
          }

          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );

          await FirebaseFirestore.instance
              .collection('users')
              .doc(_emailController.text.trim())
              .set({
                'email': _emailController.text.trim(),
                'username': _usernameController.text.trim(),
                'phoneNumber': _phoneController.text.trim(),
              });
        } catch (error) {
          print("Erro creating user: $error");

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Error: ${error.toString()}"),
              duration: Duration(seconds: 2),
            ),
          );
        }
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Password should be 6 or more characters!"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } else {
      // Show password mismatch error message in a Snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Passwords do not match!"),
          duration: Duration(seconds: 2),
        ),
      );
    }
    Navigator.of(context).pop(); 
  }

  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/images/logo.jpg', width: 250, height: 150),
        
              const SizedBox(height: 15),
        
              Text(
                'Ready to Travel?',
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 230, 113, 4),
                ),
              ),
        
              Text(
                'Register below with your details.',
                style: TextStyle(fontSize: 17),
              ),
        
              const SizedBox(height: 50),
        
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: MaterialTextField(
                  controller: _usernameController,
                  keyboardType: TextInputType.text,
                  hint: 'Username',
                  textInputAction: TextInputAction.next,
                  prefixIcon: Icon(Icons.person_outline),
                  suffixIcon: Icon(Icons.text_fields),
                ),
              ),
        
              const SizedBox(height: 10),
        
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
        
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: MaterialTextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  hint: 'Phone Number',
                  textInputAction: TextInputAction.next,
                  prefixIcon: Icon(Icons.phone),
                  suffixIcon: Icon(Icons.phone_android),
                ),
              ),
        
              const SizedBox(height: 10),
        
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: MaterialTextField(
                  controller: _passwordController,
                  hint: 'password',
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.next,
                  prefixIcon: Icon(Icons.lock_outline),
                  suffixIcon: Icon(Icons.visibility_off),
                  obscureText: true,
                ),
              ),
        
              const SizedBox(height: 10),
        
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: MaterialTextField(
                  controller: _confirmPassController,
                  keyboardType: TextInputType.visiblePassword,
                  hint: 'Confirm Password',
                  textInputAction: TextInputAction.next,
                  prefixIcon: Icon(Icons.lock_outlined),
                  suffixIcon: Icon(Icons.visibility_off),
                  obscureText: true,
                ),
              ),
        
              const SizedBox(height: 30),
        
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: InkWell(
                  onTap: () => signUp(context),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 230, 113, 4),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already a member?"),
                    GestureDetector(
                      onTap: widget.showLoginScreen,
                      child: Text(
                        " Login now",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
