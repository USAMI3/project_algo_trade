import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_algo_trade/Commons/commons.dart';
import 'package:project_algo_trade/controllers/dashboard_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

// class ChartsView extends StatefulWidget {
//   const ChartsView({super.key});

//   @override
//   State<ChartsView> createState() => _ChartsViewState();
// }

// class _ChartsViewState extends State<ChartsView> {
//   final controller = Get.put(DashboardController());
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       body: SafeArea(
//         child: WebView(
//           initialUrl:
//               controller.chartLinks[0],
//           javascriptMode: JavascriptMode.unrestricted,
//         ),
//       ),
//     );
//   }
// }
class ChartsView extends StatelessWidget {
  final String link;
  ChartsView({super.key, required this.link});
  final dashboardcontroller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WebView(
          onWebViewCreated: (controller) =>
              dashboardcontroller.webController = controller,
          backgroundColor: Commons.mainThemeColor,
          initialUrl: link,
          javascriptMode: JavascriptMode.unrestricted,
          initialMediaPlaybackPolicy:
              AutoMediaPlaybackPolicy.require_user_action_for_all_media_types,
        ),
      ),
    );
  }
}
