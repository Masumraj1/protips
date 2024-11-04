
import 'package:get/get.dart';
import 'package:protippz/app/global/controllers/auth_controller.dart';


class DependencyInjection extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController(), fenix: true);
  }
}