// To parse this JSON data, do
//
//     final ordersModel = ordersModelFromJson(jsonString);

import 'dart:convert';

List<OrdersModel> ordersModelFromJson(String str) => List<OrdersModel>.from(
    json.decode(str).map((x) => OrdersModel.fromJson(x)));

String ordersModelToJson(List<OrdersModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrdersModel {
  OrdersModel({
    this.id,
    this.clientOrderId,
    this.createdAt,
    this.updatedAt,
    this.submittedAt,
    this.filledAt,
    this.expiredAt,
    this.canceledAt,
    this.failedAt,
    this.replacedAt,
    this.replacedBy,
    this.replaces,
    this.assetId,
    this.symbol,
    this.assetClass,
    this.notional,
    this.qty,
    this.filledQty,
    this.filledAvgPrice,
    this.orderClass,
    this.orderType,
    this.type,
    this.side,
    this.timeInForce,
    this.limitPrice,
    this.stopPrice,
    this.status,
    this.extendedHours,
    this.legs,
    this.trailPercent,
    this.trailPrice,
    this.hwm,
    this.subtag,
    this.source,
  });

  String? id;
  String? clientOrderId;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? submittedAt;
  dynamic filledAt;
  dynamic expiredAt;
  dynamic canceledAt;
  dynamic failedAt;
  dynamic replacedAt;
  dynamic replacedBy;
  dynamic replaces;
  String? assetId;
  String? symbol;
  String? assetClass;
  dynamic notional;
  String? qty;
  String? filledQty;
  dynamic filledAvgPrice;
  String? orderClass;
  String? orderType;
  String? type;
  String? side;
  String? timeInForce;
  dynamic limitPrice;
  dynamic stopPrice;
  String? status;
  bool? extendedHours;
  dynamic legs;
  dynamic trailPercent;
  dynamic trailPrice;
  dynamic hwm;
  dynamic subtag;
  String? source;

  factory OrdersModel.fromJson(Map<String, dynamic> json) => OrdersModel(
        id: json["id"],
        clientOrderId: json["client_order_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        submittedAt: DateTime.parse(json["submitted_at"]),
        filledAt: json["filled_at"],
        expiredAt: json["expired_at"],
        canceledAt: json["canceled_at"],
        failedAt: json["failed_at"],
        replacedAt: json["replaced_at"],
        replacedBy: json["replaced_by"],
        replaces: json["replaces"],
        assetId: json["asset_id"],
        symbol: json["symbol"],
        assetClass: json["asset_class"],
        notional: json["notional"],
        qty: json["qty"],
        filledQty: json["filled_qty"],
        filledAvgPrice: json["filled_avg_price"],
        orderClass: json["order_class"],
        orderType: json["order_type"],
        type: json["type"],
        side: json["side"],
        timeInForce: json["time_in_force"],
        limitPrice: json["limit_price"],
        stopPrice: json["stop_price"],
        status: json["status"],
        extendedHours: json["extended_hours"],
        legs: json["legs"],
        trailPercent: json["trail_percent"],
        trailPrice: json["trail_price"],
        hwm: json["hwm"],
        subtag: json["subtag"],
        source: json["source"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "client_order_id": clientOrderId,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "submitted_at": submittedAt!.toIso8601String(),
        "filled_at": filledAt,
        "expired_at": expiredAt,
        "canceled_at": canceledAt,
        "failed_at": failedAt,
        "replaced_at": replacedAt,
        "replaced_by": replacedBy,
        "replaces": replaces,
        "asset_id": assetId,
        "symbol": symbol,
        "asset_class": assetClass,
        "notional": notional,
        "qty": qty,
        "filled_qty": filledQty,
        "filled_avg_price": filledAvgPrice,
        "order_class": orderClass,
        "order_type": orderType,
        "type": type,
        "side": side,
        "time_in_force": timeInForce,
        "limit_price": limitPrice,
        "stop_price": stopPrice,
        "status": status,
        "extended_hours": extendedHours,
        "legs": legs,
        "trail_percent": trailPercent,
        "trail_price": trailPrice,
        "hwm": hwm,
        "subtag": subtag,
        "source": source,
      };
}
