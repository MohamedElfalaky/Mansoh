// To parse this JSON data, do
//
//     final payAdviceModel = payAdviceModelFromJson(jsonString);

import 'dart:convert';

PayAdviceModel payAdviceModelFromJson(dynamic str) => PayAdviceModel.fromJson(str);

String payAdviceModelToJson(PayAdviceModel data) => json.encode(data.toJson());

class PayAdviceModel {
  Data? data;
  int? status;
  String? message;
  List<dynamic>? pagination;

  PayAdviceModel({
    this.data,
    this.status,
    this.message,
    this.pagination,
  });

  factory PayAdviceModel.fromJson(Map<String, dynamic> json) => PayAdviceModel(
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
  String? price;
  double? tax;
  double? total;
  Status? status;
  List<dynamic>? documents;

  Data({
    this.id,
    this.adviser,
    this.price,
    this.tax,
    this.total,
    this.status,
    this.documents,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    adviser: json["adviser"] == null ? null : Adviser.fromJson(json["adviser"]),
    price: json["price"],
    tax: json["tax"]?.toDouble(),
    total: json["total"]?.toDouble(),
    status: json["status"] == null ? null : Status.fromJson(json["status"]),
    documents: json["documents"] == null ? [] : List<dynamic>.from(json["documents"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "adviser": adviser?.toJson(),
    "price": price,
    "tax": tax,
    "total": total,
    "status": status?.toJson(),
    "documents": documents == null ? [] : List<dynamic>.from(documents!.map((x) => x)),
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
