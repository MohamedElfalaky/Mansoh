import 'dart:convert';

import '../advisor_profile_model/advisor_profile.dart';

OrdersFiltersModel ordersFiltersModelFromJson(dynamic str) =>
    OrdersFiltersModel.fromJson(str);

String ordersFiltersModelToJson(OrdersFiltersModel data) =>
    json.encode(data.toJson());

class OrdersFiltersModel {
  List<OrderFilterData>? data;
  dynamic status;
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
            : List<OrderFilterData>.from(
                json["data"]!.map((x) => OrderFilterData.fromJson(x))),
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

class OrderFilterData {
  dynamic id;
  String? name;
  dynamic price;
  String? date;
  Status? status;
  String? description;
  AdviserProfileData? adviser;
  Status? label;

  OrderFilterData(
      {this.id,
      this.name,
      this.price,
      this.description,
      this.date,
      this.status,
      this.adviser,
      this.label});

  factory OrderFilterData.fromJson(Map<String, dynamic> json) =>
      OrderFilterData(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        description: json["description"] ?? "",
        price: json["price"] ?? 0,
        date: json["date"] ?? "",
        status: json["status"] == null ? null : Status.fromJson(json["status"]),
        label: json["label"] == null ? null : Status.fromJson(json["label"]),
        adviser: json["adviser"] == null
            ? null
            : AdviserProfileData.fromJson(json["adviser"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "name": name,
        "price": price,
        "date": date,
        "status": status?.toJson(),
        "adviser": adviser?.toJson(),
      };
}

class Status {
  dynamic id;
  String? name;
  Status({this.id, this.name});

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
