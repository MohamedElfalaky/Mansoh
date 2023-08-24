// To parse this JSON data, do
//
//     final sendAdviseModel = sendAdviseModelFromJson(jsonString);

import 'dart:convert';

SendAdviseModel sendAdviseModelFromJson(dynamic str) => SendAdviseModel.fromJson(str);

String sendAdviseModelToJson(SendAdviseModel data) => json.encode(data.toJson());

class SendAdviseModel {
  Data? data;
  int? status;
  String? message;
  List<dynamic>? pagination;

  SendAdviseModel({
    this.data,
    this.status,
    this.message,
    this.pagination,
  });

  factory SendAdviseModel.fromJson(Map<String, dynamic> json) => SendAdviseModel(
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
  num? tax;

  Data({
    this.id,
    this.adviser,
    this.price,
    this.tax,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    adviser: json["adviser"] == null ? null : Adviser.fromJson(json["adviser"]),
    price: json["price"],
    tax: json["tax"]??0,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "adviser": adviser?.toJson(),
    "price": price,
    "tax": tax,
  };
}

class Adviser {
  int? id;
  String? avatar;
  String? description;
  String? fullName;
  String? info;
  String? experienceYear;
  List<Category>? category;
  List<dynamic>? document;

  Adviser({
    this.id,
    this.avatar,
    this.description,
    this.fullName,
    this.info,
    this.experienceYear,
    this.category,
    this.document,
  });

  factory Adviser.fromJson(Map<String, dynamic> json) => Adviser(
    id: json["id"],
    avatar: json["avatar"],
    description: json["description"],
    fullName: json["full_name"],
    info: json["info"],
    experienceYear: json["experience_year"],
    category: json["category"] == null ? [] : List<Category>.from(json["category"]!.map((x) => Category.fromJson(x))),
    document: json["document"] == null ? [] : List<dynamic>.from(json["document"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "avatar": avatar,
    "description": description,
    "full_name": fullName,
    "info": info,
    "experience_year": experienceYear,
    "category": category == null ? [] : List<dynamic>.from(category!.map((x) => x.toJson())),
    "document": document == null ? [] : List<dynamic>.from(document!.map((x) => x)),
  };
}

class Category {
  int? id;
  String? name;

  Category({
    this.id,
    this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
