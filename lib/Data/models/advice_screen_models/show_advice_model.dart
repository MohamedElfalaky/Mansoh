// To parse this JSON data, do
//
//     final showAdviceModel = showAdviceModelFromJson(jsonString);

import 'dart:convert';

ShowAdviceModel showAdviceModelFromJson(dynamic str) => ShowAdviceModel.fromJson(str);

String showAdviceModelToJson(ShowAdviceModel data) => json.encode(data.toJson());

class ShowAdviceModel {
  Data? data;
  int? status;
  String? message;
  List<dynamic>? pagination;

  ShowAdviceModel({
    this.data,
    this.status,
    this.message,
    this.pagination,
  });

  factory ShowAdviceModel.fromJson(Map<String, dynamic> json) => ShowAdviceModel(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    status: json["status"],
    message: json["message"],
    pagination: json["pagination"] == null ? [] : List<dynamic>.from(json["pagination"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "status": status,
    "message": message,
    "pagination": pagination == null ? [] : List<dynamic>.from(pagination!.map((x) => x)),
  };
}

class Data {
  int? id;
  Adviser? adviser;
  int? price;
  double? tax;
  double? total;
  Status? status;
  List<Chat>? chat;

  Data({
    this.id,
    this.adviser,
    this.price,
    this.tax,
    this.total,
    this.status,
    this.chat,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    adviser: json["adviser"] == null ? null : Adviser.fromJson(json["adviser"]),
    price: json["price"],
    tax: json["tax"]?.toDouble(),
    total: json["total"]?.toDouble(),
    status: json["status"] == null ? null : Status.fromJson(json["status"]),
    chat: json["chat"] == null ? [] : List<Chat>.from(json["chat"]!.map((x) => Chat.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "adviser": adviser?.toJson(),
    "price": price,
    "tax": tax,
    "total": total,
    "status": status?.toJson(),
    "chat": chat == null ? [] : List<dynamic>.from(chat!.map((x) => x.toJson())),
  };
}

class Adviser {
  int? id;
  String? avatar;
  String? fullName;
  String? info;
  String? description;
  List<Status>? category;
  String? rate;

  Adviser({
    this.id,
    this.avatar,
    this.fullName,
    this.info,
    this.description,
    this.category,
    this.rate,
  });

  factory Adviser.fromJson(Map<String, dynamic> json) => Adviser(
    id: json["id"],
    avatar: json["avatar"],
    fullName: json["full_name"],
    info: json["info"],
    description: json["description"],
    category: json["category"] == null ? [] : List<Status>.from(json["category"]!.map((x) => Status.fromJson(x))),
    rate: json["rate"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "avatar": avatar,
    "full_name": fullName,
    "info": info,
    "description": description,
    "category": category == null ? [] : List<dynamic>.from(category!.map((x) => x.toJson())),
    "rate": rate,
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

class Chat {
  int? id;
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
    document: json["document"] == null ? [] : List<Document>.from(json["document"]!.map((x) => Document.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "adviser": adviser,
    "client": client?.toJson(),
    "message": message,
    "media_type": mediaType,
    "document": document == null ? [] : List<dynamic>.from(document!.map((x) => x.toJson())),
  };
}

class Client {
  int? id;
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
  int? id;
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
