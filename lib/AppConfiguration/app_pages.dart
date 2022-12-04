import 'package:get/get.dart';
import 'package:project_algo_trade/AppConfiguration/app_navigation.dart';
import 'package:project_algo_trade/AppConfiguration/app_routes.dart';
import 'package:project_algo_trade/Auth/login_screen.dart';
import 'package:project_algo_trade/Auth/register_screen.dart';
import 'package:project_algo_trade/screens/home_screen.dart';

import '../OnBoard Screen/onboard_screen.dart';

class AppPages {
  static var list = [
    GetPage(
      name: AppRoutes.registerScreenRoute,
      page: () => const RegisterScreen(),
    ),
    GetPage(
      name: AppRoutes.loginScreenRoute,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: AppRoutes.homeScreenRoute,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: AppRoutes.dashBoardScreenRoute,
      page: () => const DashBoardPage(),
    ),
    GetPage(
      name: AppRoutes.onBoardScreenRoute,
      page: () => const OnBoardScreen(),
    ),
  ];
}
