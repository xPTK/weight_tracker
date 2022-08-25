import 'package:flutter/material.dart';
import 'package:weight_tracker/services/auth.dart';
import 'package:weight_tracker/screens/login_screen.dart';
import 'package:weight_tracker/screens/home_screen.dart';

class AuthenticationWrapper extends StatefulWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  State<AuthenticationWrapper> createState() => _AuthenticationWrapperState();
}

class _AuthenticationWrapperState extends State<AuthenticationWrapper> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService.authService.authStateChanges,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
        return const HomeScreen();
        } else {
          return const LoginScreen();
        }
      });
  }
}
