// To parse this JSON data, do
//
//     final paymentListModel = paymentListModelFromJson(jsonString);

import 'dart:convert';

PaymentListModel paymentListModelFromJson(dynamic str) =>
    PaymentListModel.fromJson(str);

String paymentListModelToJson(PaymentListModel data) =>
    json.encode(data.toJson());

class PaymentListModel {
  List<Datum>? data;
  dynamic status;
  String? message;
  List<dynamic>? pagination;

  PaymentListModel({
    this.data,
    this.status,
    this.message,
    this.pagination,
  });

  factory PaymentListModel.fromJson(Map<String, dynamic> json) =>
      PaymentListModel(
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
  String? logo;

  Datum({
    this.id,
    this.name,
    this.logo,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        logo: json["logo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "logo": logo,
      };
}
