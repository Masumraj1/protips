import 'package:go_router/go_router.dart';
import 'package:protippz/app/core/routes/route_path.dart';
import 'package:protippz/app/global/helper/extension/base_extension.dart';
import 'package:protippz/app/screens/authentication_screen/forgot_password_screen/forgot_password_screen.dart';
import 'package:protippz/app/screens/authentication_screen/otp_screen/otp_screen.dart';
import 'package:protippz/app/screens/authentication_screen/reset_password_screen/reset_password_screen.dart';
import 'package:protippz/app/screens/authentication_screen/sign_in_screen/sign_in_screen.dart';
import 'package:protippz/app/screens/authentication_screen/sign_up_screen/sign_up_screen.dart';
import 'package:protippz/app/screens/no_internet_screen/no_internet_screen.dart';
import 'package:protippz/app/screens/splash_screen/splash_screen.dart';

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
              AppRouter.route.replaceNamed(RoutePath.resetPasswordScreen);
            });
            return null;
          },
        ),

        ///======================= SignIn  Route =======================

        GoRoute(
          name: RoutePath.signInScreen,
          path: RoutePath.signInScreen.addBasePath,
          builder: (context, state) =>  SignInScreen(),
        ),

        ///======================= SignUp  Route =======================

        GoRoute(
          name: RoutePath.signUpScreen,
          path: RoutePath.signUpScreen.addBasePath,
          builder: (context, state) =>  SignUpScreen(),
        ),

        ///======================= Forgot password  Route =======================

        GoRoute(
          name: RoutePath.forgotPasswordScreen,
          path: RoutePath.forgotPasswordScreen.addBasePath,
          builder: (context, state) =>  ForgotPasswordScreen(),
        ),

        ///======================= Otp  Route =======================

        GoRoute(
          name: RoutePath.otpScreen,
          path: RoutePath.otpScreen.addBasePath,
          builder: (context, state) =>  OtpScreen(),
        ),

        ///======================= Reset Password  Route =======================

        GoRoute(
          name: RoutePath.resetPasswordScreen,
          path: RoutePath.resetPasswordScreen.addBasePath,
          builder: (context, state) =>  ResetPasswordScreen(),
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
