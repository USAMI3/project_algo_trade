// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:convert';

import 'package:candlesticks/candlesticks.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:project_algo_trade/Commons/commons.dart';
import 'package:project_algo_trade/models/broker_model.dart';
import 'package:project_algo_trade/models/order_model.dart';
import 'package:project_algo_trade/screens/Chat/chat_controller.dart';
import 'package:project_algo_trade/screens/charts.dart';
import 'package:http/http.dart' as http;
import 'package:project_algo_trade/services/api_services.dart';
import 'package:intl/intl.dart';
import '../controllers/dashboard_controller.dart';

class BotScreen extends StatefulWidget {
  const BotScreen({Key? key}) : super(key: key);

  @override
  State<BotScreen> createState() => _BotScreenState();
}

class _BotScreenState extends State<BotScreen> {
  final controller = Get.put(ChatController());
  final dashboardController = Get.put(DashboardController());

  final apiRequests = ApiRequests();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Commons.mainThemeColor,
        body: SafeArea(child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
            child: _buildListView(
                Size(constraints.maxWidth, constraints.maxHeight), context),
          );
        })));
  }

  getCash() {
    if (dashboardController.brokerAccountModel != null) {
      return dashboardController.brokerAccountModel!.regtBuyingPower;
    }
    return "null";
  }

  getTradeAmount() {
    if (dashboardController.brokerAccountModel != null) {
      var cash = dashboardController.brokerAccountModel!.cash;
      var divison = int.tryParse(cash.toString())! / 100;
      var totalAmount = divison * 2;
      return totalAmount;
    }
    return "null";
  }

  Widget _buildListView(Size size, BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                // Container(
                //   height: MediaQuery.of(context).size.height * 0.4,
                //   width: MediaQuery.of(context).size.width * 0.95,
                //   decoration: BoxDecoration(
                //     color: Commons.mylightColor,
                //     borderRadius: BorderRadius.circular(16),
                //   ),
                //   child: Center(
                //     child: ChartsView(
                //       link:
                //           "https://s.tradingview.com/tradingview/widgetembed/?frameElementId=tradingview_259ad&symbol=FX_IDC%3AEURUSD&interval=D&hidesidetoolbar=0&symboledit=1&saveimage=1&toolbarbg=EEEFF0&studies=%5B%5D&hideideas=1&theme=Dark&timezone=exchange&studies_overrides=%7B%7D&overrides=%7B%7D&enabled_features=%5B%5D&disabled_features=%5B%5D&locale=en&utm_source=www.dailyfx.com&utm_medium=widget&utm_campaign=chart&utm_term=FX_IDC%3AEURUSD",
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.95,
                  decoration: BoxDecoration(
                    color: Commons.mylightColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FutureBuilder<BrokerAccountModel?>(
                          future: apiRequests.connectAlpaca(
                              controller.userModel.apiKey!,
                              controller.userModel.secretKey!),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final data = snapshot.data;
                              return Text(
                                "Total balance: ${data!.buyingPower}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'ColfaxBold',
                                  fontSize: 16,
                                ),
                              );
                            }
                            return SizedBox();
                          },
                        ),
                        Text(
                          "Percentage of portfolio used: 2%",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Colfax',
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "Trade Amount: 4000",
                          style: TextStyle(
                            color: Colors.green,
                            fontFamily: 'ColfaxBold',
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                          color: Commons.myGreenColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: TextButton(
                          child: const Text(
                            "Place Order",
                            style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              fontFamily: 'ColfaxBold',
                            ),
                          ),
                          onPressed: () {
                            dashboardController.getTradeData(
                                "GOOGL",
                                controller.userModel.apiKey!,
                                controller.userModel.secretKey!);
                            apiRequests.getOrders(controller.userModel.apiKey!,
                                controller.userModel.secretKey!);
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        "Active Orders",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'ColfaxBold',
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                GetBuilder<DashboardController>(
                  builder: (ccontroller) {
                    return FutureBuilder<List<OrdersModel>?>(
                        future: apiRequests.getOrders(
                            controller.userModel.apiKey!,
                            controller.userModel.secretKey!),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final data = snapshot.data;
                            return ListView.builder(
                              itemCount: data!.length,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              // reverse: true,
                              itemBuilder: (context, index) {
                                print(data.length);
                                var dt = data[index].createdAt;
                                var d2 = DateFormat('dd MMM yyyy').format(dt!);
                                print(d2);
                                return Column(
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      // height: MediaQuery.of(context).size.height * 0.15,
                                      width: MediaQuery.of(context).size.width *
                                          0.95,
                                      decoration: BoxDecoration(
                                        color: Commons.mylightColor,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Symbol:",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontFamily:
                                                                'ColfaxBold',
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                        Text(
                                                          " ${data[index].symbol}",
                                                          style: TextStyle(
                                                            color: Colors.green,
                                                            fontFamily:
                                                                'ColfaxBold',
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Quantity: ",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontFamily:
                                                                'ColfaxBold',
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                        Text(
                                                          "${data[index].qty}",
                                                          style: TextStyle(
                                                            color: Colors.green,
                                                            fontFamily:
                                                                'ColfaxBold',
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Created at: ",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontFamily:
                                                                'ColfaxBold',
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                        Text(
                                                          d2,
                                                          style: TextStyle(
                                                            color: Colors.green,
                                                            fontFamily:
                                                                'ColfaxBold',
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Order Type: ",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontFamily:
                                                                'ColfaxBold',
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                        Text(
                                                          "${data[index].side}",
                                                          style: TextStyle(
                                                            color: Colors.green,
                                                            fontFamily:
                                                                'ColfaxBold',
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Spacer(),
                                              Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        apiRequests.deleteOrders(
                                                            data[index]
                                                                .id
                                                                .toString(),
                                                            controller.userModel
                                                                .apiKey!,
                                                            controller.userModel
                                                                .secretKey!);
                                                        apiRequests.getOrders(
                                                            controller.userModel
                                                                .apiKey!,
                                                            controller.userModel
                                                                .secretKey!);
                                                        setState(() {});
                                                      },
                                                      child: Container(
                                                          height: 40,
                                                          width: 60,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.red,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          child: Center(
                                                              child: Text(
                                                            "Sell",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 16,
                                                                fontFamily:
                                                                    'ColfaxBold'),
                                                          ))),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                          return SizedBox();
                        });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChartView extends StatefulWidget {
  const ChartView({super.key});

  @override
  State<ChartView> createState() => _ChartViewState();
}

class _ChartViewState extends State<ChartView> {
  List<Candle> candles = [];
  bool themeIsDark = false;
  final controller = Get.put(ChatController());

  @override
  void initState() {
    controller.timer =
        Timer.periodic(const Duration(seconds: 3), (Timer t) async {
      fetchCandles().then((value) {
        setState(() {
          candles = value;
        });
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    controller.timer!.cancel();
    super.dispose();
  }

  Future<List<Candle>> fetchCandles() async {
    final uri = Uri.parse(
        "https://api.binance.com/api/v3/klines?symbol=BTCUSDT&interval=5m");
    final res = await http.get(uri);
    return (jsonDecode(res.body) as List<dynamic>)
        .map((e) => Candle.fromJson(e))
        .toList()
        .reversed
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Commons.mainThemeColor,
        //   title: Text("BTCUSDT 1H Chart"),
        //   actions: [
        //     IconButton(
        //       onPressed: () {
        //         setState(() {
        //           themeIsDark = !themeIsDark;
        //         });
        //       },
        //       icon: Icon(
        //         themeIsDark
        //             ? Icons.wb_sunny_sharp
        //             : Icons.nightlight_round_outlined,
        //       ),
        //     )
        //   ],
        // ),
        body: Center(
          child: Candlesticks(
            candles: candles,
          ),
        ),
      ),
    );
  }
}
