
import 'package:get/get.dart';
import 'package:protippz/app/controller/history_controller.dart';
import 'package:protippz/app/controller/profile_controller.dart';
import 'package:protippz/app/global/controllers/auth_controller.dart';
import 'package:protippz/app/global/controllers/nav_bar_controller/nav_bar_controller.dart';


class DependencyInjection extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController(), fenix: true);
    Get.lazyPut(() => NavBarController(), fenix: true);
    Get.lazyPut(() => ProfileController(), fenix: true);
    Get.lazyPut(() => HistoryController(), fenix: true);
  }
}