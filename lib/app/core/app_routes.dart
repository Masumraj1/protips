
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:protippz/app/screens/authentication_screen/forgot_password_screen/forgot_password_screen.dart';
import 'package:protippz/app/screens/authentication_screen/otp_screen/otp_screen.dart';
import 'package:protippz/app/screens/authentication_screen/reset_password_screen/reset_password_screen.dart';
import 'package:protippz/app/screens/authentication_screen/sign_in_screen/sign_in_screen.dart';
import 'package:protippz/app/screens/authentication_screen/sign_up_screen/sign_up_screen.dart';
import 'package:protippz/app/screens/favorite_screen/favorite_screen.dart';
import 'package:protippz/app/screens/home_screen/home_screen.dart';
import 'package:protippz/app/screens/notification_screen/notification_screen.dart';
import 'package:protippz/app/screens/profile_screen/profile_screen.dart';
import 'package:protippz/app/screens/splash_screen/splash_screen.dart';
import 'package:protippz/app/screens/tippz_history_screen/tippz_history_screen.dart';

class AppRoute {
  AppRoute._();
  ///==================== Initial Routes ====================
  static const String homeScreen = "/HomeScreen";
  static const String forgotPasswordScreen = "/ForgotPasswordScreen";
  static const String otpScreen = "/OtpScreen";
  static const String resetPasswordScreen = "/ResetPasswordScreen";
  static const String signInScreen = "/SignInScreen";
  static const String signUpScreen = "/SignUpScreen";
  static const String favoriteScreen = "/FavoriteScreen";
  static const String notificationScreen = "/NotificationScreen";
  static const String profileScreen = "/ProfileScreen";
  static const String splashScreen = "/SplashScreen";
  static const String tippzHistoryScreen = "/TippzHistoryScreen";




  static List<GetPage> routes = [
    ///==================== Initial Routes ====================
    GetPage(name: homeScreen, page: () =>    HomeScreen(),),
    GetPage(name: forgotPasswordScreen, page: () =>   const ForgotPasswordScreen(),),
    GetPage(name: otpScreen, page: () =>   const OtpScreen(),),
    GetPage(name: resetPasswordScreen, page: () =>   const ResetPasswordScreen(),),
    GetPage(name: signInScreen, page: () =>   const SignInScreen(),),
    GetPage(name: signUpScreen, page: () =>   const SignUpScreen(),),
    GetPage(name: favoriteScreen, page: () =>   const FavoriteScreen(),),
    GetPage(name: notificationScreen, page: () =>   const NotificationScreen(),),
    GetPage(name: profileScreen, page: () =>   const ProfileScreen(),),
    GetPage(name: splashScreen, page: () =>   const SplashScreen(),),
    GetPage(name: tippzHistoryScreen, page: () =>   const TippzHistoryScreen(),),

  ];
}