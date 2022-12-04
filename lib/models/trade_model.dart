// To parse this JSON data, do
//
//     final tradeModel = tradeModelFromJson(jsonString);

import 'dart:convert';

TradeModel tradeModelFromJson(String str) =>
    TradeModel.fromJson(json.decode(str));

String tradeModelToJson(TradeModel data) => json.encode(data.toJson());

class TradeModel {
  TradeModel({
    this.id,
    this.tradeModelClass,
    this.exchange,
    this.symbol,
    this.name,
    this.status,
    this.tradable,
    this.marginable,
    this.maintenanceMarginRequirement,
    this.shortable,
    this.easyToBorrow,
    this.fractionable,
    this.minOrderSize,
    this.minTradeIncrement,
    this.priceIncrement,
  });

  String? id;
  String? tradeModelClass;
  String? exchange;
  String? symbol;
  String? name;
  String? status;
  bool? tradable;
  bool? marginable;
  int? maintenanceMarginRequirement;
  bool? shortable;
  bool? easyToBorrow;
  bool? fractionable;
  String? minOrderSize;
  String? minTradeIncrement;
  String? priceIncrement;

  factory TradeModel.fromJson(Map<String, dynamic> json) => TradeModel(
        id: json["id"],
        tradeModelClass: json["class"],
        exchange: json["exchange"],
        symbol: json["symbol"],
        name: json["name"],
        status: json["status"],
        tradable: json["tradable"],
        marginable: json["marginable"],
        maintenanceMarginRequirement: json["maintenance_margin_requirement"],
        shortable: json["shortable"],
        easyToBorrow: json["easy_to_borrow"],
        fractionable: json["fractionable"],
        minOrderSize: json["min_order_size"],
        minTradeIncrement: json["min_trade_increment"],
        priceIncrement: json["price_increment"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "class": tradeModelClass,
        "exchange": exchange,
        "symbol": symbol,
        "name": name,
        "status": status,
        "tradable": tradable,
        "marginable": marginable,
        "maintenance_margin_requirement": maintenanceMarginRequirement,
        "shortable": shortable,
        "easy_to_borrow": easyToBorrow,
        "fractionable": fractionable,
        "min_order_size": minOrderSize,
        "min_trade_increment": minTradeIncrement,
        "price_increment": priceIncrement,
      };
}
