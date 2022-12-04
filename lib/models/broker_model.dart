// To parse this JSON data, do
//
//     final brokerAccountModel = brokerAccountModelFromJson(jsonString);

import 'dart:convert';

BrokerAccountModel brokerAccountModelFromJson(String str) =>
    BrokerAccountModel.fromJson(json.decode(str));

String brokerAccountModelToJson(BrokerAccountModel data) =>
    json.encode(data.toJson());

class BrokerAccountModel {
  BrokerAccountModel({
    this.id,
    this.accountNumber,
    this.status,
    this.cryptoStatus,
    this.currency,
    this.buyingPower,
    this.regtBuyingPower,
    this.daytradingBuyingPower,
    this.effectiveBuyingPower,
    this.nonMarginableBuyingPower,
    this.bodDtbp,
    this.cash,
    this.accruedFees,
    this.pendingTransferIn,
    this.portfolioValue,
    this.patternDayTrader,
    this.tradingBlocked,
    this.transfersBlocked,
    this.accountBlocked,
    this.createdAt,
    this.tradeSuspendedByUser,
    this.multiplier,
    this.shortingEnabled,
    this.equity,
    this.lastEquity,
    this.longMarketValue,
    this.shortMarketValue,
    this.positionMarketValue,
    this.initialMargin,
    this.maintenanceMargin,
    this.lastMaintenanceMargin,
    this.sma,
    this.daytradeCount,
    this.balanceAsof,
    this.cryptoTier,
  });

  String? id;
  String? accountNumber;
  String? status;
  String? cryptoStatus;
  String? currency;
  String? buyingPower;
  String? regtBuyingPower;
  String? daytradingBuyingPower;
  String? effectiveBuyingPower;
  String? nonMarginableBuyingPower;
  String? bodDtbp;
  String? cash;
  String? accruedFees;
  String? pendingTransferIn;
  String? portfolioValue;
  bool? patternDayTrader;
  bool? tradingBlocked;
  bool? transfersBlocked;
  bool? accountBlocked;
  DateTime? createdAt;
  bool? tradeSuspendedByUser;
  String? multiplier;
  bool? shortingEnabled;
  String? equity;
  String? lastEquity;
  String? longMarketValue;
  String? shortMarketValue;
  String? positionMarketValue;
  String? initialMargin;
  String? maintenanceMargin;
  String? lastMaintenanceMargin;
  String? sma;
  int? daytradeCount;
  DateTime? balanceAsof;
  int? cryptoTier;

  factory BrokerAccountModel.fromJson(Map<String, dynamic> json) =>
      BrokerAccountModel(
        id: json["id"],
        accountNumber: json["account_number"],
        status: json["status"],
        cryptoStatus: json["crypto_status"],
        currency: json["currency"],
        buyingPower: json["buying_power"],
        regtBuyingPower: json["regt_buying_power"],
        daytradingBuyingPower: json["daytrading_buying_power"],
        effectiveBuyingPower: json["effective_buying_power"],
        nonMarginableBuyingPower: json["non_marginable_buying_power"],
        bodDtbp: json["bod_dtbp"],
        cash: json["cash"],
        accruedFees: json["accrued_fees"],
        pendingTransferIn: json["pending_transfer_in"],
        portfolioValue: json["portfolio_value"],
        patternDayTrader: json["pattern_day_trader"],
        tradingBlocked: json["trading_blocked"],
        transfersBlocked: json["transfers_blocked"],
        accountBlocked: json["account_blocked"],
        createdAt: DateTime.parse(json["created_at"]),
        tradeSuspendedByUser: json["trade_suspended_by_user"],
        multiplier: json["multiplier"],
        shortingEnabled: json["shorting_enabled"],
        equity: json["equity"],
        lastEquity: json["last_equity"],
        longMarketValue: json["long_market_value"],
        shortMarketValue: json["short_market_value"],
        positionMarketValue: json["position_market_value"],
        initialMargin: json["initial_margin"],
        maintenanceMargin: json["maintenance_margin"],
        lastMaintenanceMargin: json["last_maintenance_margin"],
        sma: json["sma"],
        daytradeCount: json["daytrade_count"],
        balanceAsof: DateTime.parse(json["balance_asof"]),
        cryptoTier: json["crypto_tier"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "account_number": accountNumber,
        "status": status,
        "crypto_status": cryptoStatus,
        "currency": currency,
        "buying_power": buyingPower,
        "regt_buying_power": regtBuyingPower,
        "daytrading_buying_power": daytradingBuyingPower,
        "effective_buying_power": effectiveBuyingPower,
        "non_marginable_buying_power": nonMarginableBuyingPower,
        "bod_dtbp": bodDtbp,
        "cash": cash,
        "accrued_fees": accruedFees,
        "pending_transfer_in": pendingTransferIn,
        "portfolio_value": portfolioValue,
        "pattern_day_trader": patternDayTrader,
        "trading_blocked": tradingBlocked,
        "transfers_blocked": transfersBlocked,
        "account_blocked": accountBlocked,
        "created_at": createdAt!.toIso8601String(),
        "trade_suspended_by_user": tradeSuspendedByUser,
        "multiplier": multiplier,
        "shorting_enabled": shortingEnabled,
        "equity": equity,
        "last_equity": lastEquity,
        "long_market_value": longMarketValue,
        "short_market_value": shortMarketValue,
        "position_market_value": positionMarketValue,
        "initial_margin": initialMargin,
        "maintenance_margin": maintenanceMargin,
        "last_maintenance_margin": lastMaintenanceMargin,
        "sma": sma,
        "daytrade_count": daytradeCount,
        "balance_asof":
            "${balanceAsof!.year.toString().padLeft(4, '0')}-${balanceAsof!.month.toString().padLeft(2, '0')}-${balanceAsof!.day.toString().padLeft(2, '0')}",
        "crypto_tier": cryptoTier,
      };
}
