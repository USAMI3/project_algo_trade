// ignore_for_file: prefer_const_constructors, unused_import, prefer_const_literals_to_create_immutables, depend_on_referenced_packages

import 'dart:async';
import 'dart:convert';

import 'package:candlesticks/candlesticks.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:project_algo_trade/Commons/commons.dart';
import 'package:project_algo_trade/models/broker_model.dart';
import 'package:project_algo_trade/models/order_model.dart';
import 'package:project_algo_trade/models/position_model.dart';
import 'package:project_algo_trade/screens/Chat/chat_controller.dart';
import 'package:project_algo_trade/screens/charts.dart';
import 'package:http/http.dart' as http;
import 'package:project_algo_trade/screens/home_screen.dart';
import 'package:project_algo_trade/services/api_services.dart';
import 'package:intl/intl.dart';
import 'package:project_algo_trade/shared_pref_class.dart';
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
            child: sharedPrefs.isBotTrading == false
                ? _buildListView(
                    Size(constraints.maxWidth, constraints.maxHeight), context)
                : _buildListViewBot(
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

  @override
  void initState() {
    controller.positionTimer =
        Timer.periodic(const Duration(seconds: 3), (Timer t) async {
      apiRequests.getPositions(
          controller.userModel.apiKey!, controller.userModel.secretKey!);
      setState(() {});
    });
    controller.balanceTimer =
        Timer.periodic(const Duration(seconds: 3), (Timer t) async {
      apiRequests.connectAlpaca(
          controller.userModel.apiKey!, controller.userModel.secretKey!);
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.positionTimer!.cancel();
    controller.balanceTimer!.cancel();
    super.dispose();
  }

  bool isExpanded = false;
  bool isExpanded1 = false;

  Widget _buildListView(Size size, BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Trade Automation =>",
                        style: TextStyle(
                          color: Commons.myGreenColor,
                          fontFamily: 'ColfaxBold',
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    height: MediaQuery.of(context).size.height *
                                        0.3,
                                    decoration: BoxDecoration(
                                      color: Commons.mylightColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SizedBox(
                                            height: 40,
                                            width: 40,
                                            child: Image.asset(
                                                "assets/images/001-bot.png"),
                                          ),
                                          Text(
                                            "Automate Trading?",
                                            style: TextStyle(
                                              color: Commons.myGreenColor,
                                              fontFamily: 'ColfaxBold',
                                              fontSize: 22,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.06,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.26,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    border: Border.all(
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "Decline",
                                                      style: TextStyle(
                                                        color: Colors.red,
                                                        fontFamily:
                                                            'ColfaxBold',
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    sharedPrefs.isBotTrading =
                                                        true;
                                                    Navigator.of(context).pop();
                                                  });
                                                },
                                                child: Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.06,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.26,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.green,
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "Accept",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily:
                                                            'ColfaxBold',
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: SizedBox(
                          height: 60,
                          width: 60,
                          child: Image.asset("assets/images/001-bot.png"),
                        ),
                      ),
                    ],
                  ),
                ),
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
                  height: MediaQuery.of(context).size.height * 0.037,
                  // width: MediaQuery.of(context).size.width * 0.4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Commons.myGreenColor,
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) => ChartsView(
                                link:
                                    "https://s.tradingview.com/tradingview/widgetembed/?frameElementId=tradingview_259ad&symbol=Binance%3ABTCUSD&interval=D&hidesidetoolbar=0&symboledit=1&saveimage=1&toolbarbg=EEEFF0&studies=%5B%5D&hideideas=1&theme=Dark&timezone=exchange&studies_overrides=%7B%7D&overrides=%7B%7D&enabled_features=%5B%5D&disabled_features=%5B%5D&locale=en&utm_source=www.dailyfx.com&utm_medium=widget&utm_campaign=chart&utm_term=FX_IDC%3AEURUSD",
                              ))));
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
                SizedBox(
                  height: 20,
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

                      children: [
                        FutureBuilder<BrokerAccountModel?>(
                          future: apiRequests.connectAlpaca(
                              controller.userModel.apiKey!,
                              controller.userModel.secretKey!),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final data = snapshot.data;
                              final cash = double.tryParse(data!.cash!);
                              final division = cash! / 100;
                              final tradeAmount = division * 2;
                              return Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "Total balance: \$ ${cash.toInt()}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'ColfaxBold',
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "Percentage of portfolio used: 2%",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Colfax',
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "Trade Amount: \$ ${tradeAmount.toInt()}",
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontFamily: 'ColfaxBold',
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              );
                            }
                            return SizedBox();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Commons.mylightColor,
                        borderRadius: BorderRadius.circular(8),
                        border: isExpanded == true
                            ? Border.all(
                                width: 1,
                                color: Colors.green,
                              )
                            : Border.all(
                                color: Commons.mylightColor,
                              )),
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        title: Text("Buy/Sell Forex/Stocks here"),
                        textColor: Colors.green,
                        iconColor: Colors.green,
                        collapsedIconColor: Colors.white,
                        collapsedTextColor: Colors.white,
                        maintainState: true,
                        onExpansionChanged: (value) {
                          setState(() {
                            isExpanded = value;
                          });
                        },
                        children: [
                          Text(
                            "GOOGL",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'ColfaxBold',
                              fontSize: 20,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 40, horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: 50,
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  decoration: BoxDecoration(
                                    color: Commons.myGreenColor,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: TextButton(
                                    child: const Text(
                                      "Buy",
                                      style: TextStyle(
                                        color: Color.fromRGBO(255, 255, 255, 1),
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18,
                                        fontFamily: 'ColfaxBold',
                                      ),
                                    ),
                                    onPressed: () {
                                      dashboardController
                                          .getTradeData(
                                              "GOOGL",
                                              controller.userModel.apiKey!,
                                              controller.userModel.secretKey!)
                                          .then((value) => Commons.showSnackBar(
                                              "Alert",
                                              "Order placed successfully"));

                                      setState(() {});
                                    },
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: TextButton(
                                    child: const Text(
                                      "Sell",
                                      style: TextStyle(
                                        color: Color.fromRGBO(255, 255, 255, 1),
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18,
                                        fontFamily: 'ColfaxBold',
                                      ),
                                    ),
                                    onPressed: () {
                                      dashboardController
                                          .getTradeDataSell(
                                              "GOOGL",
                                              controller.userModel.apiKey!,
                                              controller.userModel.secretKey!)
                                          .then((value) => Commons.showSnackBar(
                                              "Alert",
                                              "Order placed successfully"));

                                      setState(() {});
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Commons.mylightColor,
                        borderRadius: BorderRadius.circular(8),
                        border: isExpanded1 == true
                            ? Border.all(
                                width: 1,
                                color: Colors.green,
                              )
                            : Border.all(
                                color: Commons.mylightColor,
                              )),
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        title: Text("Buy/Sell Crypto here"),
                        textColor: Colors.green,
                        iconColor: Colors.green,
                        collapsedIconColor: Colors.white,
                        collapsedTextColor: Colors.white,
                        maintainState: true,
                        onExpansionChanged: (value) {
                          setState(() {
                            isExpanded1 = value;
                          });
                        },
                        children: [
                          Text(
                            "BTC/USD",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'ColfaxBold',
                              fontSize: 20,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 40, horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: 50,
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  decoration: BoxDecoration(
                                    color: Commons.myGreenColor,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: TextButton(
                                    child: const Text(
                                      "Buy",
                                      style: TextStyle(
                                        color: Color.fromRGBO(255, 255, 255, 1),
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18,
                                        fontFamily: 'ColfaxBold',
                                      ),
                                    ),
                                    onPressed: () {
                                      dashboardController
                                          .getCryptoTradeData(
                                              "BTCUSD",
                                              controller.userModel.apiKey!,
                                              controller.userModel.secretKey!)
                                          .then((value) => Commons.showSnackBar(
                                              "Alert",
                                              "Order placed successfully"));

                                      setState(() {});
                                    },
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: TextButton(
                                    child: const Text(
                                      "Sell",
                                      style: TextStyle(
                                        color: Color.fromRGBO(255, 255, 255, 1),
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18,
                                        fontFamily: 'ColfaxBold',
                                      ),
                                    ),
                                    onPressed: () {
                                      dashboardController
                                          .getTradeCryptoDataSell(
                                              "BTCUSD",
                                              controller.userModel.apiKey!,
                                              controller.userModel.secretKey!)
                                          .then((value) => Commons.showSnackBar(
                                              "Alert",
                                              "Order placed successfully"));

                                      setState(() {});
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        "Active Positions",
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
                    return FutureBuilder<List<PositionModel>?>(
                        future: apiRequests.getPositions(
                            controller.userModel.apiKey!,
                            controller.userModel.secretKey!),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                                child: CircularProgressIndicator(
                              color: Colors.white,
                            ));
                          }
                          if (snapshot.hasData) {
                            final data = snapshot.data;

                            return ListView.builder(
                              itemCount: data!.length,
                              key: UniqueKey(),
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              // reverse: true,
                              itemBuilder: (context, index) {
                                final entryPrice =
                                    double.parse(data[index].avgEntryPrice!);
                                final currentPrice =
                                    double.parse(data[index].currentPrice!);

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
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                        Text(
                                                          " ${data[index].symbol}",
                                                          style: TextStyle(
                                                            color: Colors.green,
                                                            fontFamily:
                                                                'ColfaxBold',
                                                            fontSize: 14,
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
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                        Text(
                                                          "${data[index].qty}",
                                                          style: TextStyle(
                                                            color: Colors.green,
                                                            fontFamily:
                                                                'ColfaxBold',
                                                            fontSize: 14,
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
                                                          "Unrealized PnL: ",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontFamily:
                                                                'ColfaxBold',
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                        Text(
                                                          "\$ ${data[index].unrealizedPl}",
                                                          style: TextStyle(
                                                            color: Colors.green,
                                                            fontFamily:
                                                                'ColfaxBold',
                                                            fontSize: 14,
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
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                        Text(
                                                          "${data[index].side}",
                                                          style: TextStyle(
                                                            color: Colors.green,
                                                            fontFamily:
                                                                'ColfaxBold',
                                                            fontSize: 14,
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
                                                        apiRequests
                                                            .deletePosition(
                                                                data[index]
                                                                    .symbol!,
                                                                controller
                                                                    .userModel
                                                                    .apiKey!,
                                                                controller
                                                                    .userModel
                                                                    .secretKey!)
                                                            .then((value) => Commons
                                                                .showSnackBar(
                                                                    "Alert",
                                                                    "Position closed successfully"));
                                                      },
                                                      child: Container(
                                                          height: 30,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.red,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          child: Center(
                                                              child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(
                                                              "Close Position",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 14,
                                                                  fontFamily:
                                                                      'ColfaxBold'),
                                                            ),
                                                          ))),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      "Entry price: \$ ${entryPrice.toInt()}",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily:
                                                            'ColfaxBold',
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      "Market price: \$ ${currentPrice.toInt()}",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily:
                                                            'ColfaxBold',
                                                        fontSize: 12,
                                                      ),
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

  Widget _buildListViewBot(Size size, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      sharedPrefs.isBotTrading = false;
                    });
                  },
                  child: Text(
                    "Switch back to manual trading?",
                    style: TextStyle(
                      color: Colors.red,
                      fontFamily: 'ColfaxBold',
                      fontSize: 17,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 150,
                  width: 150,
                  child: Image.asset("assets/images/001-bot.png"),
                ),
                FutureBuilder<BrokerAccountModel?>(
                  future: apiRequests.connectAlpaca(
                      controller.userModel.apiKey!,
                      controller.userModel.secretKey!),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final data = snapshot.data;
                      final cash = double.tryParse(data!.cash!);

                      return Text(
                        "Total balance: \$ ${cash!.toInt()}",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'ColfaxBold',
                          fontSize: 17,
                        ),
                      );
                    }
                    return SizedBox();
                  },
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Your trading is being automated!",
                  style: TextStyle(
                    color: Commons.myGreenColor,
                    fontFamily: 'ColfaxBold',
                    fontSize: 17,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Cheers 🎉",
                  style: TextStyle(
                    color: Commons.myGreenColor,
                    fontFamily: 'ColfaxBold',
                    fontSize: 17,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              "Current Positions",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'ColfaxBold',
                fontSize: 18,
              ),
            ),
            GetBuilder<DashboardController>(
              builder: (ccontroller) {
                return FutureBuilder<List<PositionModel>?>(
                    future: apiRequests.getPositions(
                        controller.userModel.apiKey!,
                        controller.userModel.secretKey!),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                            child: CircularProgressIndicator(
                          color: Colors.white,
                        ));
                      }
                      if (snapshot.hasData) {
                        final data = snapshot.data;

                        return ListView.builder(
                          itemCount: data!.length,
                          key: UniqueKey(),
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          // reverse: true,
                          itemBuilder: (context, index) {
                            final entryPrice =
                                double.parse(data[index].avgEntryPrice!);
                            final currentPrice =
                                double.parse(data[index].currentPrice!);

                            return Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  // height: MediaQuery.of(context).size.height * 0.15,
                                  width:
                                      MediaQuery.of(context).size.width * 0.95,
                                  decoration: BoxDecoration(
                                    color: Commons.mylightColor,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
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
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    Text(
                                                      " ${data[index].symbol}",
                                                      style: TextStyle(
                                                        color: Colors.green,
                                                        fontFamily:
                                                            'ColfaxBold',
                                                        fontSize: 14,
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
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    Text(
                                                      "${data[index].qty}",
                                                      style: TextStyle(
                                                        color: Colors.green,
                                                        fontFamily:
                                                            'ColfaxBold',
                                                        fontSize: 14,
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
                                                      "Unrealized PnL: ",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily:
                                                            'ColfaxBold',
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    Text(
                                                      "\$ ${data[index].unrealizedPl}",
                                                      style: TextStyle(
                                                        color: Colors.green,
                                                        fontFamily:
                                                            'ColfaxBold',
                                                        fontSize: 14,
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
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    Text(
                                                      "${data[index].side}",
                                                      style: TextStyle(
                                                        color: Colors.green,
                                                        fontFamily:
                                                            'ColfaxBold',
                                                        fontSize: 14,
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
                                                    const EdgeInsets.all(8.0),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    apiRequests
                                                        .deletePosition(
                                                            data[index].symbol!,
                                                            controller.userModel
                                                                .apiKey!,
                                                            controller.userModel
                                                                .secretKey!)
                                                        .then((value) => Commons
                                                            .showSnackBar(
                                                                "Alert",
                                                                "Position closed successfully"));
                                                  },
                                                  child: Container(
                                                      height: 40,
                                                      decoration: BoxDecoration(
                                                        color: Colors.red,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Center(
                                                          child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          "Close Position",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 16,
                                                              fontFamily:
                                                                  'ColfaxBold'),
                                                        ),
                                                      ))),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "Entry price: \$ ${entryPrice.toInt()}",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'ColfaxBold',
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "Market price: \$ ${currentPrice.toInt()}",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'ColfaxBold',
                                                    fontSize: 12,
                                                  ),
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
  final dashboardController = Get.put(DashboardController());

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
