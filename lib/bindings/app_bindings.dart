import 'package:get/get.dart';
import 'package:weight_tracker/controllers/connection_controller.dart';
import 'package:weight_tracker/controllers/home_controller.dart';
import 'package:weight_tracker/controllers/login_controller.dart';

class AppBindings extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<ConnectionController>(() => ConnectionController());
  }
}