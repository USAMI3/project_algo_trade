import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_algo_trade/AppConfiguration/app_pages.dart';
import 'package:project_algo_trade/AppConfiguration/app_routes.dart';
import 'package:project_algo_trade/controllers/dashboard_controller.dart';
import 'package:project_algo_trade/firebase_options.dart';
import 'package:project_algo_trade/screens/Chat/chat_controller.dart';
import 'package:project_algo_trade/shared_pref_class.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPrefs.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final dashboardController = Get.put(DashboardController());
  final chatController = Get.put(ChatController());
  dashboardController.setGreet();

  await dashboardController.getHightlightsData();
  await dashboardController.getHightlightsData2();
  await dashboardController.getHightlightsData3();
  await dashboardController.getNewsData();

  // chatController.getName(),
  if (FirebaseAuth.instance.currentUser != null) {
    await chatController.getName();
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Algo Trade',
      getPages: AppPages.list,
      initialRoute: sharedPrefs.isLoggedIn == true
          ? AppRoutes.dashBoardScreenRoute
          : AppRoutes.onBoardScreenRoute,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
