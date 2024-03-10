// To parse this JSON data, do
//
//     final mobModel = mobModelFromJson(jsonString);

import 'dart:convert';

MobModel mobModelFromJson(dynamic str) => MobModel.fromJson(str);

String mobModelToJson(MobModel data) => json.encode(data.toJson());

class MobModel {
  final List<dynamic>? data;
  final int? status;
  final String? message;
  final List<dynamic>? pagination;

  MobModel({
    this.data,
    this.status,
    this.message,
    this.pagination,
  });

  factory MobModel.fromJson(Map<String, dynamic> json) => MobModel(
        data: json["data"] == null
            ? []
            : List<dynamic>.from(json["data"]!.map((x) => x)),
        status: json["status"],
        message: json["message"],
        pagination: json["pagination"] == null
            ? []
            : List<dynamic>.from(json["pagination"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
        "status": status,
        "message": message,
        "pagination": pagination == null
            ? []
            : List<dynamic>.from(pagination!.map((x) => x)),
      };
}
