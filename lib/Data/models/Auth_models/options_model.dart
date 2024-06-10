// To parse this JSON data, do
//
//     final optionsModel = optionsModelFromJson(jsonString);

import 'dart:convert';

OptionsModel optionsModelFromJson(dynamic str) => OptionsModel.fromJson(str);

String optionsModelToJson(OptionsModel data) => json.encode(data.toJson());

class OptionsModel {
  final List<Datum>? data;
  final int? status;
  final String? message;
  final List<dynamic>? pagination;

  OptionsModel({
    this.data,
    this.status,
    this.message,
    this.pagination,
  });

  factory OptionsModel.fromJson(Map<String, dynamic> json) => OptionsModel(
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
  final int? id;
  final String? name;
  final String? type;

  Datum({
    this.id,
    this.name,
    this.type,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "type": type,
  };
}
