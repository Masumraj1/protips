import 'package:go_router/go_router.dart';
import 'package:protippz/app/core/routes/route_path.dart';
import 'package:protippz/app/global/helper/extension/base_extension.dart';
import 'package:protippz/app/screens/authentication_screen/forgot_password_screen/forgot_password_screen.dart';
import 'package:protippz/app/screens/authentication_screen/otp_screen/otp_screen.dart';
import 'package:protippz/app/screens/authentication_screen/reset_password_screen/reset_password_screen.dart';
import 'package:protippz/app/screens/authentication_screen/sign_in_screen/sign_in_screen.dart';
import 'package:protippz/app/screens/authentication_screen/sign_up_screen/sign_up_screen.dart';
import 'package:protippz/app/screens/contact_screen/contact_screen.dart';
import 'package:protippz/app/screens/deposite_screen/deposite_screen.dart';
import 'package:protippz/app/screens/deposite_screen/inner_screen/deposite_card_screen.dart';
import 'package:protippz/app/screens/faq_screen/faq_screen.dart';
import 'package:protippz/app/screens/favorite_screen/favorite_screen.dart';
import 'package:protippz/app/screens/home_screen/home_screen.dart';
import 'package:protippz/app/screens/invite_screen/invite_screen.dart';
import 'package:protippz/app/screens/no_internet_screen/no_internet_screen.dart';
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
import 'package:protippz/app/screens/tippz_history_screen/tippz_history_screen.dart';
import 'package:protippz/app/screens/tipz_screen/tipz_screen.dart';
import 'package:protippz/app/screens/transaction_screen/transaction_screen.dart';
import 'package:protippz/app/screens/withdraw_screen/inner_screen/withdraw_ach.dart';
import 'package:protippz/app/screens/withdraw_screen/inner_screen/withdraw_card_screen.dart';
import 'package:protippz/app/screens/withdraw_screen/inner_screen/withdraw_check.dart';
import 'package:protippz/app/screens/withdraw_screen/withdraw_screen.dart';

class AppRouter {
  static final GoRouter initRoute = GoRouter(
      initialLocation: RoutePath.splashScreen.addBasePath,
      debugLogDiagnostics: true,
      routes: [
        ///======================= splash Route =======================

        GoRoute(
          name: RoutePath.splashScreen,
          path: RoutePath.splashScreen.addBasePath,
          builder: (context, state) => const SplashScreen(),
          redirect: (context, state) {
            Future.delayed(const Duration(seconds: 2), () {
              AppRouter.route.replaceNamed(RoutePath.signInScreen);
            });
            return null;
          },
        ),

        ///======================= SignIn  Route =======================

        GoRoute(
          name: RoutePath.signInScreen,
          path: RoutePath.signInScreen.addBasePath,
          builder: (context, state) => SignInScreen(),
        ),

        ///======================= SignUp  Route =======================

        GoRoute(
          name: RoutePath.signUpScreen,
          path: RoutePath.signUpScreen.addBasePath,
          builder: (context, state) => SignUpScreen(),
        ),

        ///======================= Forgot password  Route =======================

        GoRoute(
          name: RoutePath.forgotPasswordScreen,
          path: RoutePath.forgotPasswordScreen.addBasePath,
          builder: (context, state) => ForgotPasswordScreen(),
        ),

        ///======================= Otp  Route =======================

        GoRoute(
          name: RoutePath.otpScreen,
          path: RoutePath.otpScreen.addBasePath,
          builder: (context, state) => OtpScreen(),
        ),

        ///======================= Reset Password  Route =======================

        GoRoute(
          name: RoutePath.resetPasswordScreen,
          path: RoutePath.resetPasswordScreen.addBasePath,
          builder: (context, state) => ResetPasswordScreen(),
        ),

        GoRoute(
          name: RoutePath.homeScreen,
          path: RoutePath.homeScreen.addBasePath,
          builder: (context, state) => HomeScreen(),
        ),

        GoRoute(
          name: RoutePath.notificationScreen,
          path: RoutePath.notificationScreen.addBasePath,
          builder: (context, state) => NotificationScreen(),
        ),

        GoRoute(
          name: RoutePath.favoriteScreen,
          path: RoutePath.favoriteScreen.addBasePath,
          builder: (context, state) => FavoriteScreen(),
        ),
        GoRoute(
          name: RoutePath.tippzHistoryScreen,
          path: RoutePath.tippzHistoryScreen.addBasePath,
          builder: (context, state) => TippzHistoryScreen(),
        ),
        GoRoute(
          name: RoutePath.profileScreen,
          path: RoutePath.profileScreen.addBasePath,
          builder: (context, state) => const ProfileScreen(),
        ),
        GoRoute(
          name: RoutePath.editProfileScreen,
          path: RoutePath.editProfileScreen.addBasePath,
          builder: (context, state) => EditProfileScreen(),
        ),

        GoRoute(
          name: RoutePath.settingScreen,
          path: RoutePath.settingScreen.addBasePath,
          builder: (context, state) => const SettingScreen(),
        ),
        GoRoute(
          name: RoutePath.changePasswordScreen,
          path: RoutePath.changePasswordScreen.addBasePath,
          builder: (context, state) => const ChangePasswordScreen(),
        ),
        GoRoute(
          name: RoutePath.privacyPolicyScreen,
          path: RoutePath.privacyPolicyScreen.addBasePath,
          builder: (context, state) => const PrivacyPolicyScreen(),
        ),
        GoRoute(
          name: RoutePath.termsConditionScreen,
          path: RoutePath.termsConditionScreen.addBasePath,
          builder: (context, state) => const TermsConditionScreen(),
        ),
        GoRoute(
          name: RoutePath.contactScreen,
          path: RoutePath.contactScreen.addBasePath,
          builder: (context, state) => const ContactScreen(),
        ),
        GoRoute(
          name: RoutePath.faqScreen,
          path: RoutePath.faqScreen.addBasePath,
          builder: (context, state) => const FaqScreen(),
        ),
        GoRoute(
          name: RoutePath.inviteScreen,
          path: RoutePath.inviteScreen.addBasePath,
          builder: (context, state) => const InviteScreen(),
        ),
        GoRoute(
          name: RoutePath.transactionScreen,
          path: RoutePath.transactionScreen.addBasePath,
          builder: (context, state) => const TransactionScreen(),
        ),
        GoRoute(
          name: RoutePath.withdrawScreen,
          path: RoutePath.withdrawScreen.addBasePath,
          builder: (context, state) => const WithdrawScreen(),
        ),
        GoRoute(
          name: RoutePath.withdrawCardScreen,
          path: RoutePath.withdrawCardScreen.addBasePath,
          builder: (context, state) => const WithdrawCardScreen(),
        ),
        GoRoute(
          name: RoutePath.withdrawAch,
          path: RoutePath.withdrawAch.addBasePath,
          builder: (context, state) => const WithdrawAch(),
        ),
        GoRoute(
          name: RoutePath.withdrawCheck,
          path: RoutePath.withdrawCheck.addBasePath,
          builder: (context, state) => const WithdrawCheck(),
        ),
        GoRoute(
          name: RoutePath.depositeScreen,
          path: RoutePath.depositeScreen.addBasePath,
          builder: (context, state) => const DepositeScreen(),
        ),
        GoRoute(
          name: RoutePath.depositeCardScreen,
          path: RoutePath.depositeCardScreen.addBasePath,
          builder: (context, state) => const DepositeCardScreen(),
        ),
        GoRoute(
          name: RoutePath.tipzScreen,
          path: RoutePath.tipzScreen.addBasePath,
          builder: (context, state) => const TipzScreen(),
        ),
        GoRoute(
          name: RoutePath.playerzScreen,
          path: RoutePath.playerzScreen.addBasePath,
          builder: (context, state) => const PlayerzScreen(),
        ),
        GoRoute(
          name: RoutePath.teamzScreen,
          path: RoutePath.teamzScreen.addBasePath,
          builder: (context, state) => const TeamzScreen(),
        ), GoRoute(
          name: RoutePath.rewardzScreen,
          path: RoutePath.rewardzScreen.addBasePath,
          builder: (context, state) => const RewardzScreen(),
        ),

        ///======================= No Internet Screen   Route =======================
        GoRoute(
          name: RoutePath.noInternetScreen,
          path: RoutePath.noInternetScreen.addBasePath,
          builder: (context, state) => const NoInternetScreen(),
        ),
      ]);

  static GoRouter get route => initRoute;
}
