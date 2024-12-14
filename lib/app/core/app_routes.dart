
import 'package:get/get.dart';
import 'package:protippz/app/screens/authentication_screen/forgot_password_screen/forgot_password_screen.dart';
import 'package:protippz/app/screens/authentication_screen/otp_screen/otp_screen.dart';
import 'package:protippz/app/screens/authentication_screen/reset_password_screen/reset_password_screen.dart';
import 'package:protippz/app/screens/authentication_screen/sign_in_screen/sign_in_screen.dart';
import 'package:protippz/app/screens/authentication_screen/sign_up_screen/sign_up_screen.dart';
import 'package:protippz/app/screens/contact_screen/contact_screen.dart';
import 'package:protippz/app/screens/deposite_screen/dairek_pay_screen.dart';
import 'package:protippz/app/screens/deposite_screen/deposite_screen.dart';
import 'package:protippz/app/screens/faq_screen/faq_screen.dart';
import 'package:protippz/app/screens/favorite_screen/favorite_screen.dart';
import 'package:protippz/app/screens/history_screen/history_screen.dart';
import 'package:protippz/app/screens/home_screen/home_screen.dart';
import 'package:protippz/app/screens/invite_screen/invite_screen.dart';
import 'package:protippz/app/screens/notification_screen/notification_screen.dart';
import 'package:protippz/app/screens/playerz_screen/playerz_screen.dart';
import 'package:protippz/app/screens/privacy_policy_screen/privacy_policy_screen.dart';
import 'package:protippz/app/screens/profile_screen/edit_profile_screen/edit_profile_screen.dart';
import 'package:protippz/app/screens/profile_screen/profile_screen.dart';
import 'package:protippz/app/screens/rewardz_screen/rewardz_screen.dart';
import 'package:protippz/app/screens/setting_screen/change_password_screen/change_password_screen.dart';
import 'package:protippz/app/screens/setting_screen/setting_screen.dart';
import 'package:protippz/app/screens/splash_screen/splash_screen.dart';
import 'package:protippz/app/screens/teamz_screen/teamz_screen.dart';
import 'package:protippz/app/screens/terms_condition_screen/terms_condition_screen.dart';
import 'package:protippz/app/screens/tipz_screen/tipz_screen.dart';
import 'package:protippz/app/screens/transaction_screen/transaction_screen.dart';
import 'package:protippz/app/screens/withdraw_screen/inner_screen/withdraw_ach.dart';
import 'package:protippz/app/screens/withdraw_screen/inner_screen/withdraw_check.dart';
import 'package:protippz/app/screens/withdraw_screen/withdraw_screen.dart';


class AppRoute {
  AppRoute._();
  ///==================== Initial Routes ====================
  static const String splashScreen = "/splash_screen";




  //=========================Auth Screen ===================
  static const String signInScreen = '/SignInScreen';
  static const String signUpScreen = '/SignUpScreen';
  static const String forgotPasswordScreen = '/ForgotPasswordScreen';
  static const String otpScreen = '/OtpScreen';
  static const String resetPasswordScreen = '/ResetPasswordScreen';


  ///=======================main =====================
  static const String homeScreen = '/HomeScreen';
  static const String notificationScreen = '/NotificationScreen';
  static const String favoriteScreen = '/FavoriteScreen';
  static const String historyScreen = '/HistoryScreen';
  static const String profileScreen = '/ProfileScreen';
  static const String editProfileScreen = '/EditProfileScreen';
  static const String settingScreen = '/SettingScreen';
  static const String changePasswordScreen = '/ChangePasswordScreen';
  static const String privacyPolicyScreen = '/PrivacyPolicyScreen';
  static const String termsConditionScreen = '/TermsConditionScreen';
  static const String contactScreen = '/ContactScreen';
  static const String faqScreen = '/FaqScreen';
  static const String inviteScreen = '/InviteScreen';
  static const String transactionScreen = '/TransactionScreen';
  static const String withdrawScreen = '/WithdrawScreen';
  static const String depositeScreen = '/DepositeScreen';
  static const String tipzScreen = '/TipzScreen';
  static const String withdrawAch = '/WithdrawAch';
  static const String withdrawCheck = '/WithdrawCheck';
  static const String playerzScreen = '/PlayerzScreen';
  static const String teamzScreen = '/TeamzScreen';
  static const String rewardzScreen = '/rewardzScreen';
  static const String dairekPayScreen = '/DairekPayScreen';







  static List<GetPage> routes = [
    ///==================== Initial Routes ====================
    GetPage(name: splashScreen, page: () => const SplashScreen(),),
    // GetPage(name: noInternetScreen, page: () =>  const NoInternetScreen(),),
    GetPage(name: signInScreen, page: () =>  SignInScreen(),),
    GetPage(name: signUpScreen, page: () =>  SignUpScreen(),),
    GetPage(name: otpScreen, page: () =>  const OtpScreen(),),
    GetPage(name: forgotPasswordScreen, page: () =>  ForgotPasswordScreen(),),
    GetPage(name: resetPasswordScreen, page: () =>  ResetPasswordScreen(),),



    GetPage(name: homeScreen, page: () =>  HomeScreen(),),
    GetPage(name: notificationScreen, page: () =>  NotificationScreen(),),
    GetPage(name: favoriteScreen, page: () =>  const FavoriteScreen(),),
    GetPage(name: historyScreen, page: () => HistoryScreen(),),
    GetPage(name: profileScreen, page: () =>   ProfileScreen(),),
    GetPage(name: editProfileScreen, page: () =>  EditProfileScreen(),),
    GetPage(name: settingScreen, page: () =>  SettingScreen(),),
    GetPage(name: changePasswordScreen, page: () =>  ChangePasswordScreen(),),
    GetPage(name: privacyPolicyScreen, page: () =>  PrivacyPolicyScreen(),),
    GetPage(name: termsConditionScreen, page: () =>  TermsConditionScreen(),),
    GetPage(name: contactScreen, page: () =>  ContactScreen(),),
    GetPage(name: faqScreen, page: () =>  const FaqScreen(),),
    GetPage(name: inviteScreen, page: () =>  InviteScreen(),),
    GetPage(name: transactionScreen, page: () =>  TransactionScreen(),),
    GetPage(name: withdrawScreen, page: () =>  WithdrawScreen(),),
    GetPage(name: withdrawCheck, page: () =>   WithdrawCheck(),),
    GetPage(name: withdrawAch, page: () =>   WithdrawAch(),),
    GetPage(name: depositeScreen, page: () =>  DepositeScreen(),),
    GetPage(name: tipzScreen, page: () =>   TipzScreen(),),
    GetPage(name: playerzScreen, page: () =>  const PlayerScreen(),),
    GetPage(name: teamzScreen, page: () =>   const TeamScreen(),),
    GetPage(name: rewardzScreen, page: () =>   const RewardScreen(),),
    GetPage(name: dairekPayScreen, page: () =>    DairekPayScreen(),),


  ];
}