// To parse this JSON data, do
//
//     final accountActivityModel = accountActivityModelFromJson(jsonString);

// ignore_for_file: constant_identifier_names, prefer_conditional_assignment

import 'dart:convert';

List<AccountActivityModel> accountActivityModelFromJson(String str) =>
    List<AccountActivityModel>.from(
        json.decode(str).map((x) => AccountActivityModel.fromJson(x)));

String accountActivityModelToJson(List<AccountActivityModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AccountActivityModel {
  AccountActivityModel({
    this.id,
    this.activityType,
    this.transactionTime,
    this.type,
    this.price,
    this.qty,
    this.side,
    this.symbol,
    this.leavesQty,
    this.orderId,
    this.cumQty,
    this.orderStatus,
  });

  String? id;
  ActivityType? activityType;
  DateTime? transactionTime;
  Type? type;
  String? price;
  String? qty;
  Side? side;
  Symbol? symbol;
  String? leavesQty;
  String? orderId;
  String? cumQty;
  OrderStatus? orderStatus;

  factory AccountActivityModel.fromJson(Map<String, dynamic> json) =>
      AccountActivityModel(
        id: json["id"],
        activityType: activityTypeValues.map![json["activity_type"]],
        transactionTime: DateTime.parse(json["transaction_time"]),
        type: typeValues.map![json["type"]],
        price: json["price"],
        qty: json["qty"],
        side: sideValues.map![json["side"]],
        symbol: symbolValues.map![json["symbol"]],
        leavesQty: json["leaves_qty"],
        orderId: json["order_id"],
        cumQty: json["cum_qty"],
        orderStatus: orderStatusValues.map![json["order_status"]]!,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "activity_type": activityTypeValues.reverse[activityType],
        "transaction_time": transactionTime!.toIso8601String(),
        "type": typeValues.reverse[type],
        "price": price,
        "qty": qty,
        "side": sideValues.reverse[side],
        "symbol": symbolValues.reverse[symbol],
        "leaves_qty": leavesQty,
        "order_id": orderId,
        "cum_qty": cumQty,
        "order_status": orderStatusValues.reverse[orderStatus],
      };
}

enum ActivityType { FILL }

final activityTypeValues = EnumValues({"FILL": ActivityType.FILL});

enum OrderStatus { FILLED, PARTIALLY_FILLED }

final orderStatusValues = EnumValues({
  "filled": OrderStatus.FILLED,
  "partially_filled": OrderStatus.PARTIALLY_FILLED
});

enum Side { BUY, SELL }

final sideValues = EnumValues({"buy": Side.BUY, "sell": Side.SELL});

enum Symbol { BTC_USD, GOOGL }

final symbolValues =
    EnumValues({"BTC/USD": Symbol.BTC_USD, "GOOGL": Symbol.GOOGL});

enum Type { FILL, PARTIAL_FILL }

final typeValues =
    EnumValues({"fill": Type.FILL, "partial_fill": Type.PARTIAL_FILL});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => MapEntry(v, k));
    }
    return reverseMap!;
  }
}
