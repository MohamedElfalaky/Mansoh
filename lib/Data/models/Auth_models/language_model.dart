// To parse this JSON data, do
//
//     final languageModel = languageModelFromJson(jsonString);

import 'dart:convert';

LanguageModel languageModelFromJson(dynamic str) => LanguageModel.fromJson(str);

String languageModelToJson(LanguageModel data) => json.encode(data.toJson());

class LanguageModel {
  List<LanguageData>? data;
  int? status;
  String? message;
  List<dynamic>? pagination;

  LanguageModel({
    this.data,
    this.status,
    this.message,
    this.pagination,
  });

  factory LanguageModel.fromJson(Map<String, dynamic> json) => LanguageModel(
        data: json["data"] == null
            ? []
            : List<LanguageData>.from(
                json["data"]!.map((x) => LanguageData.fromJson(x))),
        status: json["status"],
        message: json["message"] ?? "",
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

class LanguageData {
  int? id;
  String? name;
  String? code;

  LanguageData({
    this.id,
    this.name,
    this.code,
  });

  factory LanguageData.fromJson(Map<String, dynamic> json) => LanguageData(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        code: json["code"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
      };
}
