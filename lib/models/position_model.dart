// To parse this JSON data, do
//
//     final positionModel = positionModelFromJson(jsonString);

import 'dart:convert';

List<PositionModel> positionModelFromJson(String str) =>
    List<PositionModel>.from(
        json.decode(str).map((x) => PositionModel.fromJson(x)));

String positionModelToJson(List<PositionModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PositionModel {
  PositionModel({
    this.assetId,
    this.symbol,
    this.exchange,
    this.assetClass,
    this.assetMarginable,
    this.qty,
    this.avgEntryPrice,
    this.side,
    this.marketValue,
    this.costBasis,
    this.unrealizedPl,
    this.unrealizedPlpc,
    this.unrealizedIntradayPl,
    this.unrealizedIntradayPlpc,
    this.currentPrice,
    this.lastdayPrice,
    this.changeToday,
    this.qtyAvailable,
  });

  String? assetId;
  String? symbol;
  String? exchange;
  String? assetClass;
  bool? assetMarginable;
  String? qty;
  String? avgEntryPrice;
  String? side;
  String? marketValue;
  String? costBasis;
  String? unrealizedPl;
  String? unrealizedPlpc;
  String? unrealizedIntradayPl;
  String? unrealizedIntradayPlpc;
  String? currentPrice;
  String? lastdayPrice;
  String? changeToday;
  String? qtyAvailable;

  factory PositionModel.fromJson(Map<String, dynamic> json) => PositionModel(
        assetId: json["asset_id"],
        symbol: json["symbol"],
        exchange: json["exchange"],
        assetClass: json["asset_class"],
        assetMarginable: json["asset_marginable"],
        qty: json["qty"],
        avgEntryPrice: json["avg_entry_price"],
        side: json["side"],
        marketValue: json["market_value"],
        costBasis: json["cost_basis"],
        unrealizedPl: json["unrealized_pl"],
        unrealizedPlpc: json["unrealized_plpc"],
        unrealizedIntradayPl: json["unrealized_intraday_pl"],
        unrealizedIntradayPlpc: json["unrealized_intraday_plpc"],
        currentPrice: json["current_price"],
        lastdayPrice: json["lastday_price"],
        changeToday: json["change_today"],
        qtyAvailable: json["qty_available"],
      );

  Map<String, dynamic> toJson() => {
        "asset_id": assetId,
        "symbol": symbol,
        "exchange": exchange,
        "asset_class": assetClass,
        "asset_marginable": assetMarginable,
        "qty": qty,
        "avg_entry_price": avgEntryPrice,
        "side": side,
        "market_value": marketValue,
        "cost_basis": costBasis,
        "unrealized_pl": unrealizedPl,
        "unrealized_plpc": unrealizedPlpc,
        "unrealized_intraday_pl": unrealizedIntradayPl,
        "unrealized_intraday_plpc": unrealizedIntradayPlpc,
        "current_price": currentPrice,
        "lastday_price": lastdayPrice,
        "change_today": changeToday,
        "qty_available": qtyAvailable,
      };
}
