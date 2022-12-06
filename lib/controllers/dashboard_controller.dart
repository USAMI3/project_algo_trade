// ignore_for_file: depend_on_referenced_packages

import 'package:candlesticks/candlesticks.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:project_algo_trade/Auth/auth_controller.dart';
import 'package:project_algo_trade/Commons/commons.dart';
import 'package:project_algo_trade/models/broker_model.dart';
import 'package:project_algo_trade/models/data_models.dart';
import 'package:project_algo_trade/models/news_model.dart';
import 'package:project_algo_trade/models/order_model.dart';
import 'package:project_algo_trade/models/trade_model.dart';
import 'package:project_algo_trade/services/api_services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:intl/intl.dart';

class DashboardController extends GetxController {
  @override
  void onInit() {
    getHightlightsData();
    getHightlightsData2();
    getHightlightsData3();
    getNewsData();
    setGreet();

    // getHightlightsData4();
    super.onInit();
  }

  navigateUrl(String? url) async {
    var uri = Uri.parse(url.toString());
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw "Could not load url";
    }
  }

  RxBool isLoaded = true.obs;
  var tabIndex = 0;
  final apiRequests = ApiRequests();
  List<Candle> candles1 = [];
  CandleData? candles;
  CandleData? candles2;
  CandleData? candles3;
  CandleData? candles4;

  BrokerAccountModel? brokerAccountModel;
  TradeModel? tradeModel;
  List<OrdersModel>? ordersModel;
  var users = FirebaseFirestore.instance.collection("users");
  static final DateTime now = DateTime.now();
  static final DateFormat formatter = DateFormat('MMMM dd, yyyy');
  final String formatted = formatter.format(now);
  final supportNameController = TextEditingController();
  final supportEmailController = TextEditingController();
  final supportMessageController = TextEditingController();
  late WebViewController webController;
  NewsData? newsData;

  Future<void> getUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    users.doc(user!.uid).get();
  }

  final db = FirebaseFirestore.instance;
  Future<void> uploadTickets() async {
    final messageData = <String, dynamic>{
      "email": supportEmailController.text,
      "mail": supportMessageController.text,
      "name": supportNameController.text,
    };
    await db.collection("mails").add(messageData).then((value) {
      supportNameController.clear();
      supportEmailController.clear();
      supportMessageController.clear();
      Commons.showSnackBar("Notification", "Your request have been received.");
    });
  }

  RxString greet = "".obs;
  void setGreet() {
    final DateTime now = DateTime.now();
    var hours = now.hour;
    if (hours > 17) {
      greet.value = "Good evening";
    } else if (hours > 12) {
      greet.value = "Good afternoon";
    } else if (hours >= 0) {
      greet.value = "Good morning";
    }
  }

  bool isEuroUsd = false;
  bool isGbpUsd = false;
  bool isAudUsd = false;
  bool isUsdJpy = false;
  bool isUsdChf = false;
  List<String> chartLinks = [
    "https://www.tradingview.com/chart/6QQXtc3w/?symbol=FX%3AEURUSD",
    "https://www.tradingview.com/chart/6QQXtc3w/?symbol=FX%3AGBPUSD",
    "https://www.tradingview.com/chart/6QQXtc3w/?symbol=FX%3AUSDJPY",
    "https://www.tradingview.com/chart/6QQXtc3w/?symbol=FX%3AAUDUSD",
    "https://www.tradingview.com/chart/6QQXtc3w/?symbol=FX%3AUSDCHF",
  ];

  void changeTabIndex(int index) async {
    tabIndex = index;
    update();
  }

  Future<void> getHightlightsData() async {
    // isLoading.value = false;
    await apiRequests.getHttpData().then((value) {
      candles = value;
    }).onError((error, stackTrace) {});
    // isLoading.value = false;
  }

  Future<void> getTradeData(
      String symbol, String apiKey, String secretKey) async {
    // isLoading.value = false;
    await apiRequests.buyTrade(symbol, apiKey, secretKey).then((value) {
      tradeModel = value;
      update();
    }).onError((error, stackTrace) {});
    // isLoading.value = false;
  }

  Future<void> getCryptoTradeData(
      String symbol, String apiKey, String secretKey) async {
    // isLoading.value = false;
    await apiRequests.buyCryptoTrade(symbol, apiKey, secretKey).then((value) {
      tradeModel = value;
      update();
    }).onError((error, stackTrace) {});
    // isLoading.value = false;
  }

  Future<void> getTradeCryptoDataSell(
      String symbol, String apiKey, String secretKey) async {
    // isLoading.value = false;
    await apiRequests.sellCryptoTrade(symbol, apiKey, secretKey).then((value) {
      tradeModel = value;
    }).onError((error, stackTrace) {});
    // isLoading.value = false;
  }

  Future<void> getTradeDataSell(
      String symbol, String apiKey, String secretKey) async {
    // isLoading.value = false;
    await apiRequests.sellTrade(symbol, apiKey, secretKey).then((value) {
      tradeModel = value;
    }).onError((error, stackTrace) {});
    // isLoading.value = false;
  }

  Future<void> getOrdersData(String apiKey, String secretKey) async {
    // isLoading.value = false;
    await apiRequests.getOrders(apiKey, secretKey).then((value) {
      ordersModel = value;
    }).onError((error, stackTrace) {});
    // isLoading.value = false;
  }

  Future<void> getPositionsData(String apiKey, String secretKey) async {
    // isLoading.value = false;
    await apiRequests.getOrders(apiKey, secretKey).then((value) {
      ordersModel = value;
    }).onError((error, stackTrace) {});
    // isLoading.value = false;
  }

  Future<void> getAccountData(String apikey, String secretKey) async {
    // isLoading.value = false;
    await apiRequests.connectAlpaca(apikey, secretKey).then((value) {
      brokerAccountModel = value;
    }).onError((error, stackTrace) {});
    // isLoading.value = false;
  }

  Future<void> getHightlightsData2() async {
    // isLoading.value = false;
    await apiRequests.getHttpData2().then((value) {
      candles2 = value;
    }).onError((error, stackTrace) {});
    // isLoading.value = false;
  }

  Future<void> getHightlightsData3() async {
    // isLoading.value = false;
    await apiRequests.getHttpData3().then((value) {
      candles3 = value;
    }).onError((error, stackTrace) {});
    // isLoading.value = false;
  }

  Future<void> getHightlightsData4() async {
    // isLoading.value = false;
    await apiRequests.getHttpData4().then((value) {
      candles4 = value;
    }).onError((error, stackTrace) {});
    // isLoading.value = false;
  }

  Future<void> getNewsData() async {
    // isLoading.value = false;
    await apiRequests.getNewsData().then((value) {
      newsData = value;
    }).onError((error, stackTrace) {});
    // isLoading.value = false;
  }

  bool dismounted = false;
}
