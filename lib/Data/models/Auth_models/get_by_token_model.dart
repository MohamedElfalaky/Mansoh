// To parse this JSON data, do
//
//     final getByTokenModel = getByTokenModelFromJson(jsonString);

import 'dart:convert';

GetByTokenModel getByTokenModelFromJson(dynamic str) =>
    GetByTokenModel.fromJson(str);

String getByTokenModelToJson(GetByTokenModel data) =>
    json.encode(data.toJson());

class GetByTokenModel {
  Data? data;
  dynamic status;
  String? message;
  List<dynamic>? pagination;

  GetByTokenModel({
    this.data,
    this.status,
    this.message,
    this.pagination,
  });

  factory GetByTokenModel.fromJson(Map<String, dynamic> json) =>
      GetByTokenModel(
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
  dynamic id;
  String? avatar;
  String? email;
  String? lang;
  String? fullName;
  String? mobile;
  String? token;
  dynamic isNotification;
  String? wallet;

  Data({
    this.id,
    this.avatar,
    this.email,
    this.lang,
    this.fullName,
    this.mobile,
    this.token,
    this.isNotification,
    this.wallet,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        avatar: json["avatar"],
        email: json["email"],
        lang: json["lang"],
        fullName: json["full_name"],
        mobile: json["mobile"],
        token: json["token"],
        isNotification: json["is_notification"],
        wallet: json["wallet"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "avatar": avatar,
        "email": email,
        "lang": lang,
        "full_name": fullName,
        "mobile": mobile,
        "token": token,
        "is_notification": isNotification,
        "wallet": wallet,
      };
}
