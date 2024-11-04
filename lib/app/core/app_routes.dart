



import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:protippz/app/screens/home_screen/home_screen.dart';

class AppRoute {
  AppRoute._();
  ///==================== Initial Routes ====================
  static const String homeScreen = "/HomeScreen";




  static List<GetPage> routes = [
    ///==================== Initial Routes ====================
    GetPage(name: homeScreen, page: () =>  HomeScreen(),),

  ];
}