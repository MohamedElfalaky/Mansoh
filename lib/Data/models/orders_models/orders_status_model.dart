// To parse this JSON data, do
//
//     final ordersStatusModel = ordersStatusModelFromJson(jsonString);

import 'dart:convert';

OrdersStatusModel ordersStatusModelFromJson(dynamic str) =>
    OrdersStatusModel.fromJson(str);

String ordersStatusModelToJson(OrdersStatusModel data) =>
    json.encode(data.toJson());

class OrdersStatusModel {
  List<Datum>? data;
  dynamic status;
  String? message;
  List<dynamic>? pagination;

  OrdersStatusModel({
    this.data,
    this.status,
    this.message,
    this.pagination,
  });

  factory OrdersStatusModel.fromJson(Map<String, dynamic> json) =>
      OrdersStatusModel(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        status: json["status"],
        message: json["message"],
        pagination: json["pagination"] == null
            ? []
            : List<dynamic>.from(json["pagination"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "status": status,
        "message": message,
        "pagination": pagination == null
            ? []
            : List<dynamic>.from(pagination!.map((x) => x)),
      };
}

class Datum {
  dynamic id;
  String? name;

  Datum({
    this.id,
    this.name,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
