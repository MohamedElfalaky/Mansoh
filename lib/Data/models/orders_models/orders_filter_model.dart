// To parse this JSON data, do
//
//     final ordersFiltersModel = ordersFiltersModelFromJson(jsonString);

import 'dart:convert';

OrdersFiltersModel ordersFiltersModelFromJson(dynamic str) => OrdersFiltersModel.fromJson(str);

String ordersFiltersModelToJson(OrdersFiltersModel data) => json.encode(data.toJson());

class OrdersFiltersModel {
  List<Datum>? data;
  int? status;
  String? message;
  List<dynamic>? pagination;

  OrdersFiltersModel({
    this.data,
    this.status,
    this.message,
    this.pagination,
  });

  factory OrdersFiltersModel.fromJson(Map<String, dynamic> json) => OrdersFiltersModel(
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    status: json["status"],
    message: json["message"],
    pagination: json["pagination"] == null ? [] : List<dynamic>.from(json["pagination"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "status": status,
    "message": message,
    "pagination": pagination == null ? [] : List<dynamic>.from(pagination!.map((x) => x)),
  };
}

class Datum {
  int? id;
  String? name;
  int? price;
  String? date;
  Status? status;
  Adviser? adviser;

  Datum({
    this.id,
    this.name,
    this.price,
    this.date,
    this.status,
    this.adviser,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    date: json["date"],
    status: json["status"] == null ? null : Status.fromJson(json["status"]),
    adviser: json["adviser"] == null ? null : Adviser.fromJson(json["adviser"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "date": date,
    "status": status?.toJson(),
    "adviser": adviser?.toJson(),
  };
}

class Adviser {
  int? id;
  String? avatar;
  String? fullName;
  String? rate;
  String? info;

  Adviser({
    this.id,
    this.avatar,
    this.fullName,
    this.rate,
    this.info,
  });

  factory Adviser.fromJson(Map<String, dynamic> json) => Adviser(
    id: json["id"],
    avatar: json["avatar"],
    fullName: json["full_name"],
    rate: json["rate"],
    info: json["info"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "avatar": avatar,
    "full_name": fullName,
    "rate": rate,
    "info": info,
  };
}

class Status {
  int? id;
  String? name;

  Status({
    this.id,
    this.name,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
