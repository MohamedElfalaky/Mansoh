// To parse this JSON data, do
//
//     final checkCodeModel = checkCodeModelFromJson(jsonString);

import 'dart:convert';

CheckCodeModel checkCodeModelFromJson(dynamic str) =>
    CheckCodeModel.fromJson(str);

String checkCodeModelToJson(CheckCodeModel data) => json.encode(data.toJson());

class CheckCodeModel {
  final Data? data;
  final int? status;
  final String? message;
  final List<dynamic>? pagination;

  CheckCodeModel({
    this.data,
    this.status,
    this.message,
    this.pagination,
  });

  factory CheckCodeModel.fromJson(Map<String, dynamic> json) => CheckCodeModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        status: json["status"],
        message: json["message"],
        pagination: json["pagination"] == null
            ? []
            : List<dynamic>.from(json["pagination"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "status": status,
        "message": message,
        "pagination": pagination == null
            ? []
            : List<dynamic>.from(pagination!.map((x) => x)),
      };
}

class Data {
  final int? login;

  Data({
    this.login,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        login: json["login"],
      );

  Map<String, dynamic> toJson() => {
        "login": login,
      };
}
