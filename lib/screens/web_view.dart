import 'dart:async';
import 'dart:convert';

import 'package:candlesticks/candlesticks.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_algo_trade/Commons/commons.dart';
import 'package:project_algo_trade/controllers/dashboard_controller.dart';
import 'package:project_algo_trade/screens/Chat/chat_controller.dart';
import 'package:http/http.dart' as http;

class ChartViewBTC extends StatefulWidget {
  const ChartViewBTC({super.key});

  @override
  State<ChartViewBTC> createState() => _ChartViewBTCState();
}

class _ChartViewBTCState extends State<ChartViewBTC> {
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
        "https://api.binance.com/api/v3/klines?symbol=BTCUSDT&interval=4h");
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
        appBar: AppBar(
          backgroundColor: Commons.mainThemeColor,
          title: const Text("BTCUSDT 1H Chart"),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  themeIsDark = !themeIsDark;
                });
              },
              icon: Icon(
                themeIsDark
                    ? Icons.wb_sunny_sharp
                    : Icons.nightlight_round_outlined,
              ),
            )
          ],
        ),
        body: Center(
          child: Candlesticks(
            candles: candles,
          ),
        ),
      ),
    );
  }
}

class ChartViewETH extends StatefulWidget {
  const ChartViewETH({super.key});

  @override
  State<ChartViewETH> createState() => _ChartViewETHState();
}

class _ChartViewETHState extends State<ChartViewETH> {
  List<Candle> candles = [];
  bool themeIsDark = true;
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
        "https://api.binance.com/api/v3/klines?symbol=ETHUSDT&interval=4h");
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
      theme: themeIsDark ? ThemeData.dark() : ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Commons.mainThemeColor,
          title: const Text("ETH/USDT  1h "),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  themeIsDark = !themeIsDark;
                });
              },
              icon: Icon(
                themeIsDark
                    ? Icons.wb_sunny_sharp
                    : Icons.nightlight_round_outlined,
              ),
            )
          ],
        ),
        body: Center(
          child: Candlesticks(
            candles: candles,
          ),
        ),
      ),
    );
  }
}

class ChartViewBNB extends StatefulWidget {
  const ChartViewBNB({super.key});

  @override
  State<ChartViewBNB> createState() => _ChartViewBNBState();
}

class _ChartViewBNBState extends State<ChartViewBNB> {
  final dashboardController = Get.put(DashboardController());
  List<Candle> candles = [];
  List<Candle> candles1 = [];
  bool themeIsDark = true;
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

  void addData() {
    candles1.add(Candle(
        date: dashboardController.candles!.response![0].tm,
        high: double.parse(dashboardController.candles!.response![0].h),
        low: double.parse(dashboardController.candles!.response![0].l),
        open: double.parse(dashboardController.candles!.response![0].o),
        close: double.parse(dashboardController.candles!.response![0].c),
        volume: double.parse(dashboardController.candles!.response![0].t)));
  }

  @override
  void dispose() {
    controller.timer!.cancel();
    super.dispose();
  }

  Future<List<Candle>> fetchCandles() async {
    final uri = Uri.parse(
        "https://api.binance.com/api/v3/klines?symbol=BNBUSDT&interval=4h");
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
      theme: themeIsDark ? ThemeData.dark() : ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Commons.mainThemeColor,
          title: const Text("BNB/USDT  1h "),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  themeIsDark = !themeIsDark;
                });
              },
              icon: Icon(
                themeIsDark
                    ? Icons.wb_sunny_sharp
                    : Icons.nightlight_round_outlined,
              ),
            )
          ],
        ),
        body: Center(
          child: Candlesticks(
            candles: candles1,
          ),
        ),
      ),
    );
  }
}

class ChartViewADA extends StatefulWidget {
  const ChartViewADA({super.key});

  @override
  State<ChartViewADA> createState() => _ChartViewADAState();
}

class _ChartViewADAState extends State<ChartViewADA> {
  List<Candle> candles = [];
  bool themeIsDark = true;
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
        "https://api.binance.com/api/v3/klines?symbol=ADAUSDT&interval=4h");
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
      theme: themeIsDark ? ThemeData.dark() : ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Commons.mainThemeColor,
          title: const Text("ADA/USDT  1h "),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  themeIsDark = !themeIsDark;
                });
              },
              icon: Icon(
                themeIsDark
                    ? Icons.wb_sunny_sharp
                    : Icons.nightlight_round_outlined,
              ),
            )
          ],
        ),
        body: Center(
          child: Candlesticks(
            candles: candles,
          ),
        ),
      ),
    );
  }
}
