import 'package:go_router/go_router.dart';
import 'package:protippz/app/core/routes/route_path.dart';
import 'package:protippz/app/global/helper/extension/base_extension.dart';
import 'package:protippz/app/screens/authentication_screen/sign_in_screen/sign_in_screen.dart';
import 'package:protippz/app/screens/splash_screen/splash_screen.dart';

class AppRouter {
  static final GoRouter initRoute = GoRouter(
      initialLocation: RoutePath.splashScreen.addBasePath,
      // navigatorKey: Get.key,
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

        ///======================= Choose Role Route =======================

        GoRoute(
          name: RoutePath.signInScreen,
          path: RoutePath.signInScreen.addBasePath,
          builder: (context, state) => const SignInScreen(),
        ),

        ///======================= Error Route =======================
      ]);

  static GoRouter get route => initRoute;
}
