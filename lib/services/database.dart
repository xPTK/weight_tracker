import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DatabaseService {
  DatabaseService._privateConstructor();

  ///Singleton of DatabaseService class.
  static final DatabaseService dbService =
    DatabaseService._privateConstructor();

  ///Firebase Firestore instance.
  final FirebaseFirestore _dbInstance = FirebaseFirestore.instance;

  ///Returns FirebaseFirestore instance.
  FirebaseFirestore get db => _dbInstance;

  ///Adds weight to the database.
  Future<void> addWeight(
    CollectionReference<Object?> weights,
    TextEditingController textEditingController,
  ) async {
    try {
      if (double.parse(textEditingController.text) < 1.0) {
        throw Exception('Weight must be at least 1.');
      }

      await weights.add({
        'weight': double.parse(textEditingController.text),
        'timestamp': DateTime.now(),
      }).timeout(
          const Duration(seconds: 5),
          onTimeout: () => throw FirebaseException(
            plugin: 'firebase',
            code: 'timeout',
            message: 'Operation timed out.',
          )
        );
    } on FirebaseException catch (e) {
      Get.snackbar(
        'Error',
        'Weight cannot be added. \nCheck your Internet connection.',
        snackPosition: SnackPosition.BOTTOM,
        icon: const Icon(Icons.error),
        margin: const EdgeInsets.all(8.0),
      );
      await Future.delayed(const Duration(seconds: 4));
    } on Exception catch (e) {
      Get.snackbar(
        'Invalid weight',
        'Weight cannot be added due to invalid number.',
        snackPosition: SnackPosition.BOTTOM,
        icon: const Icon(Icons.error),
        margin: const EdgeInsets.all(8.0),
      );
      await Future.delayed(const Duration(seconds: 4));
    }
  }

  ///Updates weight in the database.
  void updateWeight(
    dynamic weight,
    TextEditingController textEditingController,
  ) async {
    try {
      if (double.parse(textEditingController.text) < 1.0) {
        throw Exception('Weight must be at least 1.');
      }

      weight.reference.update({
        'weight': double.parse(textEditingController.text),
      });
      Get.back();
    } on FirebaseException catch (e) {
      Get.back();
      Get.snackbar(
        'Error',
        'Weight cannot be edited.',
        icon: const Icon(Icons.error),
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(8.0),
      );
    } on Exception catch (e) {
      Get.back();
      Get.snackbar(
        'Invalid weight',
        'Weight cannot be edited due to invalid number.',
        snackPosition:SnackPosition.BOTTOM,
        backgroundColor:Colors.orange,
        colorText: Colors.white,
        icon: const Icon(Icons.error),
        margin: const EdgeInsets.all(8.0),
      );
    }
  }

  ///Deletes weight from the database.
  void deleteWeight(dynamic weight) {
    weight.reference.delete();
  }
}
