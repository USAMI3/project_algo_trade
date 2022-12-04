import 'dart:async';

import 'package:candlesticks/candlesticks.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_algo_trade/Commons/commons.dart';
import 'package:project_algo_trade/controllers/dashboard_controller.dart';
import 'package:project_algo_trade/screens/Chat/chat_controller.dart';
import 'package:project_algo_trade/screens/charts.dart';
import 'package:project_algo_trade/screens/pages/advanced_education.dart';
import 'package:project_algo_trade/screens/pages/beginner_education.dart';
import 'package:project_algo_trade/screens/pages/intermediate_education.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final chatController = Get.put(ChatController());
  final dashboardController = Get.put(DashboardController());

  List<Candle> candles = [];
  double btcHigh = 0;
  double ethHigh = 0;
  double adaHigh = 0;
  double bnbHigh = 0;
  @override
  void initState() {
    chatController.adaTimer =
        Timer.periodic(const Duration(seconds: 5), (Timer t) async {
      chatController.getName();
    });
    // chatController.bnbTimer =
    //     Timer.periodic(const Duration(seconds: 1), (Timer t) async {
    //   fetchCandlesBNB().then((value) {
    //     setState(() {
    //       candles = value;
    //       bnbHigh = candles[0].high;
    //     });
    //   });
    // });
    super.initState();
  }

  @override
  void dispose() {
    chatController.adaTimer!.cancel();
    super.dispose();
  }

  // Future<List<Candle>> fetchCandlesADA() async {
  //   final uri = Uri.parse(
  //       "https://api.binance.com/api/v3/klines?symbol=ADAUSDT&interval=4h");
  //   final res = await http.get(uri);
  //   return (jsonDecode(res.body) as List<dynamic>)
  //       .map((e) => Candle.fromJson(e))
  //       .toList()
  //       .reversed
  //       .toList();
  // }

  // Future<List<Candle>> fetchCandlesBNB() async {
  //   final uri = Uri.parse(
  //       "https://api.binance.com/api/v3/klines?symbol=BNBUSDT&interval=4h");
  //   final res = await http.get(uri);
  //   return (jsonDecode(res.body) as List<dynamic>)
  //       .map((e) => Candle.fromJson(e))
  //       .toList()
  //       .reversed
  //       .toList();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Commons.mainThemeColor,
        body: SafeArea(child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return Center(
            child: Container(
              child: _buildListView(
                  Size(constraints.maxWidth, constraints.maxHeight), context),
            ),
          );
        })));
  }

  Widget _buildListView(Size size, BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.all(size.width * 0.055),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${dashboardController.greet.value}! 👋",
                    style: const TextStyle(
                        fontFamily: 'ColfaxBold',
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Commons.myWhiteColor),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "Today's a great day to trade smart 🧠",
                    style: TextStyle(
                      fontFamily: 'Colfax',
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Commons.myWhiteColor,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  // chatController.deleteAll();
                },
                child: ClipOval(
                  child: Container(
                    height: 72,
                    width: 72,
                    decoration: const BoxDecoration(
                      color: Commons.mylightColor,
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Image.asset("assets/images/man.png"),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 9),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // height: MediaQuery.of(context).size.height * 0.4,
                // width: MediaQuery.of(context).size.width * 0.95,
                decoration: BoxDecoration(
                  color: Commons.mylightColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Text(
                          "Top Forex Pairs",
                          style: TextStyle(
                            fontFamily: 'ColfaxBold',
                            fontSize: 22,
                            color: Commons.myWhiteColor,
                          ),
                        )),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        dashboardController.formatted,
                        style: const TextStyle(
                          fontFamily: 'ColfaxBold',
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Commons.myGreenColor,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        BuildSymbolCard(
                          text1: dashboardController.candles!.response![0].s,
                          text2: dashboardController.candles!.response![0].h,
                          screen: ChartsView(
                            link:
                                "https://s.tradingview.com/tradingview/widgetembed/?frameElementId=tradingview_259ad&symbol=FX_IDC%3AEURUSD&interval=D&hidesidetoolbar=0&symboledit=1&saveimage=1&toolbarbg=EEEFF0&studies=%5B%5D&hideideas=1&theme=Dark&timezone=exchange&studies_overrides=%7B%7D&overrides=%7B%7D&enabled_features=%5B%5D&disabled_features=%5B%5D&locale=en&utm_source=www.dailyfx.com&utm_medium=widget&utm_campaign=chart&utm_term=FX_IDC%3AEURUSD",
                          ),
                        ),
                        BuildSymbolCard(
                            text1: dashboardController.candles2!.response![0].s,
                            text2: dashboardController.candles2!.response![0].h,
                            screen: ChartsView(
                              link:
                                  "https://s.tradingview.com/tradingview/widgetembed/?frameElementId=tradingview_259ad&symbol=FX_IDC%3AAUDUSD&interval=D&hidesidetoolbar=0&symboledit=1&saveimage=1&toolbarbg=EEEFF0&studies=%5B%5D&hideideas=1&theme=Dark&timezone=exchange&studies_overrides=%7B%7D&overrides=%7B%7D&enabled_features=%5B%5D&disabled_features=%5B%5D&locale=en&utm_source=www.dailyfx.com&utm_medium=widget&utm_campaign=chart&utm_term=FX_IDC%3AEURUSD",
                            )),
                      ],
                    ),
                    Row(
                      children: [
                        BuildSymbolCard(
                          text1: dashboardController.candles3!.response![0].s,
                          text2: dashboardController.candles3!.response![0].h,
                          screen: ChartsView(
                            link:
                                "https://s.tradingview.com/tradingview/widgetembed/?frameElementId=tradingview_259ad&symbol=FX_IDC%3AUSDJPY&interval=D&hidesidetoolbar=0&symboledit=1&saveimage=1&toolbarbg=EEEFF0&studies=%5B%5D&hideideas=1&theme=Dark&timezone=exchange&studies_overrides=%7B%7D&overrides=%7B%7D&enabled_features=%5B%5D&disabled_features=%5B%5D&locale=en&utm_source=www.dailyfx.com&utm_medium=widget&utm_campaign=chart&utm_term=FX_IDC%3AEURUSD",
                          ),
                        ),
                        BuildSymbolCard(
                            text1: "USD/CHF",
                            text2: "0.9993",
                            screen: ChartsView(
                              link:
                                  "https://s.tradingview.com/tradingview/widgetembed/?frameElementId=tradingview_259ad&symbol=FX_IDC%3AUSDCHF&interval=D&hidesidetoolbar=0&symboledit=1&saveimage=1&toolbarbg=EEEFF0&studies=%5B%5D&hideideas=1&theme=Dark&timezone=exchange&studies_overrides=%7B%7D&overrides=%7B%7D&enabled_features=%5B%5D&disabled_features=%5B%5D&locale=en&utm_source=www.dailyfx.com&utm_medium=widget&utm_campaign=chart&utm_term=FX_IDC%3AEURUSD",
                            )),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),

              // InkWell(
              //   onTap: () {
              //     // dashboardController.addData();
              //   },
              //   child: const Text(
              //     "Learn before you leap",
              //     style: TextStyle(
              //       color: Commons.myWhiteColor,
              //       fontSize: 20,
              //       fontStyle: FontStyle.italic,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // ),

              Container(
                // height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width * 0.95,
                decoration: BoxDecoration(
                  color: Commons.mylightColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Learn before you leap",
                        style: TextStyle(
                          color: Commons.myWhiteColor,
                          fontSize: 20,
                          fontFamily: 'ColfaxBold',
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      BuildCard(
                        text1: "Beginner",
                        text2: "Free",
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: ((context) =>
                                  const BeginnerEducationScreen())));
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      BuildCard(
                        text1: "Intermediate",
                        text2: "Free",
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: ((context) =>
                                  const IntermediateEducationScreen())));
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      BuildCard(
                        text1: "Advanced",
                        text2: "Paid",
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: ((context) =>
                                  const AdvancedEducationScreen())));
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class BuildCard extends StatelessWidget {
  final String text1;
  final String text2;
  final Function() onTap;
  const BuildCard({
    Key? key,
    required this.text1,
    required this.text2,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.98,
      child: Container(
        decoration: BoxDecoration(
          color: Commons.mainThemeColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // SizedBox(
                //   height: 100,
                //   child: Image.asset(
                //     "assets/images/audi.png",
                //   ),
                // ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        text1,
                        style: const TextStyle(
                          color: Commons.myWhiteColor,
                          fontFamily: 'ColfaxBold',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: Row(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.037,
                    width: MediaQuery.of(context).size.width * 0.4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Commons.myGreenColor,
                    ),
                    child: TextButton(
                      onPressed: onTap,
                      child: const Text(
                        "Click to Dive in",
                        style: TextStyle(
                          color: Commons.myWhiteColor,
                          fontSize: 13,
                          fontFamily: 'ColfaxBold',
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.04,
                      width: MediaQuery.of(context).size.width * 0.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          width: 2,
                          color: Commons.myGreenColor,
                        ),
                        // color: MyColors.myGreenColor,
                      ),
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          text2,
                          style: const TextStyle(
                            color: Commons.myWhiteColor,
                            fontSize: 12,
                            fontFamily: 'ColfaxBold',
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BuildSymbolCard extends StatelessWidget {
  final String text1;
  final String text2;
  final Widget screen;
  const BuildSymbolCard({
    Key? key,
    required this.text1,
    required this.text2,
    required this.screen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Commons.mainThemeColor,
          borderRadius: BorderRadius.circular(10),
        ),
        // width: MediaQuery.of(context).size.width * 0.4355,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        text1,
                        style: const TextStyle(
                          color: Commons.myWhiteColor,
                          fontFamily: 'Colfax',
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: Text(
                    text2,
                    style: const TextStyle(
                      color: Commons.myWhiteColor,
                      fontSize: 18,
                      fontFamily: 'ColfaxBold',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.037,
                    // width: MediaQuery.of(context).size.width * 0.4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Commons.myGreenColor,
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: ((context) => screen)));
                      },
                      child: const Text(
                        "Click to View Chart",
                        style: TextStyle(
                          color: Commons.myWhiteColor,
                          fontSize: 13,
                          fontFamily: 'ColfaxBold',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
