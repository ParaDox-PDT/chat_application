import 'package:flutter/material.dart';
import 'package:flutter_defualt_project/ui/auth/pages/login_page.dart';
import 'package:flutter_defualt_project/ui/auth/pages/signup_page.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLoginPage = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isLoginPage ? "Login" : "Sign Up"),
        elevation: 10,
      ),
      body: isLoginPage
          ? LoginPage(
              onChanged: () {
                setState(() {
                  isLoginPage = false;
                });
              },
            )
          : SignUpScreen(
              onChanged: () {
                setState(() {
                  isLoginPage = true;
                });
              },
            ),
    );
  }
}
