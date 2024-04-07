
import 'dart:convert';

LogOutModel logOutModelFromJson(dynamic str) => LogOutModel.fromJson(str);

String logOutModelToJson(LogOutModel data) => json.encode(data.toJson());

class LogOutModel {
  List<dynamic>? data;
  dynamic status;
  String? message;
  List<dynamic>? pagination;

  LogOutModel({
    this.data,
    this.status,
    this.message,
    this.pagination,
  });

  factory LogOutModel.fromJson(Map<String, dynamic> json) => LogOutModel(
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
