
import 'dart:convert';

import '../advisor_profile_model/advisor_profile.dart';

ShowAdviceModel showAdviceModelFromJson(dynamic str) =>
    ShowAdviceModel.fromJson(str);

String showAdviceModelToJson(ShowAdviceModel data) =>
    json.encode(data.toJson());

class ShowAdviceModel {
  ShowAdviceData? data;
  dynamic status;
  String? message;
  List<dynamic>? pagination;

  ShowAdviceModel({
    this.data,
    this.status,
    this.message,
    this.pagination,
  });

  factory ShowAdviceModel.fromJson(Map<String, dynamic> json) =>
      ShowAdviceModel(
        data:
            json["data"] == null ? null : ShowAdviceData.fromJson(json["data"]),
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

class ShowAdviceData {
  dynamic id;
  AdviserProfileData? adviser;
  dynamic price;
  dynamic tax;
  dynamic total;
  Label? status;
  List<Chat>? chat;
  Label? label;

  ShowAdviceData({
    this.id,
    this.adviser,
    this.price,
    this.tax,
    this.total,
    this.status,
    this.chat,
    this.label,
  });

  factory ShowAdviceData.fromJson(Map<String, dynamic> json) => ShowAdviceData(
        id: json["id"] ?? 0,
        adviser: json["adviser"] == null
            ? null
            : AdviserProfileData.fromJson(json["adviser"]),
        price: json["price"] ?? 0,
        tax: json["tax"],
        total: json["total"],
        status: json["status"] == null ? null : Label.fromJson(json["status"]),
        chat: json["chat"] == null
            ? []
            : List<Chat>.from(json["chat"]!.map((x) => Chat.fromJson(x))),
        label: json["label"] == null ? null : Label.fromJson(json["label"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "adviser": adviser?.toJson(),
        "price": price,
        "tax": tax,
        "total": total,
        "status": status?.toJson(),
        "chat": chat == null
            ? []
            : List<dynamic>.from(chat!.map((x) => x.toJson())),
      };
}

class Label {
  dynamic id;
  String? name;

  Label({
    this.id,
    this.name,
  });

  factory Label.fromJson(Map<String, dynamic> json) => Label(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Chat {
  dynamic id;
  dynamic adviser;
  Client? client;
  String? message;
  String? mediaType;
  List<Document>? document;

  Chat({
    this.id,
    this.adviser,
    this.client,
    this.message,
    this.mediaType,
    this.document,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        id: json["id"],
        adviser: json["adviser"],
        client: json["client"] == null ? null : Client.fromJson(json["client"]),
        message: json["message"],
        mediaType: json["media_type"],
        document: json["document"] == null
            ? []
            : List<Document>.from(
                json["document"]!.map((x) => Document.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "adviser": adviser,
        "client": client?.toJson(),
        "message": message,
        "media_type": mediaType,
        "document": document == null
            ? []
            : List<dynamic>.from(document!.map((x) => x.toJson())),
      };
}

class Client {
  dynamic id;
  String? avatar;
  String? fullName;

  Client({
    this.id,
    this.avatar,
    this.fullName,
  });

  factory Client.fromJson(Map<String, dynamic> json) => Client(
        id: json["id"],
        avatar: json["avatar"],
        fullName: json["full_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "avatar": avatar,
        "full_name": fullName,
      };
}

class Document {
  dynamic id;
  String? file;

  Document({
    this.id,
    this.file,
  });

  factory Document.fromJson(Map<String, dynamic> json) => Document(
        id: json["id"],
        file: json["file"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "file": file,
      };
}
