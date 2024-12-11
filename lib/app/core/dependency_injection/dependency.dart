
import 'package:get/get.dart';
import 'package:protippz/app/controller/favorite_controller.dart';
import 'package:protippz/app/controller/google_auth_controller.dart';
import 'package:protippz/app/controller/history_controller.dart';
import 'package:protippz/app/controller/home_controller.dart';
import 'package:protippz/app/controller/info_controller.dart';
import 'package:protippz/app/controller/invite_controller.dart';
import 'package:protippz/app/controller/notification_controller.dart';
import 'package:protippz/app/controller/payment_controller.dart';
import 'package:protippz/app/controller/player_controller.dart';
import 'package:protippz/app/controller/profile_controller.dart';
import 'package:protippz/app/controller/team_controller.dart';
import 'package:protippz/app/global/controllers/auth_controller/auth_controller.dart';
import 'package:protippz/app/global/controllers/genarel_controller/genarel_controller.dart';


class DependencyInjection extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController(), fenix: true);
    Get.lazyPut(() => ProfileController(), fenix: true);
    Get.lazyPut(() => HistoryController(), fenix: true);
    Get.lazyPut(() => NotificationController(), fenix: true);
    Get.lazyPut(() => FavoriteController(), fenix: true);
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => PaymentController(), fenix: true);
    Get.lazyPut(() => InfoController(), fenix: true);
    Get.lazyPut(() => GeneralController(), fenix: true);
    Get.lazyPut(() => PlayerController(), fenix: true);
    Get.lazyPut(() => TeamController(), fenix: true);
    Get.lazyPut(() => InviteController(), fenix: true);
    Get.lazyPut(() => GoogleAuthController(), fenix: true);
  }
}