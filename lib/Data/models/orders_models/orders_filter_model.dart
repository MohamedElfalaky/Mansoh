// To parse this JSON data, do
//
//     final ordersFiltersModel = ordersFiltersModelFromJson(jsonString);

import 'dart:convert';

import 'package:nasooh/Data/models/advice_screen_models/show_advice_model.dart';

OrdersFiltersModel ordersFiltersModelFromJson(dynamic str) =>
    OrdersFiltersModel.fromJson(str);

String ordersFiltersModelToJson(OrdersFiltersModel data) =>
    json.encode(data.toJson());

class OrdersFiltersModel {
  List<ShowAdviceData>? data;
  int? status;
  String? message;
  List<dynamic>? pagination;

  OrdersFiltersModel({
    this.data,
    this.status,
    this.message,
    this.pagination,
  });

  factory OrdersFiltersModel.fromJson(Map<String, dynamic> json) =>
      OrdersFiltersModel(
        data: json["data"] == null
            ? []
            : List<ShowAdviceData>.from(
                json["data"]!.map((x) => ShowAdviceData.fromJson(x))),
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
