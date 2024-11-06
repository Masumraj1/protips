import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protippz/app/core/dependency_injection/dependency.dart';
import 'package:protippz/app/core/routes/routes.dart';
import 'package:protippz/app/global/helper/device_utils/device_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DeviceUtils.lockDevicePortrait();
  DependencyInjection di = DependencyInjection();
  di.dependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(393, 852),
        minTextAdapt: true,
        useInheritedMediaQuery: true,
        key: Get.key,
        builder: (context, child) => GetMaterialApp.router(
              debugShowCheckedModeBanner: false,
              routeInformationParser: AppRouter.route.routeInformationParser,
              routerDelegate: AppRouter.route.routerDelegate,
              routeInformationProvider:
                  AppRouter.route.routeInformationProvider,
            ));
  }
}
