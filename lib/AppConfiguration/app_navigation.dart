// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;
// import 'package:project_algo_trade/Commons/commons.dart';
// import 'package:project_algo_trade/controllers/dashboard_controller.dart';
// import 'package:project_algo_trade/screens/bot_screen.dart';
// import 'package:project_algo_trade/screens/Chat/chat_screen.dart';
// import 'package:project_algo_trade/screens/home_screen.dart';
// import 'package:project_algo_trade/screens/settings_screen.dart';

// class DashBoardPage extends StatefulWidget {
//   const DashBoardPage({Key? key}) : super(key: key);

//   @override
//   State<DashBoardPage> createState() => _DashBoardPageState();
// }

// class _DashBoardPageState extends State<DashBoardPage> {
//   final DashboardController dashBoardController =
//       Get.put(DashboardController());

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<DashboardController>(builder: (controller) {
//       return WillPopScope(
//         onWillPop: () async => false,
//         child: Scaffold(
//           backgroundColor: Commons.mainThemeColor,
//           bottomNavigationBar: !kIsWeb
//               ? ClipRRect(
//                   borderRadius: const BorderRadius.only(
//                       topLeft: Radius.circular(16),
//                       topRight: Radius.circular(16)),
//                   child: BottomNavigationBar(
//                     type: BottomNavigationBarType.fixed,
//                     iconSize: 18,
//                     backgroundColor: Commons.mylightColor,
//                     elevation: 0,
//                     unselectedItemColor: Colors.white,
//                     selectedItemColor: Colors.green,
//                     onTap: controller.changeTabIndex,
//                     currentIndex: controller.tabIndex,
//                     items: const [
//                       BottomNavigationBarItem(
//                         // icon: Icon(Icons.home_filled),
//                         icon: Icon(Icons.home),
//                         label: 'Home',
//                       ),
//                       BottomNavigationBarItem(
//                         // icon: Icon(Icons.home_filled),
//                         icon: Icon(Icons.rocket_launch),
//                         label: 'Algo',
//                       ),
//                       BottomNavigationBarItem(
//                         // icon: Icon(MessageIcon.message),
//                         icon: Icon(Icons.messenger),
//                         //  Icon(MessageIcon.message),
//                         label: 'Chats',
//                       ),
//                       BottomNavigationBarItem(
//                         icon: Icon(Icons.settings),
//                         label: 'Settings',
//                       ),
//                     ],
//                   ),
//                 )
//               : null,
//           body: SafeArea(
//             child: IndexedStack(
//               index: controller.tabIndex,
//               children: const [
//                 HomeScreen(),
//                 BotScreen(),
//                 ChatScreen(),
//                 SettingsScreen(),
//               ],
//             ),
//           ),
//         ),
//       );
//     });
//   }
// }
// ignore_for_file: sized_box_for_whitespace, file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:project_algo_trade/Commons/commons.dart';
import 'package:project_algo_trade/screens/Chat/chat_screen.dart';
import 'package:project_algo_trade/screens/bot_screen.dart';
import 'package:project_algo_trade/screens/home_screen.dart';
import 'package:project_algo_trade/screens/news_screen.dart';
import 'package:project_algo_trade/screens/settings_screen.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({Key? key}) : super(key: key);

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  int currentIndex = 0;

  // final chatController = Get.put(ChatController());

  List<Widget> _buildScreens() {
    return [
      HomeScreen(),
      BotScreen(),
      ChatScreen(),
      NewsScreen(),
      SettingsScreen(),
    ];
  }

  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(
          Icons.home_filled,
        ),
        title: ("Home"),
        activeColorPrimary: Commons.myGreenColor,
        inactiveColorPrimary: Commons.myWhiteColor,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          Icons.rocket_launch,
        ),
        title: ("Algo"),
        activeColorPrimary: Commons.myGreenColor,
        inactiveColorPrimary: Commons.myWhiteColor,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          Icons.messenger,
        ),
        title: ("Chat"),
        activeColorPrimary: Commons.myGreenColor,
        inactiveColorPrimary: Commons.myWhiteColor,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          Icons.newspaper,
        ),
        title: ("News"),
        activeColorPrimary: Commons.myGreenColor,
        inactiveColorPrimary: Commons.myWhiteColor,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          Icons.settings,
        ),
        title: ("Settings"),
        activeColorPrimary: Commons.myGreenColor,
        inactiveColorPrimary: Commons.myWhiteColor,
      ),
    ];
  }

  @override
  void initState() {
    // chatController.getName();
    // chatController.dismounted = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async => false,
        child: PersistentTabView(
          context,
          decoration: NavBarDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          controller: _controller,
          backgroundColor: Commons.mylightColor,
          screens: _buildScreens(),
          items: _navBarsItems(),
          navBarStyle: NavBarStyle.style3,
          hideNavigationBarWhenKeyboardShows: true,
          resizeToAvoidBottomInset: true,
          stateManagement: true,
        ),
      ),
    );
  }
}
