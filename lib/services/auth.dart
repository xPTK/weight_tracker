import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthService {
  AuthService._privateConstructor();

  ///Singleton of AuthService class.
  static final AuthService authService = AuthService._privateConstructor();

  ///Firebase Authentication instance.
  final FirebaseAuth _authInstance = FirebaseAuth.instance;

  ///Returns FirebaseAuth instance.
  FirebaseAuth get auth => _authInstance;

  ///Returns the current User.
  User? get currentUser => auth.currentUser;

  ///Returns notification about user authentication state.
  Stream<User?> get authStateChanges => auth.authStateChanges();

  ///Sign in as anonymous user.
  Future<void> signInAsAnon() async {

    try {
      await auth.signInAnonymously()
        .timeout(
          const Duration(seconds: 10),
          onTimeout: () => throw FirebaseAuthException(
            code: 'timeout',
            message: 'Operation timed out.',
          )
        );
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error',
        'Unable to sign in. Check your Internet connection.',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        borderColor: Colors.white,
        borderWidth: 1.0,
        snackPosition: SnackPosition.BOTTOM,
        icon: const Icon(
          Icons.error,
          color: Colors.white,
        ),
        margin: const EdgeInsets.all(8.0),
      );
    }
  }

  ///Signs out the current user.
  Future<void> signOut() async {

    try {
      await auth.signOut()
        .timeout(
          const Duration(seconds: 5),
          onTimeout: () => throw FirebaseAuthException(
            code: 'timeout',
            message: 'Operation timed out.',
          )
        );
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error',
        'Unable to sign out.',
        backgroundColor:Colors.orange,
        colorText: Colors.white,
        borderColor: Colors.white,
        borderWidth: 1.0,
        snackPosition: SnackPosition.BOTTOM,
        icon: const Icon(
          Icons.error,
          color: Colors.white,
        ),
        margin: const EdgeInsets.all(8.0),
      );
    }
  }
}
