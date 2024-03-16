// To parse this JSON data, do
//
//     final postRejectModel = postRejectModelFromJson(jsonString);

import 'dart:convert';

PostRejectModel postRejectModelFromJson(dynamic str) =>
    PostRejectModel.fromJson(str);

String postRejectModelToJson(PostRejectModel data) =>
    json.encode(data.toJson());

class PostRejectModel {
  List<dynamic>? data;
  dynamic status;
  String? message;
  List<dynamic>? pagination;

  PostRejectModel({
    this.data,
    this.status,
    this.message,
    this.pagination,
  });

  factory PostRejectModel.fromJson(Map<String, dynamic> json) =>
      PostRejectModel(
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
