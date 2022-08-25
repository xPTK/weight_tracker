import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bordered_text/bordered_text.dart';

import 'package:weight_tracker/controllers/login_controller.dart';
import 'package:weight_tracker/services/auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _authService = AuthService.authService;
  final LoginController _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            backgroundBlendMode: BlendMode.darken,
            color: Colors.black.withOpacity(0.6),
            image: const DecorationImage(
              image: AssetImage('assets/login_screen_background.png'),
              fit: BoxFit.cover,
              opacity: 0.25,
            )
          ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Image.asset(
                  'assets/logo.png',
                  scale: 8,
                ),
              ),
              BorderedText(
                strokeColor: Colors.white,
                strokeWidth: 5.0,
                child: Text(
                  'Weight\nTracker',
                  style: TextStyle(
                    fontFamily: 'DynaPuff',
                    fontSize: 90.0,
                    color: Colors.orange,
                    shadows: [
                      Shadow(color: Colors.black,
                        offset: Offset.fromDirection(1.5, 5.0),
                        blurRadius: 10.0
                      ),
                    ]
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: Text(
                  'Track your weight every day!',
                  style: TextStyle(
                    fontFamily: 'DynaPuff',
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
              const Spacer(flex: 8),
              Obx(() {
                return ElevatedButton(
                  child: !_loginController.isSigning.value
                    ? const Text(
                        'Sign in',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontFamily: 'sans-serif-light'),
                    )
                    : const CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2.0,
                    ),
                  onPressed: _loginController.isButtonEnabled.value
                    ? () async {
                      _loginController.isSigning.value = true;
                      _loginController.isButtonEnabled.value = false;

                      await _authService.signInAsAnon();

                      _loginController.isSigning.value = false;
                      await Future.delayed(const Duration(seconds: 4));
                      _loginController.isButtonEnabled.value = true;
                    }
                    : null,
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(200.0, 45.0),
                    shape: const StadiumBorder(),
                    elevation: 5.0,
                    side: const BorderSide(color: Colors.white),
                  ),
                );
              }),
              const Spacer(flex: 3),
            ],
          ),
        ),
        )
      ),
    );
  }
}
