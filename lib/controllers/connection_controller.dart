import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectionController extends GetxController {
  Stream<ConnectivityResult> connectionStream =
    Connectivity().onConnectivityChanged;
  late StreamSubscription connectionStreamSubscription;

  RxString connection = 'none'.obs;

  IconData setConnectionIcon(String connection) {
    if(connection == 'mobile') {
      return Icons.signal_cellular_4_bar_outlined;
    } else if(connection == 'wifi') {
      return Icons.signal_wifi_4_bar;
    } else {
      return Icons.signal_cellular_nodata;
    }
  }
}
