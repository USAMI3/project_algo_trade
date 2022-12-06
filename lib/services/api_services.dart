import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:project_algo_trade/Commons/commons.dart';
import 'package:project_algo_trade/models/account_activity_model.dart';
import 'package:project_algo_trade/models/data_models.dart';
import 'package:project_algo_trade/models/news_model.dart';

import '../models/broker_model.dart';
import '../models/order_model.dart';
import '../models/position_model.dart';
import '../models/trade_model.dart';

class ApiRequests {
  Future<CandleData?> getHttpData() async {
    var client = http.Client();
    var uri = Uri.parse(
        'https://fcsapi.com/api-v3/forex/latest?id=1&access_key=m7aB2c4qLI3F7y6gJc0Gmv');
    var response = await client.get(
      uri,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      var json = response.body;
      return candleDataFromJson(json);
    } else {
      return null;
    }
  }

  Future<TradeModel> buyTrade(
      String symbol, String apiKey, String secretKey) async {
    try {
      return await Dio().post(
        "https://paper-api.alpaca.markets/v2/orders",
        options: Options(headers: {
          "APCA-API-KEY-ID": apiKey,
          "APCA-API-SECRET-KEY": secretKey,
        }),
        data: {
          "symbol": symbol,
          "qty": 1,
          "side": "buy",
          "type": "market",
          "time_in_force": "day"
        },
      ).then((value) {
        return TradeModel.fromJson(value.data);
      });
    } on DioError catch (e) {
      return TradeModel.fromJson(e.response!.data);
    }
  }

  Future<TradeModel> buyCryptoTrade(
      String symbol, String apiKey, String secretKey) async {
    try {
      return await Dio().post(
        "https://paper-api.alpaca.markets/v2/orders",
        options: Options(headers: {
          "APCA-API-KEY-ID": apiKey,
          "APCA-API-SECRET-KEY": secretKey,
        }),
        data: {
          "symbol": symbol,
          "qty": 0.1,
          "side": "buy",
          "type": "market",
          "time_in_force": "gtc"
        },
      ).then((value) {
        return TradeModel.fromJson(value.data);
      });
    } on DioError catch (e) {
      return TradeModel.fromJson(e.response!.data);
    }
  }

  Future<TradeModel> sellTrade(
      String symbol, String apiKey, String secretKey) async {
    try {
      return await Dio().post(
        "https://paper-api.alpaca.markets/v2/orders",
        options: Options(headers: {
          "APCA-API-KEY-ID": apiKey,
          "APCA-API-SECRET-KEY": secretKey,
        }),
        data: {
          "symbol": symbol,
          "qty": 1,
          "side": "sell",
          "type": "market",
          "time_in_force": "day"
        },
      ).then((value) {
        return TradeModel.fromJson(value.data);
      });
    } on DioError catch (e) {
      return TradeModel.fromJson(e.response!.data);
    }
  }

  Future<TradeModel> sellCryptoTrade(
      String symbol, String apiKey, String secretKey) async {
    try {
      return await Dio().post(
        "https://paper-api.alpaca.markets/v2/orders",
        options: Options(headers: {
          "APCA-API-KEY-ID": apiKey,
          "APCA-API-SECRET-KEY": secretKey,
        }),
        data: {
          "symbol": symbol,
          "qty": 0.1,
          "side": "sell",
          "type": "market",
          "time_in_force": "gtc"
        },
      ).then((value) {
        return TradeModel.fromJson(value.data);
      });
    } on DioError catch (e) {
      return TradeModel.fromJson(e.response!.data);
    }
  }

  Future<List<OrdersModel>?> getOrders(String apiKey, String secretKey) async {
    var client = http.Client();
    var uri = Uri.parse('https://paper-api.alpaca.markets/v2/orders');

    var response = await client.get(
      uri,
      headers: {
        "APCA-API-KEY-ID": apiKey,
        "APCA-API-SECRET-KEY": secretKey,
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      var json = response.body;
      return ordersModelFromJson(json);
    } else {
      return null;
    }
  }

  Future<List<PositionModel>?> getPositions(
      String apiKey, String secretKey) async {
    var client = http.Client();
    var uri = Uri.parse('https://paper-api.alpaca.markets/v2/positions');

    var response = await client.get(
      uri,
      headers: {
        "APCA-API-KEY-ID": apiKey,
        "APCA-API-SECRET-KEY": secretKey,
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      var json = response.body;
      return positionModelFromJson(json);
    } else {
      return null;
    }
  }

  Future<List<AccountActivityModel>?> getAccountActivity(
      String apiKey, String secretKey) async {
    var client = http.Client();
    var uri =
        Uri.parse('https://paper-api.alpaca.markets/v2/account/activities');

    var response = await client.get(
      uri,
      headers: {
        "APCA-API-KEY-ID": apiKey,
        "APCA-API-SECRET-KEY": secretKey,
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      var json = response.body;

      return accountActivityModelFromJson(json);
    } else {
      return null;
    }
  }

  Future deletePosition(String symbol, String apiKey, String secretKey) async {
    var client = http.Client();
    var uri =
        Uri.parse('https://paper-api.alpaca.markets/v2/positions/$symbol');

    var response = await client.delete(
      uri,
      headers: {
        "APCA-API-KEY-ID": apiKey,
        "APCA-API-SECRET-KEY": secretKey,
      },
    );
    if (response.statusCode == 204 || response.statusCode == 201) {
      Commons.showSnackBar("Alert", "Position deleted successfully");
    } else {
      return null;
    }
  }

  Future<BrokerAccountModel?> connectAlpaca(
      String apiKey, String secretKey) async {
    var client = http.Client();
    var uri = Uri.parse('https://paper-api.alpaca.markets/v2/account');

    var response = await client.get(
      uri,
      headers: {
        "APCA-API-KEY-ID": apiKey,
        "APCA-API-SECRET-KEY": secretKey,
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      var json = response.body;
      return brokerAccountModelFromJson(json);
    } else {
      return null;
    }
  }

  Future<BrokerAccountModel?> connectAlpacaOnSignUp(
      String apiKey, String secretKey) async {
    var client = http.Client();
    var uri = Uri.parse('https://paper-api.alpaca.markets/v2/account');

    var response = await client.get(
      uri,
      headers: {
        "APCA-API-KEY-ID": apiKey,
        "APCA-API-SECRET-KEY": secretKey,
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      var json = response.body;
      return brokerAccountModelFromJson(json);
    } else {
      Commons.showSnackBar("Alert", "Invalid API Keys");
      return null;
    }
  }

  Future<NewsData?> getNewsData() async {
    var client = http.Client();
    var uri = Uri.parse(
        'https://forexnewsapi.com/api/v1/category?section=general&items=3&page=1&token=inep8aj0vsvkoeqa7vyovqf9kxg3qg7o19fo6snc');
    var response = await client.get(
      uri,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      var json = response.body;

      return newsDataFromJson(json);
    } else {
      return null;
    }
  }

  Future<CandleData?> getHttpData2() async {
    var client = http.Client();
    var uri = Uri.parse(
        'https://fcsapi.com/api-v3/forex/latest?id=13&access_key=m7aB2c4qLI3F7y6gJc0Gmv');
    var response = await client.get(
      uri,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      var json = response.body;
      return candleDataFromJson(json);
    } else {
      return null;
    }
  }

  Future<CandleData?> getHttpData3() async {
    var client = http.Client();
    var uri = Uri.parse(
        'https://fcsapi.com/api-v3/forex/latest?id=20&access_key=m7aB2c4qLI3F7y6gJc0Gmv');
    var response = await client.get(
      uri,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      var json = response.body;
      return candleDataFromJson(json);
    } else {
      return null;
    }
  }

  Future<CandleData?> getHttpData4() async {
    var client = http.Client();
    var uri = Uri.parse(
        'https://fcsapi.com/api-v3/forex/latest?id=39&access_key=m7aB2c4qLI3F7y6gJc0Gmv');
    var response = await client.get(
      uri,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      var json = response.body;
      return candleDataFromJson(json);
    } else {
      return null;
    }
  }
}
